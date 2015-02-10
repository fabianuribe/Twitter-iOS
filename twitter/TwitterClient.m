//
//  TwitterClient.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"CxoVjc2KYbygNtaFxRBEUHxk9";
NSString * const kTwitterConsumerSecret = @"E1AINV2u6MQIdTKJK50vCA6E4KI3Em1xkSgapIAiHUzFVJBEXe";
NSString * const kTwitterConsumerBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void (^loginCompletion)(User *user, NSError *error);

@end


@implementation TwitterClient



+ (TwitterClient *)sharedInstance {
    
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterConsumerBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    return instance;
}


- (void) logInWithCompletion: (void (^)(User *user, NSError *error))completion {
    
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        
        NSURL *authURL = [NSURL URLWithString: [NSString stringWithFormat: @"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
        
    } failure:^(NSError *error) {

        self.loginCompletion(nil, error);
    }];
}

- (void) openUrl:(NSURL *)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser: self.user];
            
            self.loginCompletion(self.user, nil);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

            self.loginCompletion(nil, error);
        }];
        
    } failure:^(NSError *error) {
        
        self.loginCompletion(nil, error);
    }];
}


- (void) getTweets: (NSDictionary *)params WithCompletion: (void (^)(NSArray *tweetArray, NSError *error))completion {

    NSLog(@"%@", params[@"since_id"]);
    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSArray *tweetArray = [Tweet tweetsWithArrray:responseObject];
        
        completion(tweetArray, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}


- (void) updateStatus:(NSString *) status WithCompetion: (void (^)(NSDictionary *response, NSError *error))completion  {
    
    NSDictionary *parameters = @{@"status": status};
    
    [self POST:@"1.1/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}

- (void) favoriteTweet:(NSString *) id_str WithCompetion: (void (^)(NSDictionary *response, NSError *error))completion  {
    
    NSDictionary *parameters = @{@"id": id_str};
    
    [self POST:@"1.1/favorites/create.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}

- (void) retweetTweet:(NSString *) id_str WithCompetion: (void (^)(NSDictionary *response, NSError *error))completion  {
    
    NSString *retweetUrl = [[NSString alloc] initWithFormat:@"1.1/statuses/retweet/%@.json", id_str];
    
    [self POST: retweetUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completion(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}



@end
