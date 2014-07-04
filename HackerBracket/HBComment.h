//
//  HBComment.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/4/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerBracket.h"

@interface HBComment : NSObject
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSURL *ownerGravatar;
@property (nonatomic, copy) NSString *ownerName;
@property (nonatomic, copy) NSString *ownerUsername;
-(id)initWithBody:(NSString *)body createdAt:(NSDate *)createdAt owner:(NSString *)owner ownerGravatar:(NSURL *)gravatar ownerName:(NSString *)ownerName ownerUsername:(NSString *)ownerUsername;
+ (void)geCommentsForHack:(NSString *)hackId block:(void(^)(NSArray *comments))block;
@end
