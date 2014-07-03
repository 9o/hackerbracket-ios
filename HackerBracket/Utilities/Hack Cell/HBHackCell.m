//
//  HBHackCell.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/9/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBHackCell.h"

@implementation HBHackCell

- (void)awakeFromNib {
    // Turn down the lights
    UIView *dim = [[UIView alloc] initWithFrame:self.hackImageView.frame];
    [dim setBackgroundColor:[UIColor blackColor]];
    [dim setAlpha:0.3f];
    [self.hackImageView addSubview:dim];
    
    // Circularize
    self.hackAvatarImageView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.hackAvatarImageView.layer.cornerRadius = self.hackAvatarImageView.frame.size.height / 2;
    self.hackAvatarImageView.layer.masksToBounds = YES;
    
    // Shadows
    self.hackTitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.hackTitleLabel.layer.shadowOpacity = 0.8f;
    self.hackTitleLabel.layer.shadowRadius = 2.0f;
    self.hackTitleLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
