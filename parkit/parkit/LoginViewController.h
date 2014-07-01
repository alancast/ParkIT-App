//
//  LoginViewController.h
//  ParkIT
//
//  Created by allancas on 6/13/14.
//  Copyright (c) 2014 Cisco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginClick:(id)sender;
- (IBAction)backGroundTap:(id)sender;

@end
