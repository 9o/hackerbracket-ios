//
//  HBHack.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBHack.h"

@implementation HBHack

#pragma mark - Init

- (id)initWithId:(NSString *)hackId
           title:(NSString *)title
     description:(NSString *)description
    technologies:(NSString *)technologies
           video:(NSString *)video
       thumbnail:(NSString *)thumbnail
           owner:(NSString *)owner
           likes:(NSString *)likes
        comments:(NSString *)comments {
    
    self = [super init];
    if (self) {
        self.hackId = hackId;
        self.title = title;
        self.description = description;
        self.technologies = technologies;
        self.video = video;
        self.thumbnail = thumbnail;
        self.owner = owner;
        self.likes = likes;
        self.comments = comments;
        
        [HBUser getUserAvatar:self.owner block:^(NSString *gravatar) {
            self.ownerAvatar = gravatar;
        }];
    }
    return self;
}

#pragma mark - Get Hack

+ (void)getHackById:(NSString *)hackId block:(void(^)(HBHack *hack))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/%@", API_GET_HACK, hackId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HBHack *hack = [[HBHack alloc] initWithId:responseObject[@"hack"][@"id"]
                                            title:responseObject[@"hack"][@"title"]
                                      description:responseObject[@"hack"][@"description"]
                                     technologies:responseObject[@"hack"][@"technologies"]
                                            video:responseObject[@"hack"][@"video"]
                                        thumbnail:responseObject[@"hack"][@"thumbnail"]
                                            owner:responseObject[@"hack"][@"owner"]
                                            likes:responseObject[@"hack"][@"likeCount"]
                                         comments:responseObject[@"hack"][@"commentCount"]];
        block(hack);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Get Hacks

+ (void)getHacksWithBlock:(void (^)(NSArray *))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:API_GET_HACK parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *hacks = [NSMutableArray array];
        
        for (id object in responseObject[@"hacks"]) {
            HBHack *hack = [[HBHack alloc] initWithId:object[@"id"]
                                                title:object[@"title"]
                                          description:object[@"description"]
                                         technologies:object[@"technologies"]
                                                video:object[@"video"]
                                            thumbnail:object[@"thumbnail"]
                                                owner:object[@"owner"]
                                                likes:object[@"likeCount"]
                                             comments:object[@"commentCount"]];
            [hacks addObject:hack];
        }

        block(hacks);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

@end
