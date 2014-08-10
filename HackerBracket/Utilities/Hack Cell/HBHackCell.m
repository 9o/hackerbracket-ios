//
//  HBHackCell.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBHackCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation HBHackCell

- (void)awakeFromNib {
    self.hackAvatarImageView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.hackAvatarImageView.layer.cornerRadius = self.hackAvatarImageView.frame.size.height / 2;
    self.hackAvatarImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
