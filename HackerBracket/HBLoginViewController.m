//
//  HBLoginViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 5/15/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBLoginViewController.h"

@interface HBLoginViewController ()

@end

@implementation HBLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Do stuff
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = 5;
}

-(void)viewDidAppear:(BOOL)animated {
    [self.emailTextField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    [HBUser login:self.emailTextField.text password:self.passwordTextField.text block:^(HBUser *user) {
        [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"Feed"] animated:YES completion:nil];
    }];
}

- (void)roundedLayer:(CALayer *)viewLayer
              radius:(float)r
              shadow:(BOOL)s
{
    [viewLayer setMasksToBounds:YES];
    [viewLayer setCornerRadius:r];
    [viewLayer setBorderColor:[[UIColor colorWithRed:180.0/255.0 green:180.0/255.0 blue:180.0/255.0 alpha:1] CGColor]];
    [viewLayer setBorderWidth:1.0f];
    if(s)
    {
        [viewLayer setShadowColor:[[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1] CGColor]];
        [viewLayer setShadowOffset:CGSizeMake(0, 0)];
        [viewLayer setShadowOpacity:1];
        [viewLayer setShadowRadius:2.0];
    }
    return;
}

@end
