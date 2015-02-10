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
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagLine = dictionary[@"name"];
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
