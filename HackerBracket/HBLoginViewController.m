//
//  HBLoginViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 5/15/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBLoginViewController.h"
#import "KeychainItemWrapper.h"
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
-(void)viewWillAppear:(BOOL)animated {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
    self.passwordTextField.text = [keychainItem objectForKey:(__bridge id)(kSecValueData)];
    self.emailTextField.text = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    self.passwordTextField.delegate = self;
    self.emailTextField.delegate = self;

}
-(void)viewDidAppear:(BOOL)animated {
    [self.emailTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)passwordTextField {
    if ([self.passwordTextField.text isEqualToString:@""] || ([self.emailTextField.text isEqualToString:@""])) {
        
    } else {
        [self login];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    [HBUser login:self.emailTextField.text password:self.passwordTextField.text block:^(HBUser *user) {
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
        [keychainItem setObject:self.passwordTextField.text forKey:(__bridge id)(kSecValueData)];
        [keychainItem setObject:self.emailTextField.text forKey:(__bridge id)(kSecAttrAccount)];
        
        [self performSegueWithIdentifier:@"getStarted" sender:self];
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        /*if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        }
        else
        {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        }*/
    }];
}

-(void)login {
    [HBUser login:self.emailTextField.text password:self.passwordTextField.text block:^(HBUser *user) {
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"Login" accessGroup:nil];
        [keychainItem setObject:self.passwordTextField.text forKey:(__bridge id)(kSecValueData)];
        [keychainItem setObject:self.emailTextField.text forKey:(__bridge id)(kSecAttrAccount)];
        
        [self performSegueWithIdentifier:@"getStarted" sender:self];
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        /*if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
         {
         [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
         [[UIApplication sharedApplication] registerForRemoteNotifications];
         }
         else
         {
         [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
         }*/
    }];

}

- (IBAction)createAccount:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Create Account" message:@"Visit www.HackerBracket.com to create an account." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
