//
//  profileHeaderViewController.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "User.h"
#import <UIKit/UIKit.h>

@interface ProfileHeaderViewController : UIViewController

@property (nonatomic, strong) User *user;

- (void)setUser:(User *)user;

@end
