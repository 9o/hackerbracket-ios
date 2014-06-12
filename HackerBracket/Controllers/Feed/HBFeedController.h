//
//  HBFeedController.h
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HackerBracket.h"
#import "HBHackCell.h"
#import "UIImageView+WebCache.h"

#define REGULAR_FONT @"AvenirNextLTPro-Regular"
#define MEDIUM_FONT  @"AvenirNextLTPro-Medium"

@interface HBFeedController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *hacks;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *indicatorView;

- (void)refreshHacks;
- (IBAction)showFollowing:(id)sender;
- (IBAction)showTrending:(id)sender;
- (IBAction)showRecent:(id)sender;

@end
