//
//  HBBioTableViewCell.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBBioTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
