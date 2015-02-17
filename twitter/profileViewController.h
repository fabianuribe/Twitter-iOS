//
//  profileViewController.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "PageBarViewController.h"

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, retain) PageBarViewController *superView;
@property (nonatomic, assign) bool addNavigation;


@end
