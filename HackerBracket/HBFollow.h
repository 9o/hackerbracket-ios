//
//  HBFollower.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/4/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerBracket.h"

@interface HBFollow : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSURL *gravatar;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSDate *createdAt;

- (id)initWithId:(NSString *)userId
        gravatar:(NSURL *)gravatar
            name:(NSString *)name
        username:(NSString *)username
        createdAt:(NSDate *)createdAt;
+ (void)getFollowing:(NSString *)userId block:(void(^)(NSArray *followers))block;
+ (void)getFollowers:(NSString *)userId block:(void(^)(NSArray *followers))block;
@end
