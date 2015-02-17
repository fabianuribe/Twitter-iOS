//
//  profileViewController.m
//  twitter
//
//  Created by Fabián Uribe Herrera on 2/16/15.
//  Copyright (c) 2015 fabian. All rights reserved.
//

#import "DetailViewController.h"
#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "TweetCell.h"
#import "ProfileViewController.h"
#import "ProfileHeaderViewController.h"
#import "SegmentedControlViewController.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate, SegmentedViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet ProfileHeaderViewController *profileHeader;
@property (strong, nonatomic) IBOutlet SegmentedControlViewController *segmentedControl;


@end

@implementation ProfileViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Profile";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(onBackBtn)];
    
    // Register cell view
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    

    // Set the TableView Header
    self.profileHeader = [[ProfileHeaderViewController alloc] init];
    [self.profileHeader setUser:self.user];
    CGFloat headerWidth = self.profileHeader.view.frame.size.width;
    CGFloat headerHeight = 270;

    self.profileHeader.view.frame = CGRectMake(0, 0, headerWidth, headerHeight);
    
    self.tableView.tableHeaderView = self.profileHeader.view;
    
    
    // Set the section Header Controller
    self.segmentedControl = [[SegmentedControlViewController alloc] init];
    self.segmentedControl.delegate = self;
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self getTimeline];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    

    return self.segmentedControl.view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *tweetDetailVC = [[DetailViewController alloc] init];
    tweetDetailVC.tweet = self.tweets[indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tweetDetailVC];
    
    [self.superView presentViewController:nvc animated:YES completion:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)segmentedController:(SegmentedControlViewController *)control didUpdateValue:(NSInteger)value {
    switch (value)
    {
        case 1:
            [self getMentions];
            break;
            
        case 2:
            [self getFavorites];
            break;
            
        default:
            [self getTimeline];
            break;
    }
}


- (void) getTimeline {
    
    NSDictionary * params = @{@"screen_name" : self.user.screenName };
    
    [[TwitterClient sharedInstance] getTimeline:@"user" WithParams: params WithCompletion:^(NSArray *tweetArray, NSError *error) {
        
        if (tweetArray.count) {
            [self.tweets removeAllObjects];
            self.tweets = [tweetArray mutableCopy];
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error);
        }
    } ];
}


- (void) getFavorites {
    
    NSDictionary * params = @{@"screen_name" : self.user.screenName };
    
    [[TwitterClient sharedInstance] getFavorites: params  WithCompletion:^(NSArray *tweetArray, NSError *error) {
        if (tweetArray.count) {
            [self.tweets removeAllObjects];
            self.tweets = [tweetArray mutableCopy];
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error);
        }
    } ];
}


- (void) getMentions {
    
    if (self.user.screenName == [User currentUser].screenName) {
        
        [[TwitterClient sharedInstance] getTimeline:@"mentions" WithParams: nil WithCompletion:^(NSArray *tweetArray, NSError *error) {
            
            if (tweetArray.count) {
                [self.tweets removeAllObjects];
                self.tweets = [tweetArray mutableCopy];
                [self.tableView reloadData];
                
            } else {
                NSLog(@"%@", error);
            }
        } ];
        
    } else {
    
        NSDictionary * params = @{@"q": [NSString stringWithFormat:@"@%@", self.user.screenName]};
        
        [[TwitterClient sharedInstance] searchTweets: params  WithCompletion:^(NSArray *tweetArray, NSError *error) {
            if (tweetArray.count) {
                [self.tweets removeAllObjects];
                self.tweets = [tweetArray mutableCopy];
                [self.tableView reloadData];
                
            } else {
                NSLog(@"%@", error);
            }
        } ];
    }
}

#pragma mark - Navigation

- (void) onBackBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
