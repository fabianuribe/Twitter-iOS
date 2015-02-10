//
//  DetailViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"
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
    self.favoriteCountLabel.text = [[NSString alloc] initWithFormat:@"%@", self.tweet.favorited_count];
    
    
    if ([self.tweet.retweeted boolValue]) {
        [self.retweetBtn setImage:[UIImage imageNamed:@"retweet_on.png"] forState:normal ];
    } else {
        [self.retweetBtn setImage:[UIImage imageNamed:@"retweet.png"] forState:normal ];
    }
    
    if ([self.tweet.favorited boolValue]) {
        [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_on.png"] forState:normal];
    } else {
        [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:normal];
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

- (IBAction)onReply:(id)sender {
    
    ComposeViewController *composeVC = [[ComposeViewController alloc] init];
    
    composeVC.initialText = [[NSString alloc] initWithFormat:@"@%@ " , self.tweet.user.screenName ];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)onRetweet:(id)sender {
    if ([self.tweet.retweeted boolValue]){
        return;
    }

    [[TwitterClient sharedInstance] retweetTweet: self.tweet.id_str WithCompetion:^(NSDictionary *response, NSError *error) {

        if (response) {
            self.tweet.retweeted = @"true";
            self.tweet.retweet_count = [[NSString alloc] initWithFormat:@"%d", [self.tweet.retweet_count intValue] + 1];
            self.retweetCountLabel.text = self.tweet.retweet_count;
            
            [self.retweetBtn setImage:[UIImage imageNamed:@"retweet_on.png"] forState:normal ];
            
        } else {
            NSLog(@"%@", error);
        }
    } ];
}

- (IBAction)onFavorite:(id)sender {
    if ([self.tweet.favorited boolValue]){
        return;
    }
    
    [[TwitterClient sharedInstance] favoriteTweet:self.tweet.id_str WithCompetion:^(NSDictionary *response, NSError *error) {
        
        if (response) {
            
            self.tweet.favorited = @"true";
            self.tweet.favorited_count = @"1";
            self.favoriteCountLabel.text = self.tweet.favorited_count;
            
            [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_on.png"] forState:normal ];
            
        } else {
            NSLog(@"%@", error);
        }
    } ];
}

@end
