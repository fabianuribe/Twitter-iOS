//
//  TwitterClient.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"


@interface TwitterClient : BDBOAuth1RequestOperationManager

@property (nonatomic, strong) User *user;

+ (TwitterClient *)sharedInstance ;

- (void) logInWithCompletion: (void (^)(User *user, NSError *error))completion;
- (void) openUrl: (NSURL *)url;

- (void) getTimeline: (NSString *)timelineType WithParams:(NSDictionary *)params WithCompletion: (void (^)(NSArray *tweetArray, NSError *error))completion ;

- (void) getFavorites: (NSDictionary *)params WithCompletion: (void (^)(NSArray *tweetArray, NSError *error))completion;
- (void) searchTweets: (NSDictionary *)params WithCompletion: (void (^)(NSArray *tweetArray, NSError *error))completion;



- (void) updateStatus:(NSString *) status WithCompetion: (void (^)(NSDictionary *response, NSError *error))completion;
- (void) favoriteTweet:(NSString *) id_str WithCompetion: (void (^)(NSDictionary *response, NSError *error))completion;
- (void) retweetTweet:(NSString *) id_str WithCompetion: (void (^)(NSDictionary *response, NSError *error))completion;



@end
