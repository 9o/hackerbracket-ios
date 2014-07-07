//
//  HBHackTableViewCell.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/7/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBHackTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *previewImageView;
@property (strong, nonatomic) IBOutlet UILabel *commentsLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;

@end
