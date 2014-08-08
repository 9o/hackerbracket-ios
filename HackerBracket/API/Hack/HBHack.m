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
         isLiked:(BOOL)isLiked
       createdAt:(NSDate *)createdAt
            team:(NSArray *)team {
    
    self = [super init];
    if (self) {
        self.hackId = hackId;
        self.title = title;
        self.descriptionText = description;
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
        self.isLiked = isLiked;
        self.team = team;
    }
    return self;
}

#pragma mark - Get Hacks

+ (void)getHacks:(int)hackType skip:(int)skip withBlock:(void (^)(NSArray *))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *hackTypeString;
    NSLog(@"%u",hackType);
    switch(hackType){
        case Trending:{
            hackTypeString = @"popular";
            break;
        }
        case Following:{
            hackTypeString = @"following";
            break;
        }
        default:{
            hackTypeString = @"recent";
            break;
        }
    }
    NSNumber *skipNum = [NSNumber numberWithInt:skip];
    [manager GET:[NSString stringWithFormat:@"%@/hacks/%@",API_BASE_URL,hackTypeString] parameters:@{ @"skip" : skipNum }success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *hacks = [NSMutableArray array];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.ZZZ'z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        for (id hack in responseObject[@"hacks"]) {
            NSString *video;
            if (hack[@"mp4Video"]) video = hack[@"mp4Video"];
            else video = hack[@"video"];
            NSString *description;
            if (hack[@"description"]) description = hack[@"description"];
            else description = @"";
            HBHack *theHack = [[HBHack alloc] initWithId:hack[@"id"]
                                                   title:hack[@"title"]
                                             description:description
                                            technologies:hack[@"technologies"]
                                                   video:video
                                               thumbnail:[NSURL URLWithString:hack[@"thumbnail"]]
                                                   owner:hack[@"owner"]
                                               ownerName:hack[@"ownerName"]
                                           ownerUsername:hack[@"ownerUsername"]
                                             ownerAvatar:[NSURL URLWithString:hack[@"ownerGravatar"]]
                                                   likes:hack[@"likeCount"]
                                                comments:hack[@"commentCount"]
                                               isYouTube:[hack[@"isYoutube"] boolValue]
                                               isEncoded:[hack[@"isEncoded"] boolValue]
                                                 isLiked:[hack[@"isLiked"] boolValue]
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





+ (void)getHacksForUser:(NSString *)user withBlock:(void (^)(NSArray *))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:[NSString stringWithFormat:@"%@/accounts/users/%@/hacks",API_BASE_URL,user] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *hacks = [NSMutableArray array];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.ZZZ'z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        for (id hack in responseObject[@"hacks"]) {
            NSString *video;
            if (hack[@"mp4Video"]) video = hack[@"mp4Video"];
            else video = hack[@"video"];
            NSString *description;
            if (hack[@"description"]) description = hack[@"description"];
            else description = @"";
            HBHack *theHack = [[HBHack alloc] initWithId:hack[@"id"]
                                                   title:hack[@"title"]
                                             description:description
                                            technologies:hack[@"technologies"]
                                                   video:video
                                               thumbnail:[NSURL URLWithString:hack[@"thumbnail"]]
                                                   owner:hack[@"owner"]
                                               ownerName:hack[@"ownerName"]
                                           ownerUsername:hack[@"ownerUsername"]
                                             ownerAvatar:[NSURL URLWithString:hack[@"ownerGravatar"]]
                                                   likes:hack[@"likeCount"]
                                                comments:hack[@"commentCount"]
                                               isYouTube:[hack[@"isYoutube"] boolValue]
                                               isEncoded:[hack[@"isEncoded"] boolValue]
                                                 isLiked:[hack[@"isLiked"] boolValue]
                                               createdAt: [dateFormatter dateFromString:hack[@"createdAt"]]
                                                    team:hack[@"team"]];
            [hacks addObject:theHack];
        }
        
        block(hacks);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}
+ (void)submitHackWithTitle:(NSString *)title
                description:(NSString *)description
               technologies:(NSString *)technologies
                    youtube:(NSString *)youtube
                  hackathon:(NSString *)hackathon
                      video:(NSData *)video
                 completion:(void(^)(BOOL success))completion
                   progress:(void(^)(float progress))progress {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/hacks",API_BASE_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *awsPerms = responseObject;
        AFHTTPRequestOperation *requestOperation = [manager POST:[NSString stringWithFormat:@"https://hackerbracket.s3.amazonaws.com/"] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            
            [formData appendPartWithFormData:[awsPerms[@"fileName"] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"key"];
            [formData appendPartWithFormData:[awsPerms[@"accessKey"] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"AWSAccessKeyId"];
            [formData appendPartWithFormData:[@"private" dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"acl"];
            [formData appendPartWithFormData:[awsPerms[@"policy"] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"policy"];
            [formData appendPartWithFormData:[awsPerms[@"signed"] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"signature"];

            [formData appendPartWithFileData:video
                                        name:@"file"
                                    fileName:@"video.mp4" mimeType:@"video/mp4"];
            // etc.
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [manager POST:[NSString stringWithFormat:@"%@/hacks",API_BASE_URL] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                
                [formData appendPartWithFormData:[youtube dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"youtube"];
                
                [formData appendPartWithFormData:[title dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"title"];
                
                [formData appendPartWithFormData:[description dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"description"];
                
                [formData appendPartWithFormData:[technologies dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"technologies"];
                
                [formData appendPartWithFormData:[awsPerms[@"fileName"] dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"key"];
                
                [formData appendPartWithFormData:[hackathon dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"hackathonName"];
                // etc.
            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                completion([responseObject[@"upload"][@"success"] boolValue]);
                NSLog(@"Response: %@", responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                completion(FALSE);
                NSLog(@"Error: %@", error);
            }];
            NSLog(@"Response: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            completion(FALSE);
            NSLog(@"Error: %@", error);
        }];
        [requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
            
            float percentDone = ((float)(totalBytesWritten) / (float)(totalBytesExpectedToWrite));
            progress(percentDone);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(FALSE);
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

+ (void)likeHack:(HBHack *)hack
      completion:(void(^)(BOOL success))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[NSString stringWithFormat:@"%@/hacks/%@/likes",API_BASE_URL,hack.hackId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(TRUE);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(TRUE);
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

+ (void)unlikeHack:(HBHack *)hack
      completion:(void(^)(BOOL success))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager DELETE:[NSString stringWithFormat:@"%@/hacks/%@/likes",API_BASE_URL,hack.hackId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(TRUE);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(TRUE);
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

@end
