//
//  HBFeedController.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBFeedController.h"

@implementation HBFeedController

#pragma mark - Init

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Methods

- (void)refreshHacks {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [HBHack getHacksWithBlock:^(NSArray *hacks) {
            [self.hacks removeAllObjects];
            
            for (HBHack *hack in hacks) {
                [self.hacks addObject:hack];
            }
        }];
    });
    
    NSLog(@"Count: %lu", (unsigned long)[self.hacks count]);
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (IBAction)showFollowing:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(10, 35, 75, 5);
    }];
}

- (IBAction)showTrending:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(103, 35, 75, 5);
    }];
}

- (IBAction)showRecent:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(196, 35, 75, 5);
    }];
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.hacks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    HBHackCell *cell = (HBHackCell *)[self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[HBHackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    HBHack *hack = [self.hacks objectAtIndex:indexPath.row];
    [cell.hackTitleLabel setText:hack.title];
    [cell.hackLikesLabel setText:[NSString stringWithFormat:@"%@", hack.likes]];
    [cell.hackCommentsLabel setText:[NSString stringWithFormat:@"%@", hack.comments]];
    
    [cell.hackAvatarImageView setImageWithURL:[NSURL URLWithString:hack.ownerAvatar]
                             placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    UIGraphicsBeginImageContextWithOptions(cell.hackAvatarImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:cell.hackAvatarImageView.bounds
                                cornerRadius:25.0f] addClip];
    
    [cell.hackAvatarImageView.image drawInRect:cell.hackAvatarImageView.bounds];
    cell.hackAvatarImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [cell.hackImageView setImageWithURL:[NSURL URLWithString:hack.thumbnail]
                       placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    self.hacks = [NSMutableArray array];
    
    [HBUser login:@"notryancohen@gmail.com" password:@"password" block:^(HBUser *currentUser) {
        if (currentUser) {
            [self refreshHacks];
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup refresh control
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl setTintColor:[UIColor colorWithRed:90/255.0f green:184/255.0f blue:77/255.0f alpha:1.0f]];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshHacks) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
