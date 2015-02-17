//
//  PageBarViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "PageBarViewController.h"
#import "TimelineViewController.h"
#import "ProfileViewController.h"
#import "ComposeViewController.h"
#import "LoginViewController.h"
#import "DetailViewController.h"

@interface PageBarViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIView *navBarView;

@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, assign) int currentPage;

@property (nonatomic, strong) TimelineViewController * timelineViewControler;
@property (nonatomic, strong) ProfileViewController * profileViewControler;

- (IBAction)onNew:(id)sender;
- (IBAction)onLogOut:(id)sender;

@end

@implementation PageBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navBarView.backgroundColor = [UIColor colorWithRed:118/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
    self.pageControl.currentPage = 1;
    
    self.timelineViewControler = [[TimelineViewController alloc] init];
    self.timelineViewControler.superView = self;
    
    self.profileViewControler = [[ProfileViewController alloc] init];
    self.profileViewControler.user = [User currentUser];
    self.profileViewControler.superView = self;

    
    
    CGRect tlframe = self.timelineViewControler.view.frame;
    tlframe.origin.x = 330;
    self.timelineViewControler.view.frame = tlframe;
    
    CGRect plframe = self.profileViewControler.view.frame;
    plframe.origin.x = 0;
    self.profileViewControler.view.frame = plframe;
    
    
    [self.contentView addSubview: self.profileViewControler.view];

    [self.contentView addSubview: self.timelineViewControler.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    CGPoint translation = [sender translationInView: self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        self.originalCenter = self.contentView.center;
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        self.contentView.center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y);
        
    } else if ( sender.state == UIGestureRecognizerStateEnded) {
        CGRect frame = self.contentView.frame;

        if (velocity.x > 0){
            [self currentPageChanged:0];
            frame.origin.x = 0;
        } else {
            [self currentPageChanged:1];
            frame.origin.x = -330;
        }
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:0 animations:^{
            self.contentView.frame = frame;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void) currentPageChanged: (int) newPage {
    self.currentPage = newPage;
    self.pageControl.currentPage = newPage;

}


- (IBAction)onNew:(id)sender {
    ComposeViewController *composeVC = [[ComposeViewController alloc] init];
    composeVC.delegate = self.timelineViewControler;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)onLogOut:(id)sender {
    
    [User signOut];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    
    self.superWindow.rootViewController = vc;
    
}
@end
