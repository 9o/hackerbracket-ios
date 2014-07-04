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
           admin:(BOOL)admin
             pro:(BOOL)pro
       followers:(NSNumber *)followers
       following:(NSNumber *)following
            name:(NSString *)name
        username:(NSString *)username
        gravatar:(NSURL *)gravatar
          school:(NSString *)school
        location:(NSString *)location
           phone:(NSString *)phone
        linkedin:(NSString *)linkedin
         twitter:(NSString *)twitter
          github:(NSString *)github
    personalSite:(NSString *)personalSite
       createdAt:(NSDate *)createdAt
       languages:(NSString *)languages
       interests:(NSString *)interests
      attended:(NSString *)attended {
    
    self = [super init];
    if (self) {
        self.userId = userId;
        self.email = email;
        self.admin = admin;
        self.followers = followers;
        self.following = following;
        self.name = name;
        self.username = username;
        self.gravatar = gravatar;
        self.school = school;
        self.location = location;
        self.phone = phone;
        self.linkedin = linkedin;
        self.twitter = twitter;
        self.github = github;
        self.personalSite = personalSite;
        self.createdAt = createdAt;
        self.languages = languages;
        self.interests = interests;
        self.attended = attended;
    }
    return self;
}

#pragma mark - Login

+ (void)login:(NSString *)email password:(NSString *)password block:(void (^)(HBUser *user))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{ @"email"   : email,
                                  @"password": password };
    
    [manager POST:[NSString stringWithFormat:@"%@/login",API_BASE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([operation.response statusCode] == 200) {
            NSDictionary *user = responseObject[@"user"];
            HBUser *theUser = [[HBUser alloc]
                               initWithId:user[@"id"]
                               email:user[@"email"]
                               admin:[user[@"admin"] boolValue]
                               pro:[user[@"pro"] boolValue]
                               followers:user[@"followers"]
                               following:user[@"following"]
                               name:user[@"name"]
                               username:user[@"username"]
                               gravatar:[NSURL URLWithString:user[@"gravatar"]]
                               school:user[@"school"]
                               location:user[@"location"]
                               phone:user[@"phone"]
                               linkedin:user[@"linkedIn"]
                               twitter:user[@"twitter"]
                               github:user[@"github"]
                               personalSite:user[@"personalSite"]
                               createdAt:[NSDate alloc]
                               languages:user[@"languages"]
                               interests:user[@"interests"]
                               attended:user[@"attended"]];

            block(theUser);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Logout

+ (void)logOutWithBlock:(void(^)(BOOL success))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/logout",API_BASE_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+ (void)getUser:(NSString *)username block:(void(^)(HBUser *user))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%@/accounts/users/%@",API_BASE_URL,username] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *user = responseObject[@"user"];
        HBUser *theUser = [[HBUser alloc]
                           initWithId:user[@"id"]
                           email:user[@"email"]
                           admin:[user[@"admin"] boolValue]
                           pro:[user[@"pro"] boolValue]
                           followers:user[@"followers"]
                           following:user[@"following"]
                           name:user[@"name"]
                           username:user[@"username"]
                           gravatar:[NSURL URLWithString:user[@"gravatar"]]
                           school:user[@"school"]
                           location:user[@"location"]
                           phone:user[@"phone"]
                           linkedin:user[@"linkedIn"]
                           twitter:user[@"twitter"]
                           github:user[@"github"]
                           personalSite:user[@"personalSite"]
                           createdAt:[NSDate alloc]
                           languages:user[@"languages"]
                           interests:user[@"interests"]
                           attended:user[@"attended"]];
        
        block(theUser);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Follow User

+ (void)followUser:(NSString *)userId block:(void(^)(BOOL success))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:[NSString stringWithFormat:@"%@/accounts/users/%@/followers",API_BASE_URL, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(true);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Unfollow User

+ (void)unfollowUser:(NSString *)userId block:(void (^)(BOOL))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:[NSString stringWithFormat:@"%@/accounts/users/%@/followers",API_BASE_URL, userId] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(true);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        block(false);
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
    
    [manager PUT:[NSString stringWithFormat:@"%@/accounts/users/%@",API_BASE_URL, userId] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"res: %@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

@end
