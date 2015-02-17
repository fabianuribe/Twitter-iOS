//
//  segmentedControlViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "SegmentedControlViewController.h"

@interface SegmentedControlViewController ()
- (IBAction)onChange:(id)sender;

@end

@implementation SegmentedControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onChange:(id)sender {
    
    [self.delegate segmentedController:self didUpdateValue: self.segmentedControl.selectedSegmentIndex];
}
@end
