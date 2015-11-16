//
//  Users.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/30/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activities, ActivitiesCompleted;

@interface Users : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *userToActivities;
@property (nonatomic, retain) NSSet *userToActivitiesCompleted;
@end

@interface Users (CoreDataGeneratedAccessors)

- (void)addUserToActivitiesObject:(Activities *)value;
- (void)removeUserToActivitiesObject:(Activities *)value;
- (void)addUserToActivities:(NSSet *)values;
- (void)removeUserToActivities:(NSSet *)values;

- (void)addUserToActivitiesCompletedObject:(ActivitiesCompleted *)value;
- (void)removeUserToActivitiesCompletedObject:(ActivitiesCompleted *)value;
- (void)addUserToActivitiesCompleted:(NSSet *)values;
- (void)removeUserToActivitiesCompleted:(NSSet *)values;

@end
