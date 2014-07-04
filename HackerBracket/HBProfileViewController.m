//
//  HBProfileViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/2/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HBFollowTableViewController.h"

@interface HBProfileViewController ()

@end

@implementation HBProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameLabel.text = self.user.name;
    [self.followersButton setTitle:[NSString stringWithFormat:@"%@",self.user.followers] forState:UIControlStateNormal];
    if (self.username == nil) {
        self.username = @"i"; // current user
    }
        [HBUser getUser:self.username block:^(HBUser *user){
            self.user = user;
            [self updateUserInfo];
        }];
}

-(void)updateUserInfo {
    self.title = self.user.name;
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.username];
    [self.profileImage setImageWithURL:self.user.gravatar placeholderImage:[UIImage imageNamed:@"avatar"]];
    [self.followersButton setTitle:[NSString stringWithFormat:@"%@ Followers", self.user.followers] forState:UIControlStateNormal];
    [self.followingButton setTitle:[NSString stringWithFormat:@"%@ Following", self.user.following] forState:UIControlStateNormal];
    self.profileInfo.text = [NSString stringWithFormat:@"Email: %@\nSchool: %@\nLocation: %@\nPhone: %@\nLinkedIn: %@\nTwitter: %@\nGitHub: %@\nPersonal Site: %@\nLanguages: %@\nInterests: %@\nAttended: %@",self.user.email,self.user.school,self.user.location,self.user.phone,self.user.linkedin,self.user.twitter,self.user.github,self.user.personalSite,self.user.languages,self.user.interests,self.user.attended];
    if (self.user.admin) {
        self.rankLabel.text = @"Admin";
    } else if (self.user.pro) {
        self.rankLabel.text = @"Pro";
    } else {
        self.rankLabel.text = @"";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]  isEqualToString:@"following"]) {
        HBFollowTableViewController *vc = [segue destinationViewController];
        vc.showFollowing = TRUE;
        vc.user = self.user.userId;
    } else if ([[segue identifier]  isEqualToString:@"followers"]) {
        HBFollowTableViewController *vc = [segue destinationViewController];
        vc.showFollowing = FALSE;
        vc.user = self.user.userId;
    }
}

@end
