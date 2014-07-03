//
//  HBProfileEditTableViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/2/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBProfileEditTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *profileItems;

@end
