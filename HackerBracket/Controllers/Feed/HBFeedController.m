//
//  HBFeedController.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBFeedController.h"
#import "HBHackViewController.h"
#import "HBUser.h"
#import "HCYoutubeParser.h"
#import <AVFoundation/AVFoundation.h>
#import "HBProfileViewController.h"
#import "UIView+Blur.h"
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

- (void)showFollowing:(id)sender {
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self.mPlayer pause];
    self.skip = 0;
    type = Following;
    [self refreshHacks];
    
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    [animation setSubtype:kCATransitionFromRight];
    animation.duration = 0.45;
    [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.pageLabel.text = @"Following";


}

- (void)showTrending:(id)sender {
    [self.mPlayer pause];
    self.recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showRecent:)];
    
    self.skip = 0;
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    type = Trending;
    [self refreshHacks];
    [self.pageControl setCurrentPage:1];
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    [animation setSubtype:kCATransitionFromRight];
    animation.duration = 0.45;
    [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.pageLabel.text = @"Popular";
}

- (void)showRecent:(id)sender {
    [self.mPlayer pause];
    self.skip = 0;
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    type = Recent;
    [self refreshHacks];
    


}

-(void)changePagesNext:(id)sender {
    if (type == Following) {
        [self showTrending:(sender)];
        [self.pageControl setCurrentPage:1];
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        [animation setSubtype:kCATransitionFromRight];
        animation.duration = 0.45;
        [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
        self.pageLabel.text = @"Popular";

        
    } else if (type == Trending) {
        [self showRecent:(sender)];
        [self.pageControl setCurrentPage:2];
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        [animation setSubtype:kCATransitionFromRight];
        animation.duration = 0.45;
        [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
        self.pageLabel.text = @"Recent";

    }
    
}

-(void)changePagesPrevious:(id)sender {
    if (type == Following) {
        
    } else if (type == Trending) {
        [self showFollowing:(sender)];
        [self.pageControl setCurrentPage:0];
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        [animation setSubtype:kCATransitionFromLeft];
        animation.duration = 0.45;
        [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
        self.pageLabel.text = @"Following";

    } else if (type == Recent) {
        [self showTrending:(sender)];
        [self.pageControl setCurrentPage:1];
        CATransition *animation = [CATransition animation];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        [animation setSubtype:kCATransitionFromLeft];
        animation.duration = 0.45;
        [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
        self.pageLabel.text = @"Popular";

    }
    
}

#pragma mark - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.hacks count];
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"CellId";
    HBHackCell *cell = (HBHackCell *)[self.tableView dequeueReusableCellWithIdentifier:cellId];

    if (!cell) {
        cell = [[HBHackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    HBHack *hack = [self.hacks objectAtIndex:indexPath.row];
    [cell.hackAvatarImageView setImageWithURL:hack.ownerAvatar
                             placeholderImage:[UIImage imageNamed:@"Loading Thumbnail"]];
    cell.hackTitleLabel.text = hack.title;
    cell.hackDescriptionTextView.text = hack.descriptionText;
    [cell.hackOwnerButton setTitle:hack.ownerName forState:UIControlStateNormal];
    cell.hackLikesLabel.text = [NSString stringWithFormat:@"%@",hack.likes];

    UIGraphicsBeginImageContextWithOptions(cell.hackAvatarImageView.bounds.size, NO, [UIScreen mainScreen].scale);
    [[UIBezierPath bezierPathWithRoundedRect:cell.hackAvatarImageView.bounds
                                cornerRadius:25.0f] addClip];
    
    [cell.hackAvatarImageView.image drawInRect:cell.hackAvatarImageView.bounds];
    cell.hackAvatarImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    

    
    self.pauseAndPlayTapHandler = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseAndPlay)];
    [self.pauseAndPlayTapHandler setNumberOfTouchesRequired:1];
    [self.pauseAndPlayTapHandler setNumberOfTapsRequired:1];
    self.pauseAndPlayTapHandler.cancelsTouchesInView = YES;
    self.pauseAndPlayTapHandler.delegate = self;

    UISlider *timelineSlider = [[UISlider alloc] init];
    timelineSlider.frame = CGRectMake(0, 0, 40, 20);
    
    
    NSURL *videoURL = [[NSURL alloc] init];
    
    
    if (hack.isYouTube == true) {
    NSDictionary *videos = [HCYoutubeParser h264videosWithYoutubeURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@",hack.video]]];
        NSString *youtubeURL = [[NSString alloc] init];
        NSDictionary *qualities = videos;
        
         if ([qualities objectForKey:@"large"] != nil) {
            youtubeURL = [qualities objectForKey:@"large"];
            videoURL = [NSURL URLWithString:youtubeURL];
             NSLog(@"%@",videoURL);
        } else if ([qualities objectForKey:@"hd720"] != nil) {
            youtubeURL = [qualities objectForKey:@"hd720"];
            videoURL = [NSURL URLWithString:youtubeURL];
            NSLog(@"%@",videoURL);
        } else if ([qualities objectForKey:@"medium"] != nil) {
            youtubeURL = [qualities objectForKey:@"medium"];
            videoURL = [NSURL URLWithString:youtubeURL];
            NSLog(@"%@",videoURL);
        }  else if ([qualities objectForKey:@"small"] != nil) {
            youtubeURL = [qualities objectForKey:@"small"];
            videoURL = [NSURL URLWithString:youtubeURL];
            NSLog(@"%@",videoURL);
        } else {
            NSDictionary *videos = [HCYoutubeParser h264videosWithYoutubeURL:[NSURL URLWithString:@"https://www.youtube.com/watch?v=K-sEKOJ59hU&feature=youtu.be"]];
            NSString *youtubeURL = [[NSString alloc] init];
            NSDictionary *qualities = videos;
            
            if ([qualities objectForKey:@"large"] != nil) {
                youtubeURL = [qualities objectForKey:@"large"];
                videoURL = [NSURL URLWithString:youtubeURL];
                NSLog(@"%@",videoURL);
            } else if ([qualities objectForKey:@"hd720"] != nil) {
                youtubeURL = [qualities objectForKey:@"hd720"];
                videoURL = [NSURL URLWithString:youtubeURL];
                NSLog(@"%@",videoURL);
            } else if ([qualities objectForKey:@"medium"] != nil) {
                youtubeURL = [qualities objectForKey:@"medium"];
                videoURL = [NSURL URLWithString:youtubeURL];
                NSLog(@"%@",videoURL);
            }  else if ([qualities objectForKey:@"small"] != nil) {
                youtubeURL = [qualities objectForKey:@"small"];
                videoURL = [NSURL URLWithString:youtubeURL];
                NSLog(@"%@",videoURL);

    } else if (hack.isYouTube == false) {
        videoURL = [NSURL URLWithString:hack.video];
        NSLog(@"%@",hack.video);
        
        
    }
        }}
    [self.mPlayer thumbnailImageAtTime:1 timeOption:MPMovieTimeOptionNearestKeyFrame];
    self.mPlayer = [[MPMoviePlayerController alloc] init];
    self.mPlayer.movieSourceType = MPMovieSourceTypeStreaming;
    self.mPlayer.controlStyle = MPMovieControlStyleNone;
    [self.mPlayer setContentURL:videoURL];
    self.mPlayer.repeatMode = MPMovieRepeatModeNone;
    [self.mPlayer.view setFrame:cell.hackImageView.frame];
    [cell addSubview:self.mPlayer.view];
    [self.mPlayer prepareToPlay];
    [self.mPlayer.view addGestureRecognizer:self.pauseAndPlayTapHandler];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loop:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.mPlayer];
    cell.hackHellYeahButton.layer.cornerRadius = 4;

    
    if (hack.isLiked) {
        cell.hackHellYeahButton.tag = 1;
    } else {
    }
    
    [cell.hackHellYeahButton addTarget:self action:@selector(likeHack:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;

    }

- (void)loop:(NSNotification *)note
{
    if (note.object == self.mPlayer) {
        NSInteger reason = [[note.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
        if (reason == MPMovieFinishReasonPlaybackEnded)
        {
            [self.mPlayer play];
        }
    }
}

    
-(void)pauseAndPlay {
    NSLog(@"tapped");
    if (self.mPlayer.playbackState == MPMoviePlaybackStatePlaying)
    {
        [self.mPlayer pause];
    } else if (self.mPlayer.playbackState == MPMoviePlaybackStatePaused) {
        [self.mPlayer play];
    }
 
}

#pragma mark - gesture delegate
// this allows you to dispatch touches
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}
// this enables you to handle multiple recognizers on single view
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
    /*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showHack"]) {
        HBHack *hack = [self.hacks objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        NSLog(@"%@",hack.technologies);
        HBHackViewController *vc = segue.destinationViewController;
        vc.hack = hack;
    }
}*/

#pragma mark - View

- (void)viewDidAppear:(BOOL)animated {
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.duration = 0.25;
    [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.pageLabel.alpha = 1.0;
    self.pageControl.alpha = 1.0;

    if (!hasLoadedData) {
        hasLoadedData = TRUE;
    self.hacks = [NSMutableArray array];

[self refreshHacks];
    }
    [self.navigationController.navigationBar addGestureRecognizer:self.recognizerPrevious];
    [self.navigationController.navigationBar addGestureRecognizer:self.recognizer];
    [self.navigationController.navigationBar addSubview:self.pageLabel];
    [self.navigationController.navigationBar addSubview:self.pageControl];

}

- (void)viewDidLoad {
    type = Following;
    [super viewDidLoad];
    [self.recognizer setEnabled:true];
    [self.recognizerPrevious setEnabled:true];
    NSLog(@"viewdidload");
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Light Logo"]];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    UIToolbar *tab = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    tab.barTintColor = [UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1.0];
    
    // And finally we add it to the background view of UINavigationBar... but it can change with future release of iOS. Be aware !
    [[self.navigationController.navigationBar.subviews firstObject] addSubview:tab];
    // Setup refresh control
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl setTintColor:[UIColor colorWithRed:90/255.0f green:184/255.0f blue:77/255.0f alpha:1.0f]];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshHacks) forControlEvents:UIControlEventValueChanged];
    id block = ^(NSString *username, NSString *name, NSURL *gravatar) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake( 0, 0, 25, 25)];
        if (gravatar == NULL || gravatar == nil ) {
            [button setImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 0, 50, 50);
            [button setHidden:YES];
        } else
            [button.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        
        button.frame = CGRectMake(0, 0, 28.5, 28.5);
        
        UIImageView *profileImage = [[UIImageView alloc] init];
        [profileImage setImageWithURL:gravatar];
        [button setImage:profileImage.image forState:UIControlStateNormal];
        
        button.layer.cornerRadius = button.frame.size.width / 2;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(showProfile) forControlEvents:UIControlEventTouchUpInside];
        [[button layer] setBorderWidth:1.5f];
        [[button layer] setBorderColor:[UIColor whiteColor].CGColor];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        self.navigationItem.leftBarButtonItem = item;    };
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200, 60.0)];
    [self.navigationController.navigationBar.topItem setTitleView
     :view];
    view = self.navigationController.navigationBar.topItem.titleView;
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    self.pageLabel = [[UILabel alloc] init];
    [self.navigationController.navigationBar addSubview:self.pageLabel];
    self.pageLabel.text = @"Following";
    self.pageLabel.frame = CGRectMake(110, -18, 100, 64);
    self.pageLabel.textAlignment = NSTextAlignmentCenter;
    self.pageLabel.textColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, -10, view.frame.size.width, view.frame.size.height)];
    [button setTitle:@"▾" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentBottom];
    [button addTarget:self action:@selector(dragShowNotifications:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    [button addTarget:self action:@selector(hideNotificationsIfShown) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(showNotifications) forControlEvents:UIControlEventTouchUpOutside];
    CGSize navBarSize = self.navigationController.navigationBar.bounds.size;
    CGPoint origin = CGPointMake( navBarSize.width/2, navBarSize.height/2 );
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(origin.x, origin.y +9,
                                                                       0, 0)];
    
    self.recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changePagesNext:)];
    [self.recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.navigationController.navigationBar addGestureRecognizer:self.recognizer];
    
    self.recognizerPrevious = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changePagesPrevious:)];
    [self.recognizerPrevious setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.navigationController.navigationBar addGestureRecognizer:self.recognizerPrevious];


    [super viewDidLoad];
    
    /*CATransition *animation = [CATransition animation];
     animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     animation.type = kCATransitionPush;
     [animation setSubtype:kCATransitionFromRight];
     animation.duration = 0.45;
     [whoiam.layer addAnimation:animation forKey:@"kCATransitionFade"];
     whoiam.text = @"Where I'm From";
     swipeGestureback1.enabled = NO;
*/
    
    //Or whatever number of viewcontrollers you have
    [self.pageControl setNumberOfPages:3];
    
    [self.navigationController.navigationBar addSubview:self.pageControl];
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
    [self.mPlayer pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {

    // NSLog(@"offset: %f", offset.y);
    // NSLog(@"content.height: %f", size.height);
    // NSLog(@"bounds.height: %f", bounds.size.height);
    // NSLog(@"inset.top: %f", inset.top);
    // NSLog(@"inset.bottom: %f", inset.bottom);
}


- (void)likeHack:(UIButton *)sender {
    UIButton *button = sender;
    static NSString *cellId = @"CellId";
    HBHackCell *cell = (HBHackCell *)sender.superview;
      cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    HBHack *hack = [self.hacks objectAtIndex:indexPath.row];
    
    if (button.tag == 0) {
        [HBHack likeHack:hack completion:^(BOOL success) {
            NSNumber *number = [NSNumber numberWithInt:[hack.likes intValue]];
            int value = [number intValue];
            number = [NSNumber numberWithInt:value + 1];
            NSLog(@"%@",number);
            cell.hackHellYeahButton.titleLabel.text = [NSString stringWithFormat:@"%@",number];
            [cell.hackHellYeahButton removeFromSuperview];
            [cell addSubview:cell.hackHellYeahButton];
            NSLog(@"You liked '%@'",hack.title);
            [button setBackgroundColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.tag = 1;
        }];
    } else if (button.tag == 1) {
        [HBHack unlikeHack:hack completion:^(BOOL success) {
            NSLog(@"You unliked '%@'",hack.title);
            [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
            [button setTitleColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1] forState:UIControlStateNormal];
            button.tag = 1;
        }];
    }}

-(void)viewWillDisappear:(BOOL)animated {
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    animation.duration = 0.25;
    [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    [self.pageControl.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.pageLabel.alpha = 0.0;
    self.pageControl.alpha = 0.0;
    


}

-(void)viewDidDisappear:(BOOL)animated {
    [self.recognizer setEnabled:false];
    [self.recognizerPrevious setEnabled:false];

    
    
}

-(void)viewWillAppear:(BOOL)animated {
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.subtype = kCATransitionFromLeft;
    animation.type = kCATransitionFade;
    animation.duration = 0.25;
    [self.pageLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    [self.pageControl.layer addAnimation:animation forKey:@"kCATransitionFade"];
    self.pageLabel.alpha = 1.0;
    self.pageControl.alpha = 1.0;
}


@end
