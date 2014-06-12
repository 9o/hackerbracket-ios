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
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *owner;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *ownerAvatar;

/*!
 Creates a new HBHack object.
 */
- (id)initWithId:(NSString *)hackId
           title:(NSString *)title
     description:(NSString *)description
    technologies:(NSString *)technologies
           video:(NSString *)video
       thumbnail:(NSString *)thumbnail
           owner:(NSString *)owner
           likes:(NSString *)likes
        comments:(NSString *)comments;

/*!
 Returns HBHack object by its id.
 */
+ (void)getHackById:(NSString *)hackId block:(void(^)(HBHack *hack))block;

/*!
 Returns all hacks.
 */
+ (void)getHacksWithBlock:(void(^)(NSArray *hacks))block;

@end
