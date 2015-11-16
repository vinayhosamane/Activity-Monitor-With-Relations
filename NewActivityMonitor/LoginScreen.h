//
//  LoginScreen.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupScreen.h"
#import "ActivityListScreen.h"

@interface LoginScreen : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *signupButton;
- (IBAction)signupAction:(id)sender;

@property(strong,nonatomic)SignupScreen *signup;
@property(strong,nonatomic)ActivityListScreen *activityList;

@end
