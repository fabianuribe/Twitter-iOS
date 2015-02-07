//
//  MainViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/5/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "DetailViewController.h"
#import "TweetCell.h"

@interface MainViewController ()  <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MainViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Home";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Signout" style:UIBarButtonItemStylePlain target:self action:@selector(onSignout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNew)];
    
    
    // Register cell view
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
//    cell.userNameLabel.text = @"Fabian";
    
    return cell;
    
}


#pragma mark - Navigation

- (void) onSignout {
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    
//    [self.navigationController pushViewController: tweetDetailVC animated:YES];
    [self.navigationController presentViewController: loginVC animated:YES completion:nil];

    
}

- (void) onNew {
    
    ComposeViewController *composeVC = [[ComposeViewController alloc] init];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:nvc animated:YES completion:nil];


}

- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     DetailViewController *tweetDetailVC = [[DetailViewController alloc] init];
    
//    DetailViewController.tweet = self.tweets[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController: tweetDetailVC animated:YES];
}

@end
