//
//  User.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;

@end


@implementation User

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
    @try {
            self.dictionary = dictionary;
            self.id_str = dictionary[@"id_srt"];
            self.name = dictionary[@"name"];
            self.screenName = dictionary[@"screen_name"];
            self.profileImageUrl = dictionary[@"profile_image_url"];
            self.backgroundImageUrl = dictionary[@"profile_background_image_url_https"];
            self.tagLine = dictionary[@"description"];
            self.location = dictionary[@"location"];
            self.following = dictionary[@"following"];
            self.followersCount = dictionary[@"followers_count"];
            self.followingCount = dictionary[@"friends_count"];
            self.tweetCount = dictionary[@"statuses_count"];
        
            NSDictionary *userUrl = [dictionary valueForKeyPath:@"entities.url.urls"][0];
            self.website = userUrl[@"display_url"];
        }
        @catch (NSException *theException) {
            NSLog(@"An exception occurred: %@", theException.name);
            NSLog(@"Here are some details: %@", theException.reason);
        }
        
    }
    return self;
}

static User *_currentUser = nil;

NSString * const kCurrentUserKey = @"KCurrrentUserKey";


+ (User *)currentUser {
    
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        
        if (data) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    
    return _currentUser;
}

+ (void)setCurrentUser: (User *)currentUser {
    _currentUser = currentUser;
    
    if (_currentUser) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
        [[NSUserDefaults standardUserDefaults] synchronize ];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
        [[NSUserDefaults standardUserDefaults] synchronize ];
    }
}

+ (void)signOut {
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
}

@end
