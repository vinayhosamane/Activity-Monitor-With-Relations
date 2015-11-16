//
//  ResetPasswordScreen.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/29/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "ResetPasswordScreen.h"

@interface ResetPasswordScreen ()

@end

@implementation ResetPasswordScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(IBAction)doneButtonAction:(id)sender
{
    NSArray * users=[[CoreDataHelper sharedInstance] getUserDetails];
    
    for (Users *user in users)
    {
        if([user.username isEqualToString:self.CurrentUser] && [user.password isEqualToString:self.oldpasswordField.text])
        {
            BOOL flag=[[CoreDataHelper sharedInstance] setPasswordOfUser:self.CurrentUser password:self.newpasswordfield.text];
            
            if(flag)
            {
                NSLog(@"password set");
            }
            else
            {
                NSLog(@"password not set");
            }
        }
        
        else
        {
            NSLog(@"username or password incorrect");
        }
    }

}


@end
