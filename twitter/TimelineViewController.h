//
//  MainViewController.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBarViewController.h"

@interface TimelineViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *tweets;
@property (nonatomic, retain) PageBarViewController *superView;

@end
