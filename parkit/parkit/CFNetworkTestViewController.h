//
//  CFNetworkTestViewController.h
//  parkit
//
//  Created by allancas on 6/19/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFNetworkTestViewController : UIViewController<NSURLConnectionDataDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *sourceCodeView;

@end
