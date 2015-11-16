//
//  ActivitiesCompleted.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/30/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Users;

@interface ActivitiesCompleted : NSManagedObject

@property (nonatomic, retain) NSString * activityname;
@property (nonatomic, retain) NSDate * actualStartTime;
@property (nonatomic, retain) NSDate * actualStopTime;
@property (nonatomic, retain) NSNumber * timeSpent;
@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) Users *activitiesCompletedByUser;

@end
