//
//  HBNotification.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/17/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBNotification.h"

@implementation HBNotification
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
     notificationID:(NSString *)notificationID {
    self = [super init];
    if (self) {
        self.owner = owner;
        self.body = body;
        self.link = link;
        self.trigger = trigger;
        self.triggerName = triggerName;
        self.triggerUsername = triggerUsername;
        self.triggerGravatar = triggerGravatar;
        self.isSeen = isSeen;
        self.isDismissed = isDismissed;
        self.createdAt = createdAt;
        self.updatedAt = updatedAt;
        self.notificationID = notificationID;
    }
    return self;
}

+ (void)getNotifications:(void(^)(NSArray *))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/notifications",API_BASE_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *notifications = [[NSMutableArray alloc] init];
        for (NSDictionary *notification in responseObject[@"notifications"]) {
            HBNotification *notificationObj = [[HBNotification alloc]
initWithOwner:notification[@"owner"]
body:notification[@"body"]
link:notification[@"link"]
trigger:notification[@"trigger"]
triggerName:notification[@"triggerName"]
triggerUsername:notification[@"triggerUsername"]
triggerGravatar: [NSURL URLWithString:notification[@"triggerGravatar"]]
isSeen:[notification[@"isSeen"] boolValue]
isDismissed:[notification[@"isDismissed"] boolValue]
createdAt:[[NSDate alloc] init]
updatedAt:[[NSDate alloc] init]
notificationID:notification[@"id"]];
[notifications addObject:notificationObj];
        }
        NSLog(@"%@",notifications);
        block(notifications);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

@end
