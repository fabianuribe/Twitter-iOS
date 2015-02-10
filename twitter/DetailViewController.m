//
//  DetailViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "DateTools.h"


@interface DetailViewController ()


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.avatarImage.layer.cornerRadius = 8.0;
    self.avatarImage.clipsToBounds = YES;
    
    self.userNameLabel.text = [[NSString alloc] initWithFormat:@"@%@", self.tweet.user.screenName];
    self.nameLabel.text = self.tweet.user.name;
    self.messageLabel.text = self.tweet.text;
    self.retweetCountLabel.text = [[NSString alloc] initWithFormat:@"%@", self.tweet.retweet_count];
    
    self.dateLabel.text = [[NSString alloc] initWithFormat:@"%@", self.tweet.createdAt.timeAgoSinceNow];
    
    
    self.retweetCountLabel.text = [[NSString alloc] initWithFormat:@"%@", self.tweet.retweet_count];
    self.favoriteCountLabel.text = [[NSString alloc] initWithFormat:@"%d", [self.tweet.retweet_count intValue]/3 ];
    
    
    
    if ([self.tweet.retweeted boolValue]) {
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet_on.png"]];
    } else {
        [self.retweetIcon setImage:[UIImage imageNamed:@"retweet.png"]];
    }
    
    if ([self.tweet.favorited boolValue]) {
        [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite_on.png"]];
    } else {
        [self.favoriteIcon setImage:[UIImage imageNamed:@"favorite.png"]];
    }
    
    
    [self.avatarImage setImageWithURL:[NSURL URLWithString: self.tweet.user.profileImageUrl]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
