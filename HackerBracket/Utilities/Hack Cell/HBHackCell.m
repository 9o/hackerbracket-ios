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
    // Turn down the lights
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 67, self.hackImageView.frame.size.width, self.hackImageView.frame.size.height - 67)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0 alpha:0] CGColor], (id)[[UIColor colorWithWhite:0 alpha:0.8] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    [self.hackImageView addSubview:view];
    // Circularize
    self.hackAvatarImageView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    self.hackAvatarImageView.layer.cornerRadius = self.hackAvatarImageView.frame.size.height / 2;
    self.hackAvatarImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
