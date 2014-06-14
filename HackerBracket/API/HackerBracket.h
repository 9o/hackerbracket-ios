//
//  HackerBracket.h
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import "HBUser.h"
#import "HBHack.h"

#ifdef DEBUG
    #define API_BASE_URL    @"http://localhost:1337/api/"
    #define API_LOGIN       @"http://localhost:1337/api/login"
    #define API_LOGOUT      @"http://localhost:1337/api/logout"
    #define API_GET_USER    @"http://localhost:1337/api/accounts/users"
    #define API_GET_HACK    @"http://localhost:1337/api/hacks"
#else
    #define API_BASE_URL    @"http://hackerbracket-api.herokuapp.com/api/"
    #define API_LOGIN       @"http://hackerbracket-api.herokuapp.com/api/login"
    #define API_LOGOUT      @"http://hackerbracket-api.herokuapp.com/api/logout"
    #define API_GET_USER    @"http://hackerbracket-api.herokuapp.com/api/accounts/users"
    #define API_GET_HACK    @"http://hackerbracket-api.herokuapp.com/api/hacks"
#endif

@interface HackerBracket : NSObject

/*!
 Set the API token and secret. (Not implemented yet)
 */
+ (void)setToken:(NSString *)token secret:(NSString *)secret;

@end
