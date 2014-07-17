//
//  HBNotification.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/17/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerBracket.h"

@interface HBNotification : NSObject

@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *trigger;
@property (nonatomic, copy) NSString *triggerName;
@property (nonatomic, copy) NSURL *triggerGravatar;

@property (nonatomic, copy) NSString *triggerUsername;
@property (assign) BOOL isSeen;
@property (assign) BOOL isDismissed;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSDate *updatedAt;
@property (nonatomic, copy) NSString *notificationID;

- (id)initWithOwner:(NSString *)owner
               body:(NSString *)body
               link:(NSString *)link
            trigger:(NSString *)trigger
        triggerName:(NSString *)triggerName
    triggerUsername:(NSString *)triggerUsername
    triggerGravatar:(NSURL *)triggerGravatar
             isSeen:(BOOL)isSeen
        isDismissed:(BOOL)isDismissed
          createdAt:(NSDate *)createdAt
          updatedAt:(NSDate *)updatedAt
     notificationID:(NSString *)notificationID;

+ (void)getNotifications:(void(^)(NSArray *))block;

+ (void)getNotificationsSocket:(void(^)(HBNotification *))block;

@end
