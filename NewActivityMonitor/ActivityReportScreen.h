//
//  ActivityReportScreen.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 11/16/15.
//  Copyright © 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityReportScreen : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)IBOutlet UITableView *reportTable;

@end
