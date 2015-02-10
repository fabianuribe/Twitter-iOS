//
//  ComposeViewController.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class ComposeViewController;

@protocol composeViewControllerDelegate <NSObject>

- (void) composeViewController: (ComposeViewController *) composeViewControler tweeted: (Tweet *)tweet;

@end


@interface ComposeViewController : UIViewController

@property (strong, nonatomic) NSString * initialText;
@property (nonatomic, weak) id <composeViewControllerDelegate> delegate;

@end
