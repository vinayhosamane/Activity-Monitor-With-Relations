//
//  AddActivityScreen.m
//  NewActivityMonitor
//
//  Created by Hosamane K N, Vinay (ASPL) on 10/26/15.
//  Copyright (c) 2015 Hosamane K N, Vinay (ASPL). All rights reserved.
//

#import "AddActivityScreen.h"
#import "CoreDataHelper.h"
#import "Activities.h"
#import "Users.h"

@interface AddActivityScreen ()

-(void)cancelTouched;
-(void)doneTouched;
-(void)cancelTouchedDay;
-(void)doneTouchedDay;
-(void)cancelTouchedDayno;
-(void)doneTouchedDayno;



@end

@implementation AddActivityScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dayLabel.hidden=YES;
    self.daynoLabel.hidden=YES;
    self.day.hidden=YES;
    self.dayNo.hidden=YES;
    
    self.frequencyArray=[[NSArray alloc]initWithObjects:@"Daily",@"Weekly",@"Monthly" ,nil];
    
    self.dayArray=[[NSArray alloc]initWithObjects:@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat", nil];
    self.daynoArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31", nil];
        // Do any additional setup after loading the view from its nib.
    
    //frequency picker
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    pickerView.tag=1;
    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    
    // set change the inputView (default is keyboard) to UIPickerView
    self.frequency.inputView = pickerView;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.frequency.inputAccessoryView = toolBar;
    
    
    
    //day picker
    UIPickerView *dayPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    dayPicker.tag=2;
    dayPicker.showsSelectionIndicator = YES;
    dayPicker.dataSource = self;
    dayPicker.delegate = self;
    self.day.inputView = dayPicker;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar2 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar2.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButtonDay = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouchedDay)];
    UIBarButtonItem *cancelButtonDay = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouchedDay)];
    
    // the middle button is to make the Done button align to right
    [toolBar2 setItems:[NSArray arrayWithObjects:cancelButtonDay, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButtonDay, nil]];
    self.day.inputAccessoryView = toolBar2;
    
    
    //day no picker
   
    UIPickerView *daynoPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    daynoPicker.tag=3;
    daynoPicker.showsSelectionIndicator = YES;
    daynoPicker.dataSource = self;
    daynoPicker.delegate = self;
    self.dayNo.inputView = daynoPicker;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar3 = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar3.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButtonDayno = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouchedDayno)];
    UIBarButtonItem *cancelButtonDayno = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouchedDayno)];
    
    // the middle button is to make the Done button align to right
    [toolBar3 setItems:[NSArray arrayWithObjects:cancelButtonDayno, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButtonDayno, nil]];
    self.dayNo.inputAccessoryView = toolBar3;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addButtonAction:(id)sender
{
    NSArray *activitydetails=@[self.activityName.text,self.expectedStart.text,self.expectedStop.text,self.frequency.text,self.day.text,self.dayNo.text];
    
      NSLog(@"added activity details are %@",activitydetails);
    
    [[CoreDataHelper sharedInstance]insertActivityDetails:activitydetails user:self.username];
    
    
}



-(void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    
    if(pickerView.tag==2)
    {
        self.dayData=[self.dayArray objectAtIndex:row];
 
    }
    else if(pickerView.tag==3)
    {
        self.daynoData=[self.daynoArray objectAtIndex:row];
        
    }
   else
   {
       self.frequencyData=[self.frequencyArray objectAtIndex:row];
       
   
   }
    
}

// tell the picker how many rows are available for a given component
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if(pickerView.tag==2)
    {
        return self.dayArray.count;
    }
    if(pickerView.tag==3)
    {
         return self.daynoArray.count;
    }
    return self.frequencyArray.count;
}

// tell the picker how many components it will have
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    if(pickerView.tag==2)
    {
        return self.dayArray[row];
    }
    if(pickerView.tag==3)
    {
        return self.daynoArray[row];
    }
    return self.frequencyArray[row];
}

// tell the picker the width of each row for a given component
//-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    int sectionWidth = 300;
//    
//    return sectionWidth;
//}

-(void)doneTouched
{
    NSLog(@"done pressed");
    
    self.frequency.text=self.frequencyData;
    
    if([self.frequencyData isEqualToString:@"Weekly"])
    {
        self.dayLabel.hidden=NO;
        self.day.hidden=NO;
    }
    if([self.frequencyData isEqualToString:@"Monthly"])
    {
        self.daynoLabel.hidden=NO;
        self.dayNo.hidden=NO;
    }
    
    [self.frequency resignFirstResponder];
    
}
-(void)cancelTouched
{
    
    NSLog(@"cancel pressed");
    [self.frequency resignFirstResponder];

}





-(void)doneTouchedDay
{
    NSLog(@"done pressed in day field");
    
    self.day.text=self.dayData;
    
    
    [self.day resignFirstResponder];
    
}
-(void)cancelTouchedDay
{
    
    NSLog(@"cancel pressed in day field");
    [self.day resignFirstResponder];
    
}

-(void)doneTouchedDayno
{
    NSLog(@"done pressed in day field");
    
    self.dayNo.text=self.daynoData;
    
    
    [self.dayNo resignFirstResponder];
    
}
-(void)cancelTouchedDayno
{
    
    NSLog(@"cancel pressed in day field");
    [self.dayNo resignFirstResponder];
    
}


-(IBAction)selectFrequencyAction:(id)sender
{
    

}
@end
