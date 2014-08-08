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
#import "HBComment.h"
#import "HBProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "HBVideoTableViewCell.h"

@interface HBHackViewController ()

@end

@implementation HBHackViewController
@synthesize mPlayer;
-(void)viewWillAppear:(BOOL)animated {
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [HBComment geCommentsForHack:self.hack.hackId block:^(NSArray *comments) {
        self.comments = comments;
        NSLog(@"%@",comments);
        self.title = self.hack.title;
        NSURL* videoURL = [NSURL URLWithString:self.hack.video];
        mPlayer = [[MPMoviePlayerController alloc] init];
        mPlayer.movieSourceType = MPMovieSourceTypeStreaming;
        mPlayer.view.backgroundColor = [UIColor clearColor];
        mPlayer.movieSourceType = MPMovieSourceTypeStreaming;
        [mPlayer setContentURL:videoURL];
        [mPlayer prepareToPlay];
        [self.tableView reloadData];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doneButtonClick:)
                                                 name:MPMoviePlayerWillExitFullscreenNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    self.commentRect = self.commentView.frame;
    self.tableRect = self.tableView.frame;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)getKeyBoardHeight:(NSNotification *)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSInteger keyboardHeight = keyboardFrameBeginRect.size.height;
    return keyboardHeight;
}

-(void)keyboardWillShow:(NSNotification*) notification
{
    NSInteger keyboardHeight;
    keyboardHeight = [self getKeyBoardHeight:notification];
    NSLog(@"show%ld",(long)keyboardHeight);

    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.frame = self.tableRect;
        self.commentView.frame = self.commentRect;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.tableView.frame = CGRectMake(0, self.tableRect.origin.y,
                                           self.tableRect.size.width,
                                          self.tableRect.size.height - keyboardHeight);
        self.commentView.frame = CGRectMake(0, self.commentRect.origin.y- keyboardHeight,
                                            self.commentRect.size.width,
                                            self.commentRect.size.height);

        [UIView commitAnimations];
    });
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    NSLog(@"hide");
    self.keyboardVisable = FALSE;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.tableView.frame = self.tableRect;
        self.commentView.frame = self.commentRect;
        
        [UIView commitAnimations];
    });
}

- (IBAction)postComment:(id)sender {
    [HBComment postComment:self.commentTextField.text hack:self.hack block:^(HBComment *comment) {
        NSMutableArray *comments = [[NSMutableArray alloc] initWithArray:self.comments];
        [comments addObject:comment];
        self.comments = comments;
        self.commentTextField.text = @"";
        [self.view endEditing:YES];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneButtonClick:(NSNotification*)aNotification{
    NSNumber *reason = [aNotification.userInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    
    if ([reason intValue] == MPMovieFinishReasonUserExited) {
        HBVideoTableViewCell *cell = (HBVideoTableViewCell *)[self.tableView cellForRowAtIndexPath:self.videoPath];
        for (UIView *view in [cell.contentView subviews])
            [view removeFromSuperview];
        [mPlayer.view setFrame:cell.contentView.bounds];
        [cell.contentView addSubview:mPlayer.view];
        [mPlayer prepareToPlay];
        NSLog(@"dd");
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        self.videoPath = indexPath;
        HBVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"videoCell"];
        if (cell == nil)
        {
            cell = [[HBVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"videoCell"];
        }
        NSLog(self.hack.isYouTube ? @"Yes" : @"No");
        self.hackImageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        [self.hackImageView  setImageWithURL:self.hack.thumbnail placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.hackImageView.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:self.hackImageView];
        
        if (self.hack.isYouTube) {
            NSURL *videoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.youtube.com/embed/%@?controls=0&modestbranding=1&showinfo=0",self.hack.video]];
            NSLog(@"%@",[NSString stringWithFormat:@"https://www.youtube.com/embed/%@?controls=0&modestbranding=1&showinfo=0",self.hack.video]);
            UIWebView *webPlayer = [[UIWebView alloc] initWithFrame:cell.contentView.bounds];
            webPlayer.scrollView.scrollEnabled = NO;
            [webPlayer loadRequest:[NSURLRequest requestWithURL:videoURL]];
            [cell.contentView addSubview:webPlayer];
        } else {
            [mPlayer.view setFrame:cell.contentView.bounds];
            [cell.contentView addSubview:mPlayer.view];
        }
        return cell;
    } else if ([indexPath section] == 1) {
    HBTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title"];
    if (cell == nil)
    {
        cell = [[HBTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"title"];
    }
    cell.titleLabel.text = self.hack.title;
    cell.descriptionLabel.text = self.hack.descriptionText;
        cell.descriptionLabel.textContainerInset = UIEdgeInsetsZero;
        cell.descriptionLabel.textContainer.lineFragmentPadding = 0;
        return cell;
    } else if ([indexPath section] == 2) {
        HBLikesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"likes"];
        if (cell == nil)
        {
            cell = [[HBLikesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"likes"];
        }
        cell.likesLabel.text = [NSString stringWithFormat:@"%@",self.hack.likes];
        if (self.hack.isLiked) {
            cell.likeButton.tag = 1;
        } else {
            [cell.likeButton setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
            [cell.likeButton setTitleColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1] forState:UIControlStateNormal];;
        }
        cell.likeButton.layer.masksToBounds = TRUE;
        cell.likeButton.layer.cornerRadius = 4;
        [cell.likeButton addTarget:self action:@selector(likeHack:) forControlEvents:UIControlEventTouchUpInside];
        cell.commentsLabel.text = [NSString stringWithFormat:@"%@",self.hack.comments];
        return cell;
    } else if ([indexPath section] == 4) {
        HBUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user"];
        if (cell == nil)
        {
            cell = [[HBUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"user"];
        }
        [cell.usernameButton setTitle:self.hack.ownerName forState:UIControlStateNormal];
        [cell.followButton addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
        [cell.profileImage setImageWithURL:self.hack.ownerAvatar placeholderImage:[UIImage imageNamed:@"avatar"]];
        return cell;
    } else {
        HBCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
        if (cell == nil)
        {
            cell = [[HBCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
        }
        HBComment *comment = [self.comments objectAtIndex:[indexPath row]];
        cell.commentText.text = comment.body;
        cell.commentText.textContainerInset = UIEdgeInsetsZero;
        cell.commentText.textContainer.lineFragmentPadding = 0;

        UIButton *button = [[UIButton alloc] initWithFrame:cell.usernameButton.frame];
        [cell.usernameButton removeFromSuperview];
        [button addTarget:self action:@selector(showProfile:) forControlEvents:UIControlEventTouchUpInside];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",comment.ownerName] attributes:@{
                                                                                                                              NSForegroundColorAttributeName: [UIColor colorWithRed:(90.0/255.0) green:(184.0/255.0) blue:(77.0/255.0) alpha:1],
                                                                                                                              NSFontAttributeName : [UIFont systemFontOfSize:14]
                                                                                                                              }]  forState:UIControlStateNormal];
        NSMutableAttributedString *attrButtonTitle = [[NSMutableAttributedString alloc] initWithAttributedString:button.titleLabel.attributedText];
        [attrButtonTitle appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" @%@",comment.ownerUsername] attributes:@{
                                                                                                                                                                 NSForegroundColorAttributeName: [UIColor grayColor],
                                                                                                                                                                 NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                                                                                                                                 }]];
         [button setAttributedTitle:attrButtonTitle forState:UIControlStateNormal];
        button.tag = [indexPath row];
        [cell addSubview:button];
        [cell.userImage setImageWithURL:comment.ownerGravatar placeholderImage:[UIImage imageNamed:@"profile"]];
        cell.userImage.layer.cornerRadius = cell.userImage.frame.size.height /2;
        cell.userImage.layer.masksToBounds = YES;
        cell.userImage.layer.borderWidth = 0;
        return cell;
    }

}

- (void)showProfile:(id)sender {
    [self performSegueWithIdentifier:@"showTheProfile" sender:sender];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIButton *button = (UIButton *)sender;
    HBProfileViewController *vc = [segue destinationViewController];
    HBComment *comment = [self.comments objectAtIndex:button.tag];
    vc.username = comment.ownerUsername;
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
    if (section != 3) return 1;
    return [self.comments count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) return 192;
    if ([indexPath section] == 1) {
        NSDictionary *descAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        CGRect descRect = [self.hack.descriptionText boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:descAttributes
                                                  context:nil];
        NSDictionary *titleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGRect titleRect = [self.hack.title boundingRectWithSize:CGSizeMake(280, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:titleAttributes
                            
                                                              context:nil];
        return titleRect.size.height +  descRect.size.height + 42;
    } else if ([indexPath section] == 2) {
        return 50;
    } else {
        NSDictionary *bodyAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        HBComment *comment = [self.comments objectAtIndex:[indexPath row]];
        CGRect bodyRect = [comment.body boundingRectWithSize:CGSizeMake(242, CGFLOAT_MAX)
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                           attributes:bodyAttributes
                                                              context:nil];
        return 65 + bodyRect.size.height;
    }
}

- (void)likeHack:(id)sender {
    UIButton *button = sender;
    if (button.tag == 1) {
        [HBHack likeHack:self.hack completion:^(BOOL success) {
            [button setBackgroundColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.tag = 0;
        }];
    } else {
        [HBHack unlikeHack:self.hack completion:^(BOOL success) {
            [button setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
            [button setTitleColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1] forState:UIControlStateNormal];
            button.tag = 1;
        }];
    }
}

@end
