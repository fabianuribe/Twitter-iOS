//
//  LoginViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(id)sender {
    
[[TwitterClient sharedInstance] logInWithCompletion:^(User *user, NSError *error) {
    if (user) {
        MainViewController *mainViewVC = [[MainViewController alloc] init];
        
        NSLog(@"%@", user.name);
        
        [self.navigationController pushViewController:mainViewVC animated:YES];
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:118/255.0 green:181/255.0 blue:235/255.0 alpha:1.0];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
    else {
        NSLog(@"Hubo un error %@", error);
    }
}];
    
}
@end
