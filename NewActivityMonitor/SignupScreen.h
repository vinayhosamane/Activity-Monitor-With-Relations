//
//  SignupScreen.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupScreen : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *fullName;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *ageField;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitAction:(id)sender;

@end
