//
//  HBWebViewController.h
//  HackerBracket
//
//  Created by Isaiah Turner on 7/7/14.
//  Copyright (c) 2014 HackerBracket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBWebViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@end
