//
//  HBWebViewController.mHBWebViewController
//  HackerBracket
//
//  Created by Isaiah Turner on 7/7/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import "HBWebViewController.h"

@interface HBWebViewController ()

@end

@implementation HBWebViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)pageActions:(id)sender {
    NSLog(@"Open in Safari");
}

- (IBAction)refreshWebView:(id)sender {
    [self.webView reload];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
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
