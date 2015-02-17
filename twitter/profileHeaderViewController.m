//
//  profileHeaderViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "UIImageView+AFNetworking.h"
#import "ProfileHeaderViewController.h"

@interface ProfileHeaderViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@end

@implementation ProfileHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.avatarImage.layer.cornerRadius = 8.0;
    self.avatarImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.avatarImage.layer.borderWidth = 2.5;
    self.avatarImage.clipsToBounds = YES;
    
    self.screenNameLabel.text = [[NSString alloc] initWithFormat:@"@%@", self.user.screenName];
    self.nameLabel.text = self.user.name;
    
    self.taglineLabel.text = self.user.tagLine;
    self.locationLabel.text = self.user.location;
    self.urlLabel.text = self.user.website;
    
    self.followersLabel.text = [NSString stringWithFormat:@"%@", self.user.followersCount];
    self.followingLabel.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
    
    [self.avatarImage setImageWithURL:[NSURL URLWithString: self.user.profileImageUrl]];
    [self.backgroundImage setImageWithURL:[NSURL URLWithString: self.user.backgroundImageUrl]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setUser:(User *)user {
    _user = user;
}


@end
