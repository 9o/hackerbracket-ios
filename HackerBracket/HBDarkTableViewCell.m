//
//  HBDarkTableViewCell.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBDarkTableViewCell.h"

@implementation HBDarkTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
