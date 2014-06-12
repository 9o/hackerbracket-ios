//
//  HBHackCell.h
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBHackCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *hackTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *hackLikesLabel;
@property (nonatomic, strong) IBOutlet UILabel *hackCommentsLabel;
@property (nonatomic, strong) IBOutlet UIImageView *hackImageView;
@property (nonatomic, strong) IBOutlet UIImageView *hackAvatarImageView;

@end
