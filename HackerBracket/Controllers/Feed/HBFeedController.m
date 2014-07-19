//
//  HBFeedController.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBFeedController.h"
#import "HBHackViewController.h"

@implementation HBFeedController
BOOL hasLoadedData = FALSE;

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
    NSLog(@"%u",type);
    self.isLoading = TRUE;
        [HBHack getHacks:type skip:0 withBlock:^(NSArray *hacks) {
            self.isLoading = FALSE;
            [self.hacks removeAllObjects];
            
            for (HBHack *hack in hacks) {
                [self.hacks addObject:hack];
            }
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
        }];
}

- (IBAction)showFollowing:(id)sender {
    self.skip = 0;
    type = Following;
    [self refreshHacks];
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(10, 35, 75, 5);
    }];
}

- (IBAction)showTrending:(id)sender {
    self.skip = 0;
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    type = Trending;
    [self refreshHacks];
    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorView.frame = CGRectMake(103, 35, 75, 5);
    }];
}

- (IBAction)showRecent:(id)sender {
    self.skip = 0;
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    type = Recent;
    [self refreshHacks];
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
    
    [cell.hackAvatarImageView setImageWithURL:hack.ownerAvatar
                             placeholderImage:[UIImage imageNamed:@"Loading Thumbnail"]];
    
    UIGraphicsBeginImageContextWithOptions(cell.hackAvatarImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:cell.hackAvatarImageView.bounds
                                cornerRadius:25.0f] addClip];
    
    [cell.hackAvatarImageView.image drawInRect:cell.hackAvatarImageView.bounds];
    cell.hackAvatarImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [cell.hackImageView setImageWithURL:hack.thumbnail
                       placeholderImage:[UIImage imageNamed:@"Loading Thumbnail"]];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showHack"]) {
        HBHack *hack = [self.hacks objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        NSLog(@"%@",hack.technologies);
        HBHackViewController *vc = segue.destinationViewController;
        vc.hack = hack;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath
                                  animated:YES]
    ;
}
#pragma mark - View

- (void)viewDidAppear:(BOOL)animated {
    if (!hasLoadedData) {
        hasLoadedData = TRUE;
    self.hacks = [NSMutableArray array];
        [self.tableView setContentOffset:CGPointMake(0, -self.indicatorView.frame.size.height) animated:YES];

[self refreshHacks];
    }
}

- (void)viewDidLoad {
    type = Following;
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Light Logo"]];
    // Setup refresh control
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl setTintColor:[UIColor colorWithRed:90/255.0f green:184/255.0f blue:77/255.0f alpha:1.0f]];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshHacks) forControlEvents:UIControlEventValueChanged];
    id block = ^(NSString *username, NSString *name, NSURL *gravatar) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 0, 0, 25, 25)];
        if (gravatar == NULL || gravatar == nil ) {
            
        [button setImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
        [button setHidden:YES];
        } else
            [button setImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
       //[button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:@"http://gravatar.com/avatar/c7606485562f1907c5565adf7bd76d2c?d=mm"] placeholderImage:[UIImage imageNamed:@"profile"]];
        [button.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        button.layer.cornerRadius = button.frame.size.width / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(showProfile) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        self.navigationItem.leftBarButtonItem = item;
    };
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200, 60.0)];
    [self.navigationController.navigationBar.topItem setTitleView
     :view];
    view = self.navigationController.navigationBar.topItem.titleView;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Light Logo"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    
    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y - 10, 175, 25);
    imageView.center = view.center;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, -10, view.frame.size.width, view.frame.size.height)];
    [button setTitle:@"▾" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [button addTarget:self action:@selector(dragShowNotifications:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(hideNotificationsIfShown) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(showNotifications) forControlEvents:UIControlEventTouchUpOutside];
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    //[view addSubview:button];
    [HBUser currentUserMeta:block updatedMeta:block];
}

- (void)dragShowNotifications:(UIButton *)sender withEvent:(UIEvent *)event {
    self.notificationsView.hidden = NO;
    UITouch *touch = [[event allTouches] anyObject];
    NSLog(@"touchInfo:%@", NSStringFromCGPoint([touch locationInView:self.view]));
    NSLog(@"Drag show notifications");
}

- (void)showNotifications {
    self.notificationsView.hidden = NO;
    UITableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"notificationsVC"];
    [self.navigationController pushViewController:vc animated:YES];
    NSLog(@"Show notifications");
}

- (void)hideNotificationsIfShown {
    self.notificationsView.hidden = YES;
    NSLog(@"Hide notifications if show");
}

- (void)showProfile {
    NSLog(@"shown");
    [self performSegueWithIdentifier:@"viewMyProfile" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    // NSLog(@"offset: %f", offset.y);
    // NSLog(@"content.height: %f", size.height);
    // NSLog(@"bounds.height: %f", bounds.size.height);
    // NSLog(@"inset.top: %f", inset.top);
    // NSLog(@"inset.bottom: %f", inset.bottom);
    // NSLog(@"pos: %f of %f", y, h);
    
    float reload_distance = 10;
    if(y > h + reload_distance) {
        if (!self.isLoading) {
            self.isLoading = TRUE;
            self.skip = self.skip + 25;
            [HBHack getHacks:type skip:self.skip withBlock:^(NSArray *hacks) {
                self.isLoading = FALSE;
                // If there are no hacks, we are at the bottom. Prevent more requests by saying it is already loading.
                if ([hacks count] == 0) {
                    self.isLoading = TRUE;
                }
                for (HBHack *hack in hacks) {
                    [self.hacks addObject:hack];
                }
                [self.tableView reloadData];
            }];
        }

    }
}

@end
