//
//  GlobalVariablesClass.m
//  ActivityAnalysis
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/29/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "GlobalVariablesClass.h"

@implementation GlobalVariablesClass

static GlobalVariablesClass* _sharedMySingleton = nil;


+ (GlobalVariablesClass*)sharedInstance
{
    @synchronized([GlobalVariablesClass class])
    {
        if (!_sharedMySingleton)
            _sharedMySingleton = [[self alloc] init];
    }
    
    return _sharedMySingleton;
}

@end
