//
//  HBRecordViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/1/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M13ProgressHUD.h"
#import "M13ProgressViewRing.h"

@interface HBRecordViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *technologiesTextField;
@property (weak, nonatomic) IBOutlet UITextField *teamMembersTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *videoInputView;
@property (nonatomic, strong) NSData *videoData;
@property (nonatomic, strong) NSString *youtubeURL;
@property (strong, nonatomic) IBOutlet UITextField *hackathonLabel;

@end
