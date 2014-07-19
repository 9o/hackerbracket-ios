//
//  HBProfileViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/2/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBUser.h"

@interface HBProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) HBUser *user;
@property (strong, nonatomic) NSArray *hacks;
@property (weak, nonatomic) NSString *username;
@property (assign, nonatomic) BOOL isOwner;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
