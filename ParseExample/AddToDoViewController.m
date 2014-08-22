//
//  AddToDoViewController.m
//  LocalNotificationDemo
//
//  Created by Simon on 9/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AddToDoViewController.h"
#import "DetailViewController.h"

@interface AddToDoViewController ()

@property (strong) NSMutableArray *cards;

@end

@implementation AddToDoViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

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
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Card"];
    self.cards = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
     NSLog(@"Cards from Add To %@", [_card valueForKey:@"name"]);
    
    /*_datePicker.date =
    [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 2 ];
    _datePicker.minimumDate =
    [[ NSDate alloc ] initWithTimeIntervalSinceNow: (NSTimeInterval) 0 ];*/
    
    self.saveButton.layer.cornerRadius = 4.0f;
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
    
    /*if ( [ _datePicker.date timeIntervalSinceNow ] < 0 )
        _datePicker.date = [NSDate date];*/
    
    // Get the current date
    //NSDate *pickerDate = [self.datePicker date];
    
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *date = [self.datePicker date];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponents year];
    NSInteger month = [dateComponents month];
    //NSInteger day = [dateComponents day];
    NSInteger hour = [dateComponents hour];
    NSInteger minute = [dateComponents minute];
    //NSInteger second = [dateComponents second];
    
    [_datePicker setCalendar:[NSCalendar currentCalendar]];
    [_datePicker setTimeZone:[calendar timeZone]];
    
    //NSDate *now = [NSDate date];
    
    NSInteger myInt = [[_card valueForKey:@"dueday"] integerValue];
    
    NSLog(@"The day the Card should be paid is %@", [_card valueForKey:@"dueday"]);
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay: myInt];
    [components setMonth: month + 1];
    [components setYear: year];
    [components setHour: hour];
    [components setMinute: minute];
    //[components setSecond: 45];
    [calendar setTimeZone: [NSTimeZone localTimeZone]];
    
    //NSDate *dateToFire = [calender dateByAddingComponents:components toDate:date options:0];
    NSDate *testDate = [calender dateFromComponents:components];
    
    // Schedule the notification
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    
    localNotification.fireDate = testDate;
    //localNotification.fireDate = newDate;
    localNotification.alertBody = self.itemText.text;
    localNotification.alertAction = @"Show me the details";
    localNotification.soundName = @"apple_alarm.mp3";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    NSLog(@"Fire Date would be %@", localNotification.fireDate);
    
    localNotification.repeatInterval = NSMonthCalendarUnit;
    
    //[localNotification setTimeZone: [NSTimeZone defaultTimeZone]];
    [localNotification setRepeatInterval: NSMonthCalendarUnit];
    NSLog(@"Repeat would be %lu", localNotification.repeatInterval);
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Dismiss the view controller
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"Mmmm-dd-YYYY 'at' HH:mm"];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //NSDate *todaysDate;
    //todaysDate = [NSDate date];
    //NSLog(@"Todays date is %@",formatter);
    
    if (myInt!=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ %@ Card", [_card valueForKey:@"name"], [_card valueForKey:@"type"]] message:[NSString stringWithFormat:@"Your reminder will be displayed on %@", [formatter stringFromDate:testDate]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.itemText resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
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
