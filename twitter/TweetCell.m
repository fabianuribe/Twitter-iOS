//
//  TweetCell.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"



@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    self.avatarImage.layer.cornerRadius = 8.0;
    self.avatarImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
    
    self.userNameLabel.text = [[NSString alloc] initWithFormat:@"@%@", tweet.user.screenName];
    self.nameLabel.text = tweet.user.name;
    self.messageLabel.text = tweet.text;
    
    self.retweetCountLabel.text = [[NSString alloc] initWithFormat:@"%@", tweet.retweet_count];
    self.favoriteCountLabel.text = [[NSString alloc] initWithFormat:@"%@", tweet.favorited_count];
    
    self.timeStampLabel.text = [[NSString alloc] initWithFormat:@"%@", tweet.createdAt.shortTimeAgoSinceNow];
    
    [self.avatarImage setImageWithURL:[NSURL URLWithString: tweet.user.profileImageUrl]];
    
    if ([tweet.retweeted boolValue]) {
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet_on.png"]];
    } else {
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet.png"]];
    }
    
    if ([tweet.favorited boolValue]) {
        [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite_on.png"]];
    } else {
        [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite.png"]];
    }
    
}

@end
