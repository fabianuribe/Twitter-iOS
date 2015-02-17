//
//  profileViewController.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSMutableArray *tweets;

@end
