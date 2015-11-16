//
//  ActivityCustomCell.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/29/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "ActivityCustomCell.h"
#import "CoreDataHelper.h"
#import "GlobalVariablesClass.h"
#import "Users.h"
#import "Activities.h"

@implementation ActivityCustomCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(IBAction)updateButtonAction:(id)sender
{
    NSLog(@"update button is pressed");
}


-(IBAction)disableButtonAction:(id)sender
{
 NSLog(@"disable button is pressed");
}

-(IBAction)PerFormActivity:(id)sender
{
    
    NSString *myUser=[GlobalVariablesClass sharedInstance].CurrentUser;
    
    if([self.startAndStopSwitch isOn])
    {
        NSArray *userObject= [[CoreDataHelper sharedInstance]getActivitiesForParticularUser:myUser];
        
        for(Users *user in userObject)
        {
            NSArray *temporarySet=[user.userToActivities allObjects];
            
            for(Activities *activity in temporarySet)
            {
                if([activity.activityName isEqualToString:self.activityLabel.text])
                {
                    [[CoreDataHelper sharedInstance] setStartedValue:myUser activityname:self.activityLabel.text boolvalue:YES];
                    
                    //getting current date
                    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
                    NSInteger seconds = [tz secondsFromGMTForDate:[NSDate date]];
                    NSDate *curdate=[NSDate dateWithTimeInterval:seconds sinceDate:[NSDate date]];

                    NSLog(@" start:cur date is %@",curdate);
                    
                    
                    [[CoreDataHelper sharedInstance] setActualStartValue:myUser activityname:self.activityLabel.text Date:curdate];
                }
            }
            
        }
        
        NSLog(@"on");
    }
    else
    {
        NSArray *userObject= [[CoreDataHelper sharedInstance]getActivitiesForParticularUser:myUser];
        
        for(Users *user in userObject)
        {
            NSArray *temporarySet=[user.userToActivities allObjects];
            
            for(Activities *activity in temporarySet)
            {
                if([activity.activityName isEqualToString:self.activityLabel.text])
                {
                    [[CoreDataHelper sharedInstance] setStartedValue:myUser activityname:self.activityLabel.text boolvalue:NO];
                    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
                    NSInteger seconds = [tz secondsFromGMTForDate:[NSDate date]];
                    NSDate *curdate=[NSDate dateWithTimeInterval:seconds sinceDate:[NSDate date]];
                    
                    NSLog(@"stop: cur date is %@",curdate);
                    
                    [[CoreDataHelper sharedInstance] setActualStopValue:myUser activityname:self.activityLabel.text Date:curdate];
                }
            }
            
        }
        
        
        NSLog(@"off");
    }
}


@end
