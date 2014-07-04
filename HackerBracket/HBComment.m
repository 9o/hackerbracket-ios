//
//  HBComment.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/4/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBComment.h"

@implementation HBComment
-(id)initWithBody:(NSString *)body createdAt:(NSDate *)createdAt owner:(NSString *)owner ownerGravatar:(NSURL *)ownerGravatar ownerName:(NSString *)ownerName ownerUsername:(NSString *)ownerUsername {
    self = [super init];
    if (self) {
        self.body = body;
        self.createdAt = createdAt;
        self.owner = owner;
        self.ownerGravatar = ownerGravatar;
        self.ownerName = ownerName;
        self.ownerUsername = ownerUsername;
    }
    return self;
}

+ (void)geCommentsForHack:(NSString *)hackId block:(void(^)(NSArray *comments))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/hacks/%@/comments",API_BASE_URL,hackId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *comments = responseObject[@"comments"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.ZZZ'z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        NSMutableArray *commentsArr = [[NSMutableArray alloc] init];
        for (NSDictionary *comment in comments) {
            HBComment *commentObj = [[HBComment alloc] initWithBody:comment[@"body"] createdAt:[NSDate alloc] owner:comment[@"owner"] ownerGravatar:[NSURL URLWithString:comment[@"ownerGravatar"]] ownerName:comment[@"ownerName"] ownerUsername:comment[@"ownerUsername"]];
            [commentsArr addObject:commentObj];
        }
        NSLog(@"%@",commentsArr);
        block(commentsArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}
@end
