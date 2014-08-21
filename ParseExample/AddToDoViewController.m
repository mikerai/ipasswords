//
//  AddToDoViewController.m
//  LocalNotificationDemo
//
//  Created by Simon on 9/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AddToDoViewController.h"

@interface AddToDoViewController ()

@end

@implementation AddToDoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.itemText.delegate = self;
    
    _datePicker.date =
    [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 2 ];
    _datePicker.minimumDate =
    [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 0 ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    [self.itemText resignFirstResponder];
    
    if ( [ _datePicker.date timeIntervalSinceNow ] < 0 )
        _datePicker.date = [NSDate date];
    
    // Get the current date
    NSDate *pickerDate = [self.datePicker date];
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    calender.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    
    /*NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:pickerDate options:0];*/
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = pickerDate;
    localNotification.alertBody = self.itemText.text;
    localNotification.alertAction = @"Show me the details";
    localNotification.soundName = @"apple_alarm.mp3";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    localNotification.repeatInterval = NSMonthCalendarUnit;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    /*
    
    NSDateComponents *components = pickerDate;
    //components.day    = pickerDate;
    components.hour   = 12;
    components.minute = 30;
    
    NSDate *fireDate = [calender dateFromComponents:components];*/
    
    // Dismiss the view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.itemText resignFirstResponder];
    return NO;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

@end
