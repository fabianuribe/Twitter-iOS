//
//  Tweet.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/7/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    
    if(self) {
        self.user = [[User alloc] initWithDictionary: dictionary[@"user"]];
        self.text = dictionary[@"text"];
        self.id_str = dictionary[@"id"];
        self.retweeted = dictionary[@"retweeted"];
        self.retweet_count = dictionary[@"retweet_count"];
        self.favorited = dictionary[@"favorited"];
        
        // Since the API doesnt provide "favorites" count we calculate it.
        if ([self.favorited boolValue]) {
            self.favorited_count = [[NSString alloc] initWithFormat:@"%d", 1];
        } else {
            self.favorited_count = [[NSString alloc] initWithFormat:@"%d", 0];
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [dateFormatter dateFromString: dictionary[@"created_at"]];
        
        
    }
    
    return self;
}

+ (NSArray *)tweetsWithArrray: (NSArray *)array {
    NSMutableArray *tweetsArray = [NSMutableArray array];
    
    for (NSDictionary *tweet in array) {
        [tweetsArray addObject:[[Tweet alloc] initWithDictionary:tweet]];
    }
    return tweetsArray;
}

@end
