//
//  LoginScreen.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "LoginScreen.h"
#import "Users.h"
#import "Activities.h"
#import "CoreDataHelper.h"
#import "GlobalVariablesClass.h"
@interface LoginScreen ()

@end

@implementation LoginScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

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

- (IBAction)loginAction:(id)sender
{
    NSArray *userObjects=[[CoreDataHelper sharedInstance] getUserDetails];
    
    for(Users *user in userObjects)
    {
        if([user.username isEqualToString:self.username.text])
        {
            if([user.password isEqualToString:self.password.text])
            {
                self.activityList=[[ActivityListScreen alloc]initWithNibName:@"ActivityListScreen" bundle:nil];
                
                self.activityList.UserName=self.username.text;
                
                [GlobalVariablesClass sharedInstance].CurrentUser=self.username.text;
                
                [self.navigationController pushViewController:self.activityList animated:YES];
            }
        }
    }
    
}
- (IBAction)signupAction:(id)sender
{
   self.signup=[[SignupScreen alloc]initWithNibName:@"SignupScreen" bundle:nil
                ];
    [self.navigationController pushViewController:self.signup animated:YES];
}
@end
