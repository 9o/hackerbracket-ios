//
//  HBHackViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/1/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBHack.h"
#import <MediaPlayer/MPMoviePlayerController.h>

@interface HBHackViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HBHack *hack;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *hackImageView;

@end
