//
//  ComposeViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "Tweet.h"
#import "User.h"


@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *statusTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.avatarImage.layer.cornerRadius = 8.0;
    self.avatarImage.clipsToBounds = YES;
    
    [self.statusTextView becomeFirstResponder];
    
    self.userNameLabel.text = [[NSString alloc] initWithFormat:@"@%@", [User currentUser].screenName];
    self.nameLabel.text = [User currentUser].name;
    
    [self.avatarImage setImageWithURL:[NSURL URLWithString: [User currentUser].profileImageUrl]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelBtn)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    if (self.initialText) {
        self.statusTextView.text = self.initialText;
    }
    
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


- (void) onCancelBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onTweet {
    
    [[TwitterClient sharedInstance] updateStatus:self.statusTextView.text WithCompetion:^(NSDictionary *response, NSError *error) {
        if (response) {
            
            Tweet *freshTweet = [[Tweet alloc] initWithDictionary:response];
            
            [self.delegate composeViewController:self tweeted:freshTweet];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            NSLog(@"%@", error);
        }
    }];
}

@end
