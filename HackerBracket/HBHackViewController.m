//
//  HBHackViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/1/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBHackViewController.h"
#import "HBCommentTableViewCell.h"
#import "HBUserTableViewCell.h"
#import "HBLikesTableViewCell.h"
#import "HBTitleTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HBNewCommentTableViewCell.h"

@interface HBHackViewController ()

@end

@implementation HBHackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated {
    NSLog(self.hack.isYouTube ? @"Yes" : @"No");
    self.hackImageView = [[UIImageView alloc] initWithFrame:self.videoView.bounds];
    [self.hackImageView  setImageWithURL:self.hack.thumbnail placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.hackImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.videoView addSubview:self.hackImageView];
    
    if (self.hack.isYouTube) {
        NSURL *videoURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://youtube.com/embed/%@?controls=0&modestbranding=1&showinfo=0",self.hack.video]];
        UIWebView *mPlayer = [[UIWebView alloc] initWithFrame:self.videoView.bounds];
        mPlayer.scrollView.scrollEnabled = NO;
        [mPlayer loadRequest:[NSURLRequest requestWithURL:videoURL]];
        [self.videoView addSubview:mPlayer];
    } else {
        NSURL* videoURL = [NSURL URLWithString:self.hack.video];
        MPMoviePlayerController* mPlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
        mPlayer.movieSourceType = MPMovieSourceTypeStreaming;
        mPlayer.view.backgroundColor = [UIColor clearColor];
        [mPlayer.view setFrame:self.videoView.bounds];
        [mPlayer prepareToPlay];
        [mPlayer play];
        [self.videoView addSubview:mPlayer.view];
        self.videoView = mPlayer.view;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([indexPath row] == 0) {
    HBTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
    if (cell == nil)
    {
        cell = [[HBTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
    }
    cell.titleLabel.text = self.hack.title;
    cell.descriptionLabel.text = self.hack.description;
        return cell;
    } else if ([indexPath row] == 1) {
        HBLikesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likes"];
        if (cell == nil)
        {
            cell = [[HBLikesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"likes"];
        }
        cell.likesLabel.text = [NSString stringWithFormat:@"%@",self.hack.likes];
        [cell.likeButton addTarget:self action:@selector(likeHack:) forControlEvents:UIControlEventTouchUpInside];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%@",self.hack.comments];
        return cell;
    } else if ([indexPath row] == 2) {
        HBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
        if (cell == nil)
        {
            cell = [[HBUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"user"];
        }
        [cell.usernameButton setTitle:self.hack.owner forState:UIControlStateNormal];
        [cell.followButton addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
        [cell.profileImage setImageWithURL:self.hack.ownerAvatar placeholderImage:[UIImage imageNamed:@"avatar"]];
        return cell;
    } else if ([indexPath row] == 3) {
        HBNewCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newComment"];
        if (cell == nil)
        {
            cell = [[HBNewCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newComment"];
        }        return cell;
    } else {
        HBCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        if (cell == nil)
        {
            cell = [[HBCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
        }
        return cell;
    }

}

- (void)follow:(id)sender {
    UIButton *button = sender;
    if (button.tag == 1) {
        button.tag = 0;
        [button setTitle:@"Follow" forState:UIControlStateNormal];
    } else {
        button.tag = 1;
        [button setTitle:@"Following" forState:UIControlStateNormal];
    }}

- (IBAction)shareHack:(id)sender {
    NSMutableArray *sharingItems = [NSMutableArray new];
        [sharingItems addObject:self.hack.title];
        [sharingItems addObject:self.hack.description];
        [sharingItems addObject:self.hackImageView.image];
        [sharingItems addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.hackerbracket.com/hacks/show/%@",self.hack.hackId]]];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4 + 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)likeHack:(id)sender {
    UIButton *button = sender;
    if (button.tag == 1) {
        [button setImage:[UIImage imageNamed:@"hellyeah"] forState:UIControlStateNormal];
        button.tag = 0;
    } else {
        [button setImage:[UIImage imageNamed:@"hellyeah-active"] forState:UIControlStateNormal];
        button.tag = 1;
    }
}

@end
