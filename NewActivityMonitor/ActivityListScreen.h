//
//  ActivityListScreen.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddActivityScreen.h"
#import "UpdateActivityScreen.h"
#import "ActivityCustomCell.h"
#import "ResetPasswordScreen.h"

@interface ActivityListScreen : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)ResetPasswordScreen *resetScreen;

@property(strong,nonatomic)NSString *UserName;

@property(strong,nonatomic)NSMutableArray *activityArray;
@property(strong,nonatomic)NSMutableArray *expectedStartArray;
@property(strong,nonatomic)NSMutableArray *activityMutableArray;
@property(strong,nonatomic)NSMutableArray *expectedStopArray;
@property(strong,nonatomic)NSMutableArray *activityType;

@property (strong, nonatomic) IBOutlet UIButton *logoutButton;
- (IBAction)logoutAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addActivityButton;
- (IBAction)addActivityAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
- (IBAction)deleteAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *resetPasswordButton;
- (IBAction)resetPasswordAction:(id)sender;

-(IBAction)deleteAccountButtonAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *reportButton;
- (IBAction)reportAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *activityTable;

@property(strong,nonatomic)AddActivityScreen *addActivity;
@property(strong,nonatomic)UpdateActivityScreen *updateScreen;
@property (strong, nonatomic) NSIndexPath *expandedIndexPath;

@end
