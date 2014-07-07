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
#import "HBBioTableViewCell.h"
#import "HBDarkTableViewCell.h"
#import "HBLightTableViewCell.h"
#import "HBHackTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

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
    if (self.username == nil) {
        self.username = @"i"; // current user
    }
        [HBUser getUser:self.username block:^(HBUser *user){
            self.user = user;
            [HBHack getHacksForUser:self.user.userId withBlock:^(NSArray *hacks){
                self.hacks = hacks;
                [self.tableView reloadData];
            }];
            [self.tableView reloadData];
        }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section] == 0) {
        HBBioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bioCell" forIndexPath:indexPath];
        
        [cell.profileImage setImageWithURL:self.user.gravatar placeholderImage:[UIImage imageNamed:@"profile"]];
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2;
        cell.profileImage.layer.masksToBounds = YES;

        cell.userNameLabel.text = self.user.name;
        cell.bioTextView.text =
    @"Lorem ipsum dolar sit amet de sita.";
        cell.locationLabel.text = self.user.location;
        return cell;

    } else if ([indexPath section] == 1) {
        HBDarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"darkCell" forIndexPath:indexPath];
        UIView *selectionColor = [[UIView alloc] init];
        selectionColor.backgroundColor = [UIColor colorWithRed:(90.0/255.0) green:(184.0/255.0) blue:(77.0/255.0) alpha:1];
        
        // If Follow status cell
        BOOL isNotCurrentUser = ![HBUser isCurrentUser:self.user];
        // Converts cell existance to int, a hacky way of doing things
        int followCell = (isNotCurrentUser ? 1 : 0);
        int linkedinCell = (self.user.linkedin ? 1 : 0);
        int githubCell = (self.user.github ? 1 : 0);
        if (isNotCurrentUser && [indexPath row] == 0) {
            cell.infoImageView.image = [UIImage imageNamed:@"Settings"];
            if (self.user.isFollowing) {
                cell.infoLabel.text = @"Following";
                [cell.contentView setBackgroundColor:[UIColor colorWithRed:(90.0/255.0) green:(184.0/255.0) blue:(77.0/255.0) alpha:0.8]];
            } else {
                cell.infoLabel.text = @"You are not following";
            [cell.contentView setBackgroundColor: [UIColor colorWithRed:(39.0/255.0) green:(39.0/255.0) blue:(39.0/255.0) alpha:0.8]];
            }
        } else if (self.user.linkedin && [indexPath row] == followCell) {
                cell.infoImageView.image = [UIImage imageNamed:@"LinkedIn"];
                cell.infoLabel.text = self.user.linkedin;
            } else if (self.user.github && [indexPath row] == followCell + linkedinCell) {
                cell.infoImageView.image = [UIImage imageNamed:@"GitHub"];
                cell.infoLabel.text = self.user.github;
            } else if (self.user.personalSite && [indexPath row] == followCell + linkedinCell + githubCell) {
                cell.infoImageView.image = [UIImage imageNamed:@"Personal Site"];
                cell.infoLabel.text = self.user.personalSite;
            } else {
                cell.infoImageView.image = [UIImage imageNamed:@"Twitter"];
                cell.infoLabel.text = self.user.twitter;
            }
        cell.selectedBackgroundView = selectionColor;
        return cell;
    } else if ([indexPath section] == 2) {
        // White cells
        HBLightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lightCell" forIndexPath:indexPath];
        if ([indexPath row] == 0) {
            cell.keyLabel.text = @"Followers";
            cell.valueLabel.text = [NSString stringWithFormat:@"%@",self.user.followers];
        } else {
            cell.keyLabel.text = @"Following";
            cell.valueLabel.text = [NSString stringWithFormat:@"%@",self.user.following];
        }
        return cell;
    } else {
        //hack cell
        HBHackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hackCell" forIndexPath:indexPath];
        NSInteger row = [indexPath row];
        HBHack *hack = self.hacks[row];
        [cell.previewImageView setImageWithURL:hack.thumbnail placeholderImage:[UIImage imageNamed:@"Loading"]];
        cell.titleLabel.text = hack.title;
        cell.likesLabel.text = [NSString stringWithFormat:@"%@",hack.likes];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%@",hack.comments];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        return 198;
    } else if ([indexPath section] == 3){
        return 207;
    } else {
        return 35;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    return;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        NSInteger numDarkCells = 0;
        if (![HBUser isCurrentUser:self.user]) {
            numDarkCells++;
        }
        if ([self.user.github length] > 0) {
            numDarkCells++;
        }
        if ([self.user.linkedin length] > 0) {
            numDarkCells++;
        }
        if ([self.user.personalSite length] > 0) {
            numDarkCells++;
        }
        if ([self.user.twitter length] > 0) {
            numDarkCells++;
        }
        return numDarkCells;
    } else if (section == 2) {
        return 2;
    } else {
        return [self.hacks count];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
