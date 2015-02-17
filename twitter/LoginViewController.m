//
//  LoginViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "LoginViewController.h"
#import "PageBarViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()
- (IBAction)loginAction:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:118/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginAction:(id)sender {
    
[[TwitterClient sharedInstance] logInWithCompletion:^(User *user, NSError *error) {
    if (user) {
        PageBarViewController *vc = [[PageBarViewController alloc] init];
        self.superWindow.rootViewController = vc;
    }
    else {
        NSLog(@"Hubo un error %@", error);
    }
}];
    
}
@end
