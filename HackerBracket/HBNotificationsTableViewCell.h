//
//  HBNotificationsTableViewCell.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/17/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBNotificationsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *notificationTextView;
@property (weak, nonatomic) IBOutlet UILabel *notificationDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *notificationImage;

@end
