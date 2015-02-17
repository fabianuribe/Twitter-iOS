//
//  User.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *id_str;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagLine;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *backgroundImageUrl;
@property (nonatomic, strong) NSString *following;
@property (nonatomic, strong) NSString *followersCount;
@property (nonatomic, strong) NSString *followingCount;
@property (nonatomic, strong) NSString *tweetCount;




- (id)initWithDictionary: (NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser: (User *)user;
+ (void)signOut ;


@end
