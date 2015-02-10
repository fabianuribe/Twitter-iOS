//
//  Tweet.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSDate * id_str;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSDate * createdAt;
@property (nonatomic, strong) NSString * retweet_count;
@property (nonatomic, strong) NSString * retweeted;
@property (nonatomic, strong) NSString * favorited;
@property (nonatomic, strong) User * user;


- (id)initWithDictionary: (NSDictionary *)dictionary ;

+ (NSArray *)tweetsWithArrray: (NSArray *)array;

@end
