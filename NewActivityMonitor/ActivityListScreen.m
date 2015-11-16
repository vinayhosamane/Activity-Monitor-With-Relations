//
//  ActivityListScreen.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "ActivityListScreen.h"
#import "AddActivityScreen.h"
#import "CoreDataHelper.h"
#import "Activities.h"
#import "Users.h"

@interface ActivityListScreen ()

@end

@implementation ActivityListScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.activityArray=[[NSMutableArray alloc]init];
    self.activityMutableArray=[[NSMutableArray alloc]init];
    self.expectedStartArray=[[NSMutableArray alloc]init];
    self.expectedStopArray=[[NSMutableArray alloc]init];
    self.activityType=[[NSMutableArray alloc]init];
    //[self FillActivityArray];
    
    

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.activityMutableArray removeAllObjects];
    
    [self.activityArray removeAllObjects];
    [self.expectedStartArray removeAllObjects];
    [self.expectedStopArray removeAllObjects];
    [self.activityType removeAllObjects];
    
    [self FillActivityArray];
    
    [self.activityTable reloadData];
}
-(void)FillActivityArray
{
    //NSArray *array=[[CoreDataHelper sharedInstance]getActivitiesDetails];
    
    NSArray *array=[[CoreDataHelper sharedInstance]getActivitiesForParticularUser:self.UserName];
    
    for(Users *user in array)
    {
        NSArray *temp=[user.userToActivities allObjects];
        [self.activityArray addObjectsFromArray:temp];
    }
    
    for(Activities *activity in self.activityArray)
    {
        [self.activityMutableArray addObject:activity.activityName];
        [self.expectedStartArray addObject:activity.expectedStart];
        [self.expectedStopArray addObject:activity.expectedStop];
        [self.activityType addObject:activity.frequency];
        
    }
//    for(Activities *activity in array)
//    {
//        [self.activityArray addObject:activity.activityName];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activityMutableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    
    ActivityCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityCustomCell" owner:nil options:nil];
        
        for (id currentObject in topLevelObjects) {
            
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                
                cell = (ActivityCustomCell *)currentObject;
                break;
            }
        }
    }

    
//    Activities *activityObject=[self.activityArray objectAtIndex:indexPath.row];
    
   //cell.textLabel.text=[self.activityMutableArray objectAtIndex:indexPath.row];
    
    cell.activityLabel.text=[self.activityMutableArray objectAtIndex:indexPath.row];
    cell.startLabel.text=[self.expectedStartArray objectAtIndex:indexPath.row];
    cell.stopLabel.text=[self.expectedStopArray objectAtIndex:indexPath.row];
    cell.activityType.text=[self.activityType objectAtIndex:indexPath.row];
    
    if (self.expandedIndexPath==indexPath)
    {
        
        cell.activityType.hidden=NO;
        cell.startLabel.hidden=NO;
        cell.stopLabel.hidden=NO;
        cell.startAndStopSwitch.hidden=NO;
        cell.dash.hidden=NO;
        cell.updateButton.hidden=NO;
        
        cell.disableButton.hidden=NO;
        
    }
    else
    {
        cell.activityType.hidden=YES;
        cell.startLabel.hidden=YES;
        cell.stopLabel.hidden=YES;
        cell.startAndStopSwitch.hidden=YES;
       
        cell.dash.hidden=YES;
        cell.updateButton.hidden=YES;
       
        cell.disableButton.hidden=YES;

    }

    BOOL bool_started=[[CoreDataHelper sharedInstance] checkActivityStartedOrNot:self.UserName activityname:[self.activityMutableArray objectAtIndex:indexPath.row]];
    
    if(bool_started)
    {
        cell.startAndStopSwitch.on=YES;
    }
    else
    {
        cell.startAndStopSwitch.on=NO;
    }
    

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
        self.expandedIndexPath = nil;
        
    }
    else
    {
        self.expandedIndexPath = indexPath;
    }
    
    [self.activityTable reloadData];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath compare:self.expandedIndexPath] == NSOrderedSame) {
       
        return 150.0; // Expanded height
    }
    
    else
       
        return 40.0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)addActivityAction:(id)sender
{
    self.addActivity=[[AddActivityScreen alloc]initWithNibName:@"AddActivityScreen" bundle:nil];
    self.addActivity.username=self.UserName;
    [self.navigationController pushViewController:self.addActivity animated:YES];
}

//- (IBAction)updateActivityAction:(id)sender
//{
//    self.updateScreen=[[UpdateActivityScreen alloc]initWithNibName:@"UpdateActivityScreen" bundle:nil];
//    
//    [self.navigationController pushViewController:self.updateScreen animated:YES];
//}

-(IBAction)refreshAction:(id)sender
{
    [self.activityMutableArray removeAllObjects];
    
    [self.activityArray removeAllObjects];
    [self.expectedStartArray removeAllObjects];
    [self.expectedStopArray removeAllObjects];
    [self.activityType removeAllObjects];
    
    [self FillActivityArray];
    
    [self.activityTable reloadData];
}

-(IBAction)deleteAction:(id)sender
{
    if([self.activityTable isEditing])
    {
        [self.activityTable setEditing:NO animated:YES];
        [self.deleteButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else
    {
        [self.deleteButton setTitle:@"Done" forState:UIControlStateNormal];
        [self.activityTable setEditing:YES animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.activityTable.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [[CoreDataHelper sharedInstance] deleteActivity:self.UserName activityname:[self.activityMutableArray objectAtIndex:indexPath.row]];
        
        
        [self.activityMutableArray removeAllObjects];
        
        [self.activityArray removeAllObjects];
        [self.expectedStartArray removeAllObjects];
        [self.expectedStopArray removeAllObjects];
        [self.activityType removeAllObjects];
        
        [self FillActivityArray];
        
        [self.activityTable reloadData];

    }
}

- (IBAction)resetPasswordAction:(id)sender
{
    self.resetScreen=[[ResetPasswordScreen alloc]initWithNibName:@"ResetPasswordScreen" bundle:nil];
    
    self.resetScreen.CurrentUser=self.UserName;
    
    [self.navigationController pushViewController:self.resetScreen animated:YES];
}

//report method

- (IBAction)reportAction:(id)sender
{
    
    
}

-(IBAction)deleteAccountButtonAction:(id)sender
{
    BOOL flag=[[CoreDataHelper sharedInstance]deleteUserDetails:self.UserName];
    
    if(flag)
        NSLog(@"user details deleted");
    else
        NSLog(@"user details not deleted");
}

- (IBAction)logoutAction:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
