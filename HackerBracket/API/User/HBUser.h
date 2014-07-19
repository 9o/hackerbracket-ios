//
//  HBUser.h
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerBracket.h"

@interface HBUser : NSObject

@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *email;

@property (assign) BOOL admin;
@property (assign) BOOL pro;
@property (assign) BOOL isFollowing;

@property (nonatomic, copy) NSNumber *followers;
@property (nonatomic, copy) NSNumber *following;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSURL *gravatar;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *linkedin;
@property (nonatomic, copy) NSString *twitter;
@property (nonatomic, copy) NSString *github;
@property (nonatomic, copy) NSString *personalSite;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSString *languages;
@property (nonatomic, copy) NSString *interests;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *attended;

/*!
 Creates a new HBUser object.
 */
- (id)initWithId:(NSString *)userId
           email:(NSString *)email
           admin:(BOOL)admin
             pro:(BOOL)pro
     isFollowing:(BOOL)isFollowing
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
             bio:(NSString *)bio
        attended:(NSString *)attended;

/*!
 Returns a user object if the user was logged in successfully.
 */
+ (void)login:(NSString *)email password:(NSString *)password block:(void(^)(HBUser *user))block;

/*!
 Logs out the user.
 */
+ (void)logOutWithBlock:(void(^)(BOOL success))block;

/*!
 Gets user by id.
 */
+ (void)getUser:(NSString *)userId block:(void(^)(HBUser *user))block;

/*!
 Follows a user by their id.
 */
+ (void)followUser:(NSString *)userId block:(void(^)(BOOL success))block;

/*
 Checks if the given user is the current user.
 */
+ (BOOL)isCurrentUser:(HBUser *)user;

/*!
 Unfollows user by their id.
 */
+ (void)unfollowUser:(NSString *)userId block:(void(^)(BOOL success))block;

/*!
 Updates user.
 */
+ (void)updateUser:(NSString *)userId withInfo:(NSDictionary *)info;

+ (void)currentUserMeta:(void(^)(NSString *, NSString *, NSURL *))current updatedMeta:(void(^)(NSString *, NSString *, NSURL *))updated;
@end
