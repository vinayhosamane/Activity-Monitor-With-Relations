//
//  AddActivityScreen.h
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddActivityScreen : UIViewController <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(strong,nonatomic)NSString *username;
@property(strong,nonatomic)NSString *frequencyData;
@property(strong,nonatomic)NSString *dayData;
@property(strong,nonatomic)NSString *daynoData;


@property (strong, nonatomic) IBOutlet UITextField *activityName;
@property (strong, nonatomic) IBOutlet UITextField *expectedStop;
@property (strong, nonatomic) IBOutlet UITextField *expectedStart;
@property (strong, nonatomic) IBOutlet UITextField *day;
@property(strong,nonatomic)IBOutlet UILabel *dayLabel;
@property(strong,nonatomic)IBOutlet UILabel *daynoLabel;
@property (strong, nonatomic) IBOutlet UITextField *frequency;
@property (strong, nonatomic) IBOutlet UITextField *dayNo;
@property (strong, nonatomic) IBOutlet UIButton *addButton;

@property(strong,nonatomic)UIPickerView *frequencyPicker;
@property(strong,nonatomic)NSArray *frequencyArray;
@property(strong,nonatomic)NSArray *dayArray;
@property(strong,nonatomic)NSArray *daynoArray;

- (IBAction)addButtonAction:(id)sender;
-(IBAction)selectFrequencyAction:(id)sender;

@end
