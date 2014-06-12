//
//  ViewController.m
//  HackerBracket
//
//  Created by Ryan Cohen on 6/6/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HBUser login:@"notryancohen@gmail.com" password:@"password" block:^(HBUser *currentUser) {
        if (currentUser) {
            NSLog(@"Logged in");
            
            /*
            NSLog(@"User name: %@", currentUser.name);
            NSLog(@"User username: %@", currentUser.username);
            NSLog(@"User email: %@", currentUser.email);
            NSLog(@"User school: %@", currentUser.school);
            NSLog(@"User location: %@", currentUser.location);
            NSLog(@"User phone: %@", currentUser.phone);
            NSLog(@"User attended: %@", currentUser.hackathons);
            NSLog(@"User langs: %@", currentUser.languages);
            NSLog(@"User interests: %@", currentUser.interests);
            NSLog(@"User twitter: %@", currentUser.twitter);
            NSLog(@"User github: %@", currentUser.github);
            NSLog(@"User linkedin: %@", currentUser.linkedin);
            NSLog(@"User site: %@", currentUser.site);
             */
            
            /*
            NSDictionary *info = @{ @"username"  : currentUser.username,
                                    @"name"      : currentUser.name,
                                    @"email"     : currentUser.email,
                                    @"school"    : currentUser.school,
                                    @"location"  : currentUser.location,
                                    @"phone"     : currentUser.phone,
                                    @"attended"  : currentUser.hackathons,
                                    @"languages" : currentUser.languages,
                                    @"interests" : currentUser.interests,
                                    @"twitter"   : currentUser.twitter,
                                    @"linkedIn"  : currentUser.linkedin,
                                    @"github"    : currentUser.github,
                                    @"personalSite" : currentUser.site
                                  };
            
            [HBUser updateUser:currentUser.userId withInfo:info];
             */
            
            /*
            [HBUser getFollowers:currentUser.userId block:^(NSArray *followers) {
                
            }];
             */
            
            /*
            [HBHack getHacksWithBlock:^(NSArray *hacks) {
                for (HBHack *hack in hacks) {
                    NSLog(@"Hack: %@", hack.title);
                }
            }];
             */
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
