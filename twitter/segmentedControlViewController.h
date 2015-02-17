//
//  segmentedControlViewController.h
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentedControlViewController;

@protocol SegmentedViewControllerDelegate <NSObject>

- (void) segmentedController: (SegmentedControlViewController *)control didUpdateValue: (NSInteger) value;

@end


@interface SegmentedControlViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) id<SegmentedViewControllerDelegate> delegate;


@end
