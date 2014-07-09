//
//  HBFollower.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/4/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBFollow.h"

@implementation HBFollow

- (id)initWithId:(NSString *)userId
        gravatar:(NSURL *)gravatar
            name:(NSString *)name
        username:(NSString *)username
       createdAt:(NSDate *)createdAt {
    self = [super init];
    if (self) {
        self.userId = userId;
        self.gravatar = gravatar;
        self.name = name;
        self.username = username;
        self.createdAt = createdAt;
    }
    return self;
}

+ (void)getFollowers:(NSString *)userId block:(void(^)(NSArray *followers))block {
    NSLog(@"F");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/accounts/users/%@/followers",API_BASE_URL, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *followers = [[NSMutableArray alloc] init];
        for (id user in responseObject[@"followers"]) {
            [followers addObject:[[HBFollow alloc] initWithId:userId
                                                       gravatar:[NSURL URLWithString:user[@"followerGravatar"]]
                                                           name:user[@"followerName"]
                                                       username:user[@"followerUsername"]
                                                      createdAt:[[NSDate alloc] init]] ];
        }
        block(followers);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}
+ (void)getFollowing:(NSString *)userId block:(void(^)(NSArray *followers))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/accounts/users/%@/following",API_BASE_URL, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *followers = [[NSMutableArray alloc] init];
        for (id user in responseObject[@"following"]) {
            [followers addObject:[[HBFollow alloc] initWithId:userId
                                                     gravatar:[NSURL URLWithString:user[@"userFollowedGravatar"]]
                                                         name:user[@"userFollowedName"]
                                                     username:user[@"userFollowedUsername"]
                                                      createdAt:[[NSDate alloc] init]] ];
        }
        block(followers);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}
@end
