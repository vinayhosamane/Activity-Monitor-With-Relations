//
//  SignupScreen.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "SignupScreen.h"
#import "CoreDataHelper.h"

@interface SignupScreen ()

@end

@implementation SignupScreen

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

- (IBAction)submitAction:(id)sender
{
    NSArray *userDetails=@[self.fullName.text,self.ageField.text,self.username.text,self.password.text];
    
    [[CoreDataHelper sharedInstance] insertUserDetails:userDetails];
    
    
}
@end
