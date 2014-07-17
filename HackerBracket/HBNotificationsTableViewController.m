//
//  HBNotificationsTableViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/17/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBNotificationsTableViewController.h"
#import "HBNotificationsTableViewCell.h"
#import "HackerBracket.h"
#import <QuartzCore/QuartzCore.h>

@interface HBNotificationsTableViewController ()

@end

@implementation HBNotificationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.notifications = [[NSArray alloc] init];
    [HBNotification getNotifications:^(NSArray *notifications) {
        self.notifications = notifications;
        NSLog(@"%@",notifications);
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.notifications count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"notification";
    HBNotificationsTableViewCell *cell = (HBNotificationsTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[HBNotificationsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    HBNotification *notification = [self.notifications objectAtIndex:[indexPath row]];
    cell.notificationTextView.text = [NSString stringWithFormat:@"%@ %@", notification.triggerName, notification.body];
    cell.notificationTextView.textContainerInset = UIEdgeInsetsZero;
    [cell.notificationImage setImageWithURL:notification.triggerGravatar placeholderImage:[UIImage imageNamed:@"profile"]];
    cell.notificationImage.layer.masksToBounds = YES;
    cell.notificationImage.layer.cornerRadius = cell.notificationImage.frame.size.height / 2;
    cell.notificationDateLabel.text = @"Just now";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    HBNotification *notification = [self.notifications objectAtIndex:[indexPath row]];
    CGRect titleRect = [[NSString stringWithFormat:@"%@ %@", notification.triggerName, notification.body] boundingRectWithSize:CGSizeMake(199, CGFLOAT_MAX)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:titleAttributes
                                                     context:nil];
    return 40 + titleRect.size.height;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
