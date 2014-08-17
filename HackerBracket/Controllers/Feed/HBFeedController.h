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
#import <MediaPlayer/MPMoviePlayerController.h>

#define REGULAR_FONT @"AvenirNextLTPro-Regular"
#define MEDIUM_FONT  @"AvenirNextLTPro-Medium"

@interface HBFeedController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
 {
    HackListType type;
}

@property (nonatomic, strong) NSMutableArray *hacks;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *indicatorView;
@property (nonatomic, strong) UIView *notificationsView;
@property (strong, nonatomic) MPMoviePlayerController *mPlayer;
@property (nonatomic, strong) IBOutlet UIView *videoContainer;
@property (nonatomic, strong) UIImage *avatarImageFromURL;
@property (nonatomic, strong) UITapGestureRecognizer *pauseAndPlayTapHandler;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UILabel *pageLabel;
@property (nonatomic, strong) UISwipeGestureRecognizer *recognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *recognizerPrevious;

@property (nonatomic, assign) int skip;
@property (nonatomic, assign) BOOL isLoading;

@property (strong, nonatomic) IBOutlet UITableView *theTableView;
- (void)refreshHacks;
- (IBAction)showFollowing:(id)sender;
- (IBAction)showTrending:(id)sender;
- (IBAction)showRecent:(id)sender;

@end
