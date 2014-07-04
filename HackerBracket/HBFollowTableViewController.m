//
//  HBFollowTableViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/3/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBFollowTableViewController.h"
#import "HBFollowTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HBProfileViewController.h"

@interface HBFollowTableViewController ()

@end

@implementation HBFollowTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateList];
    if (self.showFollowing) {
        self.title = @"Following";
    } else {
        self.title = @"Followers";
    }
}

- (void)updateList {
    NSLog(@"%@",self.user);
    if (self.showFollowing) {
        
        [HBFollow getFollowers:self.user block:^(NSArray *people) {
            self.people = people;
            
            [self.tableView reloadData];
        }];
    } else {
        [HBFollow getFollowing:self.user block:^(NSArray *people) {
            self.people = people;
            NSLog(@"%@",people);
            [self.tableView reloadData];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.people count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBFollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
    
    HBUser *user = [self.people objectAtIndex:[indexPath row]];
    [cell.profileImage setImageWithURL:user.gravatar placeholderImage:[UIImage imageNamed:@"profile"]];
     cell.usernameLabel.text = user.username;
     cell.nameLabel.text = user.name;
     
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HBProfileViewController *vc = [segue destinationViewController];
    HBFollow *selectedUser = [self.people objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    vc.username = selectedUser.username;
}
@end
