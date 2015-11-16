//
//  GlobalVariablesClass.h
//  ActivityAnalysis
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/29/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariablesClass : NSObject

+ (GlobalVariablesClass*)sharedInstance;


@property(strong,nonatomic)NSString *CurrentUser;
@property(assign,nonatomic)NSInteger CurrentUserId;

@end
