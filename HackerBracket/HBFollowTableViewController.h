//
//  HBFollowTableViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/3/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HackerBracket.h"

@interface HBFollowTableViewController : UITableViewController
@property (assign) BOOL showFollowing;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSArray *people;

@end
