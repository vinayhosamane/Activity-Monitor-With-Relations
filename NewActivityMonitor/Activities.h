//
//  Activities.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/30/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Users;

@interface Activities : NSManagedObject

@property (nonatomic, retain) NSString * activityName;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSString * dayno;
@property (nonatomic, retain) NSString * expectedStart;
@property (nonatomic, retain) NSString * expectedStop;
@property (nonatomic, retain) NSDate * actualStart;
@property (nonatomic, retain) NSDate * actualStop;
@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) NSNumber * started;
@property (nonatomic, retain) Users *activityToUser;

@end
