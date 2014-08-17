//
//  HBLoginViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 5/15/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBUser.h"

@import Security;

@interface HBLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@end
