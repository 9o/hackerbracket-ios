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
       thumbnail:(NSURL *)thumbnail
           owner:(NSString *)owner
       ownerName:(NSString *)ownerName
   ownerUsername:(NSString *)ownerUsername
   ownerAvatar:(NSURL *)ownerAvatar
           likes:(NSNumber *)likes
        comments:(NSNumber *)comments
       isYouTube:(BOOL)isYouTube
       isEncoded:(BOOL)isEncoded
       createdAt:(NSDate *)createdAt
            team:(NSArray *)team {
    
    self = [super init];
    if (self) {
        self.hackId = hackId;
        self.title = title;
        self.description = description;
        self.technologies = technologies;
        self.video = video;
        self.thumbnail = thumbnail;
        self.owner = owner;
        self.ownerName = ownerName;
        self.ownerUsername = ownerUsername;
        self.ownerAvatar = ownerAvatar;
        self.likes = likes;
        self.comments = comments;
        self.isEncoded = isEncoded;
        self.isYouTube = isYouTube;
        self.team = team;
    }
    return self;
}

#pragma mark - Get Hack

+ (void)getHackById:(NSString *)hackId block:(void(^)(HBHack *hack))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/hacks/%@",API_BASE_URL,hackId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *hack = responseObject[@"hack"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.ZZZ'z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        HBHack *theHack = [[HBHack alloc] initWithId:hack[@"id"]
                                            title:hack[@"title"]
                                      description:hack[@"description"]
                                     technologies:hack[@"technologies"]
                                            video:hack[@"video"]
                                        thumbnail:[NSURL URLWithString:hack[@"thumbnail"]]
                                            owner:hack[@"owner"]
                                            ownerName:hack[@"ownerName"]
                                       ownerUsername:hack[@"ownerUsername"]
                                         ownerAvatar:[NSURL URLWithString:hack[@"ownerGravatar"]]
                                            likes:hack[@"likeCount"]
                                         comments:hack[@"commentCount"]
                                        isYouTube:[hack[@"isYoutube"] boolValue]
                                        isEncoded:[hack[@"isEncoded"] boolValue]
                                        createdAt: [dateFormatter dateFromString:hack[@"createdAt"]]
                                             team:hack[@"team"]];
        block(theHack);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Get Hacks

+ (void)getHacksWithBlock:(void (^)(NSArray *))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/hacks/recent",API_BASE_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *hacks = [NSMutableArray array];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.ZZZ'z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        for (id hack in responseObject[@"hacks"]) {
            HBHack *theHack = [[HBHack alloc] initWithId:hack[@"id"]
                                                   title:hack[@"title"]
                                             description:hack[@"description"]
                                            technologies:hack[@"technologies"]
                                                   video:hack[@"video"]
                                               thumbnail:[NSURL URLWithString:hack[@"thumbnail"]]
                                                   owner:hack[@"owner"]
                                               ownerName:hack[@"ownerName"]
                                           ownerUsername:hack[@"ownerUsername"]
                                             ownerAvatar:[NSURL URLWithString:hack[@"ownerGravatar"]]
                                                   likes:hack[@"likeCount"]
                                                comments:hack[@"commentCount"]
                                               isYouTube:[hack[@"isYoutube"] boolValue]
                                               isEncoded:[hack[@"isEncoded"] boolValue]
                                               createdAt: [dateFormatter dateFromString:hack[@"createdAt"]]
                                                    team:hack[@"team"]];
            [hacks addObject:theHack];
        }

        block(hacks);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

+ (void)submitHack:(NSString *)title description:(NSString *)description
      technologies:(NSString *)technologies
             video:(NSURL *)videoURL
           youtube:(NSString *)youtube
         thumbnail:(NSString *)thumbnail
        completion:(void(^)(BOOL success, HBHack *hack))completion {
    
}

@end
