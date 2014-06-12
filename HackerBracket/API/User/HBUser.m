//
//  HBUser.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBUser.h"

@implementation HBUser

#pragma mark - Init

- (id)initWithId:(NSString *)userId
           email:(NSString *)email
            name:(NSString *)name
        username:(NSString *)username
        gravatar:(NSString *)gravatar
          school:(NSString *)school
        location:(NSString *)location
           phone:(NSString *)phone
        linkedin:(NSString *)linkedin
         twitter:(NSString *)twitter
          github:(NSString *)github
            site:(NSString *)site
       languages:(NSString *)languages
       interests:(NSString *)interests
      hackathons:(NSString *)hackathons {
    
    self = [super init];
    if (self) {
        self.userId = userId;
        self.email = email;
        self.name = name;
        self.username = username;
        self.gravatar = gravatar;
        self.school = school;
        self.location = location;
        self.phone = phone;
        self.linkedin = linkedin;
        self.twitter = twitter;
        self.github = github;
        self.site = site;
        self.languages = languages;
        self.interests = interests;
        self.hackathons = hackathons;
    }
    return self;
}

#pragma mark - Login

+ (void)login:(NSString *)email password:(NSString *)password block:(void (^)(HBUser *user))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"email"   : email,
                                  @"password": password };
    
    [manager POST:API_LOGIN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200) {
            HBUser *user = [[HBUser alloc] initWithId:responseObject[@"user"][@"id"]
                                                email:responseObject[@"user"][@"email"]
                                                 name:responseObject[@"user"][@"name"]
                                             username:responseObject[@"user"][@"username"]
                                             gravatar:responseObject[@"user"][@"gravatar"]
                                               school:responseObject[@"user"][@"school"]
                                             location:responseObject[@"user"][@"location"]
                                                phone:responseObject[@"user"][@"phone"]
                                             linkedin:responseObject[@"user"][@"linkedIn"]
                                              twitter:responseObject[@"user"][@"twitter"]
                                               github:responseObject[@"user"][@"github"]
                                                 site:responseObject[@"user"][@"personalSite"]
                                            languages:responseObject[@"user"][@"languages"]
                                            interests:responseObject[@"user"][@"interests"]
                                           hackathons:responseObject[@"user"][@"attended"]];
            block(user);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Logout

+ (void)logOutWithBlock:(void(^)(BOOL success))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:API_LOGOUT parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200) {
            block(true);
        } else {
            block(false);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Get User

+ (void)getUser:(NSString *)userId block:(void(^)(HBUser *user))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/%@", API_GET_USER, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HBUser *user = [[HBUser alloc] initWithId:responseObject[@"user"][@"id"]
                                            email:responseObject[@"user"][@"email"]
                                             name:responseObject[@"user"][@"name"]
                                         username:responseObject[@"user"][@"username"]
                                         gravatar:responseObject[@"user"][@"gravatar"]
                                           school:responseObject[@"user"][@"school"]
                                         location:responseObject[@"user"][@"location"]
                                            phone:responseObject[@"user"][@"phone"]
                                         linkedin:responseObject[@"user"][@"linkedIn"]
                                          twitter:responseObject[@"user"][@"twitter"]
                                           github:responseObject[@"user"][@"github"]
                                             site:responseObject[@"user"][@"personalSite"]
                                        languages:responseObject[@"user"][@"languages"]
                                        interests:responseObject[@"user"][@"interests"]
                                       hackathons:responseObject[@"user"][@"attended"]];
        
        block(user);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Get User Avatar

+ (void)getUserAvatar:(NSString *)userId block:(void(^)(NSString *gravatar))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/%@", API_GET_USER, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        block(responseObject[@"user"][@"gravatar"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Follow User

+ (void)followUser:(NSString *)userId block:(void(^)(BOOL success))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/%@/followers", API_GET_USER, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(true);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Unfollow User

+ (void)unfollowUser:(NSString *)userId block:(void (^)(BOOL))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:[NSString stringWithFormat:@"%@/%@/followers", API_GET_USER, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(true);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        block(false);
    }];
}

#pragma mark - Get Followers

+ (void)getFollowers:(NSString *)userId block:(void(^)(NSArray *followers))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/%@/followers", API_GET_USER, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res: %@", responseObject);
        /*
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
         */
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Update User

+ (void)updateUser:(NSString *)userId withInfo:(NSDictionary *)info {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"username"  : [info valueForKey:@"username"],
                                  @"name"      : [info valueForKey:@"name"],
                                  @"email"     : [info valueForKey:@"email"],
                                  @"school"    : [info valueForKey:@"school"],
                                  @"location"  : [info valueForKey:@"location"],
                                  @"phone"     : [info valueForKey:@"phone"],
                                  @"attended"  : [info valueForKey:@"attended"],
                                  @"languages" : [info valueForKey:@"languages"],
                                  @"interests" : [info valueForKey:@"interests"],
                                  @"phone"     : [info valueForKey:@"phone"],
                                  @"twitter"   : [info valueForKey:@"twitter"],
                                  @"personalSite" : [info valueForKey:@"personalSite"],
                                  @"linkedIn"  : [info valueForKey:@"linkedIn"],
                                  @"github"    : [info valueForKey:@"github"],
                                };
    
    [manager PUT:[NSString stringWithFormat:@"%@/%@", API_GET_USER, userId] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

@end
