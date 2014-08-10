//
//  HBHackCellCommentsTableView.m
//  HackerBracket
//
//  Created by Isaiah Turner on 8/10/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBHackCellCommentsTableView.h"
#import "HBCommentTableViewCell.h"
#import "HBComment.h"

@implementation HBHackCellCommentsTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.comments count];
}

-(UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBCommentTableViewCell *cell = [[HBCommentTableViewCell alloc] init];
    HBComment *comment = [self.comments objectAtIndex:[indexPath row]];
    [cell.commentText setText:comment.body];
    //[cell.userImage setImage:comment.ownerGravatar];
    
    return cell;
}

@end
