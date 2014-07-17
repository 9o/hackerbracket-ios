//
//  HackerBracket.h
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

#import "HBUser.h"
#import "HBHack.h"
#import "HBFollow.h"
#import "HBNotification.h"

#define API_BASE_URL    @"http://hackerbracket-api.herokuapp.com/api"
@interface HackerBracket : NSObject

/*!
 Set the API token and secret. (Not implemented yet)
 */
+ (void)setToken:(NSString *)token secret:(NSString *)secret;

@end
