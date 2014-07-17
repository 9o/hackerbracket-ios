//
//  HBVideoTableViewCell.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/13/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBVideoTableViewCell.h"

@implementation HBVideoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
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
