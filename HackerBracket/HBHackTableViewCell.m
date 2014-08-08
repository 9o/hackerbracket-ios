//
//  HBHackTableViewCell.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/7/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBHackTableViewCell.h"

@implementation HBHackTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib {
    // Turn down the lights
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 67, self.previewImageView.frame.size.width, self.previewImageView.frame.size.height - 67)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0 alpha:0] CGColor], (id)[[UIColor colorWithWhite:0 alpha:0.8] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    [self.previewImageView addSubview:view];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
