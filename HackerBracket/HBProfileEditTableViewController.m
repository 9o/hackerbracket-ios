//
//  HBProfileEditTableViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/2/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBProfileEditTableViewController.h"
#import "HBProfileEditTableViewCell.h"

@interface HBProfileEditTableViewController ()

@end

@implementation HBProfileEditTableViewController

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
    self.profileItems = @[
                          @{@"serverParam" : @"username"    , @"display" : @"Username"  , @"placeholder" : @"TeenageCoder"},
                          @{@"serverParam" : @"name"        , @"display" : @"Full Name"  , @"placeholder" : @"Teeanger Coder"},
                          @{@"serverParam" : @"email"       , @"display" : @"Email"     , @"placeholder" : @"steve@teenagercoder.com"},
                          @{@"serverParam" : @"school"      , @"display" : @"School"       , @"placeholder" : @"Harvard"},
                          @{@"serverParam" : @"location"    , @"display" : @"Location"       , @"placeholder" : @"Silicon Valley"},
                          @{@"serverParam" : @"attended"    , @"display" : @"Hackathons"       , @"placeholder" : @"Bitcamp"},
                          @{@"serverParam" : @"languages"         , @"display" : @"Languages"       , @"placeholder" : @"Haskel"},
                          @{@"serverParam" : @"interests"         , @"display" : @"Interests"       , @"placeholder" : @"nxt steve jobs"},
                          @{@"serverParam" : @"phone"         , @"display" : @"Phone"       , @"placeholder" : @"1 (800) MY-APPLE"},
                          @{@"serverParam" : @"twitter"         , @"display" : @"Twiiter"       , @"placeholder" : @"@TeenageCoder"},
                          @{@"serverParam" : @"github"         , @"display" : @"GitHub"       , @"placeholder" : @"@TeenageCoder"},
                          @{@"serverParam" : @"linkedIn"         , @"display" : @"LinkedIn URL"       , @"placeholder" : @""},
                           @{@"serverParam" : @"personalSite"         , @"display" : @"Personal Site"       , @"placeholder" : @"www.TeenageCoder.com"}
                          ];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.profileItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBProfileEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"edit" forIndexPath:indexPath];
    
    NSDictionary *currentCell = [self.profileItems objectAtIndex:[indexPath row]];
    cell.keyLabel.text = currentCell[@"display"];
    cell.valueLabel.placeholder = currentCell[@"placeholder"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
