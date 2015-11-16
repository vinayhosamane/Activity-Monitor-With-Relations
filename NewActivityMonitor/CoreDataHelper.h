//
//  CoreDataHelper.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

//Insert Method
- (void)insertUserDetails:(NSArray *)data;
-(void)insertActivityDetails:(NSArray *)data user:(NSString *)username;

//Get methods user and activity details
- (NSArray *)getUserDetails;
- (NSArray *)getActivitiesDetails;

//get method for particular user and activity details
-(NSArray *)getParticularUserDetails:(NSString *)user;
-(NSArray *)getParticularActivityDetails;

//get method for activities of particular user
-(NSArray*)getActivitiesForParticularUser:(NSString*)user;

//to set password of the user
-(BOOL)setPasswordOfUser:(NSString*)user password:(NSString*)password;

//to delete user details
-(BOOL)deleteUserDetails:(NSString*)user;

//delete activity
-(void)deleteActivity:(NSString*)user activityname:(NSString*)activity;

//set started attribute
-(void)setStartedValue:(NSString*)user activityname:(NSString*)activity boolvalue:(BOOL)started_data;

//check activity started or not started
-(BOOL)checkActivityStartedOrNot:(NSString *)user activityname:(NSString*)activity;


//set start details in activityCompleted
-(void)setActivityCompletedOnStart:(NSDate*)start activityname:(NSString*)activity username:(NSString*)user activityFrequency:(NSString*)activityType;

//stop details in activityCompleted
-(void)setActivityCompletedOnStop:(NSDate*)stop activityname:(NSString*)activity username:(NSString*)user activityFrequency:(NSString*)activityType;

//to set actual start date
-(void)setActualStartValue:(NSString*)user activityname:(NSString*)activity Date:(NSDate*)started_date;

//to set actual stop date
-(void)setActualStopValue:(NSString*)user activityname:(NSString*)activity Date:(NSDate*)stopped_date;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
