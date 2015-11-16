//
//  CoreDataHelper.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>
#import "Users.h"
#import "Activities.h"
#import "ActivitiesCompleted.h"

@interface CoreDataHelper ()

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end


@implementation CoreDataHelper


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.allstate.com.NewActivityMonitor" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewActivityMonitor" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewActivityMonitor.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

+ (instancetype)sharedInstance
{
    static CoreDataHelper *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[CoreDataHelper alloc] init];
        [sharedHelper managedObjectContext];
    });
    return sharedHelper;
}

-(void)insertUserDetails:(NSArray *)data
{
    Users *user = (Users *)[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    user.name=data[0];
    user.age=data[1];
    user.username=data[2];
    user.password=data[3];
    
    NSLog(@"user inserted is %@",data);
    
        [_managedObjectContext save:nil];
}

-(NSArray *)getParticularUserDetails:(NSString *)user
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    return [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
}


-(void)insertActivityDetails:(NSArray *)data user:(NSString *)username
{
    NSArray *array=[[CoreDataHelper sharedInstance] getParticularUserDetails:username];
    
    for(Users *particularuser in array)
    {
//        Activities *activity=(Activities*) [NSEntityDescription entityForName:@"Activities" inManagedObjectContext:_managedObjectContext];
        
        Activities *activity=(Activities *)[NSEntityDescription insertNewObjectForEntityForName:@"Activities" inManagedObjectContext:_managedObjectContext];
        
        activity.activityName=data[0];
        activity.expectedStart=data[1];
        activity.expectedStop=data[2];
        activity.frequency=data[3];
        activity.day=data[4];
        activity.dayno=data[5];
        
        [particularuser addUserToActivitiesObject:activity];
        
    }
    [_managedObjectContext save:nil];
}



//- (void)insertUserDetails:(NSDictionary *)data
//{
//    Users *user = (Users *)[NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:_managedObjectContext];
//    
//    user.name = data[@"User"][@"Name"];
//    NSLog(@"Name = %@",user.name);
//    
//    NSArray *activitiesArray = data[@"User"][@"Activities"];
//    
//    if (activitiesArray >0)
//    {
//        for (NSString *activityName in activitiesArray)
//        {
//            Activity *activity = (Activity *)[NSEntityDescription insertNewObjectForEntityForName:@"Activity" inManagedObjectContext:_managedObjectContext];
//            
//            
//            activity.activityname = activityName;
//            NSLog(@"Activity = %@", activity.activityname);
//            
//            //Gives internal connection
//            [user addUserToActivitiesObject:activity];
//        }
//    }
//    
//    [_managedObjectContext save:nil];
//}
//

- (NSArray *)getUserDetails
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    return [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

- (NSArray *)getActivitiesDetails
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Activities" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    return [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
}

-(NSArray*)getActivitiesForParticularUser:(NSString*)user
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    
    [fetchRequest setPredicate:predicate];
    
    
   return [_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
}

-(BOOL)deleteUserDetails:(NSString*)user
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        [_managedObjectContext deleteObject:userObject];
        
        NSArray *temp=[userObject.userToActivities allObjects];
        
        [userObject removeUserToActivities:userObject.userToActivities];
        
        for(Activities *activity in temp)
        {
            [_managedObjectContext deleteObject:activity];
        }
       
    }
    
    [_managedObjectContext save:nil];
    return YES;
    
}

-(BOOL)setPasswordOfUser:(NSString*)user password:(NSString *)password
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        userObject.password=password;
        
    }
    
    [_managedObjectContext save:nil];
    return YES;

 
}

-(void)deleteActivity:(NSString*)user activityname:(NSString*)activity
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        NSArray *temp=[userObject.userToActivities allObjects];
        
        for (Activities *activityObject in temp)
        {
            if([activityObject.activityName isEqualToString:activity])
            {
                [_managedObjectContext deleteObject:activityObject];
            }
            
        }
        
    }
    
    [_managedObjectContext save:nil];

    
}

-(void)setStartedValue:(NSString*)user activityname:(NSString*)activity boolvalue:(BOOL)started_data
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        NSArray *temporary=[userObject.userToActivities allObjects];
        
        for (Activities *activityObject in temporary)
        {
            if([activityObject.activityName isEqualToString:activity])
            {
                activityObject.started=[NSNumber numberWithBool:started_data];
            }
            
        }
        
    }
    
    [_managedObjectContext save:nil];

}

-(BOOL)checkActivityStartedOrNot:(NSString *)user activityname:(NSString*)activity
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        NSArray *temporary=[userObject.userToActivities allObjects];
        
        for (Activities *activityObject in temporary)
        {
            if([activityObject.activityName isEqualToString:activity])
            {
                //BOOL check=activityObject.started;
                int temp=activityObject.started.intValue;
                
                if(temp==1)
                {
                    return YES;
                }
                else
                {
                    return NO;
                }
            }
            
        }
        
    }
    
    return NO;

}

-(void)setActivityCompletedOnStart:(NSDate*)start activityname:(NSString*)activity username:(NSString*)user activityFrequency:(NSString *)activityType
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
       
        if([userObject.username isEqualToString:user])
        {
             ActivitiesCompleted *activityObject=(ActivitiesCompleted *)[NSEntityDescription insertNewObjectForEntityForName:@"ActivitiesCompleted" inManagedObjectContext:_managedObjectContext];
            
            activityObject.activityname=activity;
            activityObject.activityType=activityType;
            activityObject.actualStartTime=start;
            
            [userObject addUserToActivitiesCompletedObject:activityObject];
            
        }
       
    }
    
    [_managedObjectContext save:nil];
}

-(void)setActivityCompletedOnStop:(NSDate*)stop activityname:(NSString*)activity username:(NSString*)user activityFrequency:(NSString*)activityType
{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        
        if([userObject.username isEqualToString:user])
        {
            ActivitiesCompleted *activityObject=(ActivitiesCompleted *)[NSEntityDescription insertNewObjectForEntityForName:@"ActivitiesCompleted" inManagedObjectContext:_managedObjectContext];
            
            activityObject.activityname=activity;
            activityObject.activityType=activityType;
            activityObject.actualStopTime=stop;
            
            [userObject addUserToActivitiesCompletedObject:activityObject];
            
        }
        
    }
    
    [_managedObjectContext save:nil];
}

//set actual start value

-(void)setActualStartValue:(NSString*)user activityname:(NSString*)activity Date:(NSDate*)started_date
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        NSArray *temporary=[userObject.userToActivities allObjects];
        
        for (Activities *activityObject in temporary)
        {
            if([activityObject.activityName isEqualToString:activity])
            {
                activityObject.actualStart=started_date;
            }
            
        }
        
    }
    
    [_managedObjectContext save:nil];
    
}

//set actual stop value

-(void)setActualStopValue:(NSString*)user activityname:(NSString*)activity Date:(NSDate*)stopped_date
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:_managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"username=%@",user];
    [fetchRequest setPredicate:predicate];
    
    NSArray *array=[_managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for(Users *userObject in array)
    {
        NSArray *temporary=[userObject.userToActivities allObjects];
        
        for (Activities *activityObject in temporary)
        {
            if([activityObject.activityName isEqualToString:activity])
            {
                activityObject.actualStop=stopped_date;
            }
            
        }
        
    }
    
    [_managedObjectContext save:nil];
    
}


@end
