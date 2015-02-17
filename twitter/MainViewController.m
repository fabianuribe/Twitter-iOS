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
#import "TwitterClient.h"
#import "TweetCell.h"

@interface MainViewController ()  <UITableViewDataSource, UITableViewDelegate, composeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MainViewController


static BOOL blockNetwork = NO;

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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];

    
    [[TwitterClient sharedInstance] getTimeline:@"home" WithParams:nil WithCompletion:^(NSArray *tweetArray, NSError *error) {
        
        if (tweetArray.count) {
            self.tweets = [tweetArray mutableCopy];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    } ];
    
    [self.tableView reloadData];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    cell.superNavController = self.navigationController;
    
    cell.tweet = self.tweets[indexPath.row];
    
    return cell;
    
}


#pragma mark - Navigation

- (void) onSignout {
    
    
    [User signOut];
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    
    [self.navigationController presentViewController: loginVC animated:YES completion:nil];

    
}

- (void) onNew {
    
    ComposeViewController *composeVC = [[ComposeViewController alloc] init];
    composeVC.delegate = self;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:composeVC];
    
    [self presentViewController:nvc animated:YES completion:nil];


}

- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
     DetailViewController *tweetDetailVC = [[DetailViewController alloc] init];
    
    tweetDetailVC.tweet = self.tweets[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController: tweetDetailVC animated:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}


- (void)scrollViewDidScroll:(UIScrollView *) tableView
{
    CGFloat actualPosition = tableView.contentOffset.y;
    CGFloat contentHeight = tableView.contentSize.height - 900;
    
    if (actualPosition >= contentHeight && self.tweets.count && !blockNetwork ) {
        
        
        Tweet *lastTweet = [self.tweets lastObject];
        
        NSDictionary *params = @{ @"max_id": lastTweet.id_str };
        
        
        blockNetwork = YES;
        [[TwitterClient sharedInstance] getTimeline:@"home" WithParams:params WithCompletion:^(NSArray *tweetArray, NSError *error) {
            if (tweetArray.count) {

                [self.tweets addObjectsFromArray:tweetArray];
                [self.tableView reloadData];
                
                blockNetwork = NO;

            } else {
                NSLog(@"%@", error);
                blockNetwork = YES;

            }
        } ];
    }
}


- (void)onRefresh {

    [[TwitterClient sharedInstance] getTimeline:@"home" WithParams:nil WithCompletion:^(NSArray *tweetArray, NSError *error) {
        if (tweetArray.count) {
            [self.tweets removeAllObjects];
            self.tweets = [tweetArray mutableCopy];
            
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error);
        }
    } ];
}

- (void) composeViewController:(ComposeViewController *)composeViewControler tweeted:(Tweet *)tweet {
    
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


@end
