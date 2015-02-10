//
//  User.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagLine;


- (id)initWithDictionary: (NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser: (User *)user;
+ (void)signOut ;


@end
