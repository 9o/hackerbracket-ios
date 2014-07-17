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

@interface HBHackViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) HBHack *hack;
@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *hackImageView;
@property (strong, nonatomic) NSArray *comments;
@property (assign, nonatomic) CGRect tableRect;
@property (assign, nonatomic) CGRect commentRect;
@property (assign, nonatomic) BOOL keyboardVisable;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@end
