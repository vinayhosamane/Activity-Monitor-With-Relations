//
//  ResetPasswordScreen.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/29/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "Users.h"
#import "Activities.h"

@interface ResetPasswordScreen : UIViewController

@property(strong,nonatomic)NSString *CurrentUser;

@property(strong,nonatomic)IBOutlet UILabel *username;

@property(strong,nonatomic)IBOutlet UITextField *usernameField;

@property(strong,nonatomic)IBOutlet UILabel *oldpassword;

@property(strong,nonatomic)IBOutlet UITextField *oldpasswordField;

@property(strong,nonatomic)IBOutlet UILabel *newpassword;

@property(strong,nonatomic)IBOutlet UITextField *newpasswordfield;



@property(strong,nonatomic)IBOutlet UIButton *doneButton;


-(IBAction)doneButtonAction:(id)sender;


@end
