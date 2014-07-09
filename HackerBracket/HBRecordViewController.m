//
//  HBRecordViewController.m
//  HackerBracket
//
//  Created by Isaiah Turner on 7/1/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBRecordViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface HBRecordViewController ()

@end

@implementation HBRecordViewController
BOOL hasPresented;
UIImagePickerController *imagePickerController;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
}

- (IBAction)submitHack:(id)sender {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    // If video URL, check format.
    if (textField.tag == 4) {
        UITextField *textField = (UITextField*)[self.view viewWithTag:4];
        NSURL *candidateURL = [NSURL URLWithString:textField.text];
        
        if ([candidateURL.host isEqualToString:@"youtube.com"] && [candidateURL.path isEqualToString:@"/video"] && candidateURL.scheme) {
            return;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Video URL"
                                                        message:@"Only http://youtube.com/video?v= URLs may be used."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        UITextField *field = (UITextField *)[[self.videoInputView subviews] objectAtIndex:0];
        NSLog(@"%@",field.text);
        [(UITextField *)[[self.videoInputView subviews] objectAtIndex:0] setText:@""];
        [alert show];
    }
}
- (IBAction)switchMediaType:(id)sender {
    for (UIView *view in [self.videoInputView subviews]) {
        [view removeFromSuperview];
    }
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    switch (segment.selectedSegmentIndex) {
        case 0: {
            UITextField *field = [[UITextField alloc] initWithFrame:self.videoInputView.bounds];
            //field.borderStyle = UITextBorderStyleRoundedRect;
            field.delegate = self;
            field.placeholder = @"Video URL (e.g. http://youtube.com/watch?v=awesome";
            field.font = [UIFont systemFontOfSize:14];
            field.textColor = [UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1.0];
            [self.videoInputView addSubview:field];
            field.tag = 4;
            break;
        }
        case 1: {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = self.videoInputView.bounds;
            [button addTarget:self action:@selector(selectVideoFromLibrary) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"Select from Library" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self.videoInputView addSubview:button];
            break;
        }
        default: {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = self.videoInputView.bounds;
            [button addTarget:self action:@selector(recordAVideo) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:@"Record a Video" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithRed:144.0/255.0 green:204.0/255.0 blue:92.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            [self.videoInputView addSubview:button];
            break;
        }
    }
}

- (void)recordAVideo {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Not Detected"
                                                        message:@"Your device does not appear to have a camera."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Portrait Video Warning"
                                                    message:@"Please rotate your device into landscape mode before recording."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)selectVideoFromLibrary {
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    imagePickerController = [[UIImagePickerController alloc] init];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
