//
//  HBHack.h
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerBracket.h"

@interface HBHack : NSObject

@property (nonatomic, copy) NSString *hackId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *technologies;
@property (nonatomic, copy) NSString *video;
@property (nonatomic, copy) NSURL *thumbnail;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *ownerName;
@property (nonatomic, copy) NSString *ownerUsername;
@property (nonatomic, copy) NSURL *ownerAvatar;
@property (nonatomic, copy) NSNumber *likes;
@property (nonatomic, copy) NSNumber *comments;
@property (assign) BOOL isYouTube;
@property (assign) BOOL isEncoded;
@property (assign) BOOL isLiked;
@property (nonatomic, copy) NSDate *createdAt;
@property (nonatomic, copy) NSArray *team;

typedef enum {
    Trending,
    Following,
    Recent,
} HackListType;


/*!
 Creates a new HBHack object.
 */
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
            team:(NSArray *)team;

/*!
 Returns HBHack object by its id.
 */
+ (void)getHackById:(NSString *)hackId block:(void(^)(HBHack *hack))block;
+ (void)getHacksForUser:(NSString *)user withBlock:(void (^)(NSArray *))block;
/*!
 Returns all hacks.
 */
+ (void)getHacks:(int)hackType skip:(int)skip withBlock:(void (^)(NSArray *))block;
+ (void)submitHackWithTitle:(NSString *)title
                description:(NSString *)description
               technologies:(NSString *)technologies
                    youtube:(NSString *)youtube
                      video:(NSData *)video
                 completion:(void(^)(BOOL success))completion;
+ (void)unlikeHack:(HBHack *)hack
        completion:(void(^)(BOOL success))completion;
+ (void)likeHack:(HBHack *)hack
      completion:(void(^)(BOOL success))completion;
@end
