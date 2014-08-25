//
//  EditDeviceViewController.m
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 24/08/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "EditDeviceViewController.h"

@interface EditDeviceViewController ()

@end

@implementation EditDeviceViewController {
    
@private BOOL showPlaceHolder;
    
}

@synthesize device;

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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self setPlaceholder];
    
    if (self.device) {
        self.deviceName.text = [device valueForKey:@"name"];
        self.deviceUsername.text = [device valueForKey:@"username"];
        self.devicePassword.text = [device valueForKey:@"password"];
        self.deviceDetails.text = [device valueForKey:@"details"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (self.device) {
        self.deviceName.text = [device valueForKey:@"name"];
        self.deviceUsername.text = [device valueForKey:@"username"];
        self.devicePassword.text = [device valueForKey:@"password"];
        self.deviceDetails.text = [device valueForKey:@"details"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlaceholder
{
    _deviceDetails.text = NSLocalizedString(@"Notes & comments", @"placeholder");
    _deviceDetails.textColor = [UIColor lightGrayColor];
    self->showPlaceHolder = YES; //we save the state so it won't disappear in case you want to re-edit it
}

#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}

#pragma mark - IBAction method implementation

/*- (IBAction)cancel:(id)sender {
 
 [self.navigationController popViewControllerAnimated:YES];
 }*/

- (IBAction)saveInfo:(id)sender {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.device) {
        // Update existing device
        [self.device setValue:self.deviceName.text forKey:@"name"];
        [self.device setValue:self.deviceUsername.text forKey:@"username"];
        [self.device setValue:self.devicePassword.text forKey:@"password"];
        [self.device setValue:self.deviceDetails.text forKey:@"details"];
        
    } else {
        // Create a new device
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newDevice setValue:self.deviceName.text forKey:@"name"];
        [newDevice setValue:self.deviceUsername.text forKey:@"username"];
        [newDevice setValue:self.devicePassword.text forKey:@"password"];
        [newDevice setValue:self.deviceDetails.text forKey:@"details"];
        
        NSLog(@"Values saved!");
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Private method implementation

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self->showPlaceHolder == YES)
    {
        _deviceDetails.textColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
        textView.text = @"";
        self->showPlaceHolder = NO;
    }    [textView becomeFirstResponder];
    
    [self animateTextView: textView up: YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [textView resignFirstResponder];
    
    [self animateTextView: textView up: NO];
}

- (void)resignKeyboard
{
    [_deviceDetails resignFirstResponder];
    //here if you created a button like I did to resign the keyboard, you should hide it
    if (_deviceDetails.text.length == 0) {
        [self setPlaceholder];
    }
}

- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 180; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
