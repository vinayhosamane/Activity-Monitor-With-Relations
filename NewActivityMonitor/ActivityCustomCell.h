//
//  ActivityCustomCell.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/29/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCustomCell : UITableViewCell

@property(strong,nonatomic)IBOutlet UILabel *activityLabel;
@property(strong,nonatomic)IBOutlet UILabel *startLabel;
@property(strong,nonatomic)IBOutlet UILabel *stopLabel;
@property(strong,nonatomic)IBOutlet UILabel *activityType;
@property(strong,nonatomic)IBOutlet UISwitch *startAndStopSwitch;

@property(strong,nonatomic)IBOutlet UIButton *updateButton;

@property(strong,nonatomic)IBOutlet UIButton *disableButton;


@property(strong,nonatomic)IBOutlet UILabel *dash;

-(IBAction)updateButtonAction:(id)sender;

-(IBAction)disableButtonAction:(id)sender;

-(IBAction)PerFormActivity:(id)sender;

@end
