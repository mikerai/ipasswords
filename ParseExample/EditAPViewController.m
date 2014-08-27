//
//  EditAPViewController.m
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "EditAPViewController.h"

@interface EditAPViewController ()

@end

@implementation EditAPViewController {

@private BOOL showPlaceHolder;

}

@synthesize accessPoint;

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
    
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    [self setPlaceholder];
    
    if (self.accessPoint) {
        self.accessPointName.text = [accessPoint valueForKey:@"name"];
        self.accessPointUsername.text = [accessPoint valueForKey:@"username"];
        self.accessPointPassword.text = [accessPoint valueForKey:@"password"];
        self.accessPointDetails.text = [accessPoint valueForKey:@"details"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    if (self.accessPoint) {
        self.accessPointName.text = [accessPoint valueForKey:@"name"];
        self.accessPointUsername.text = [accessPoint valueForKey:@"username"];
        self.accessPointPassword.text = [accessPoint valueForKey:@"password"];
        self.accessPointDetails.text = [accessPoint valueForKey:@"details"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlaceholder
{
    _accessPointDetails.text = NSLocalizedString(@"Notes & comments", @"placeholder");
    _accessPointDetails.textColor = [UIColor lightGrayColor];
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
    
    if (self.accessPoint) {
        // Update existing accessPoint
        [self.accessPoint setValue:self.accessPointName.text forKey:@"name"];
        [self.accessPoint setValue:self.accessPointUsername.text forKey:@"username"];
        [self.accessPoint setValue:self.accessPointPassword.text forKey:@"password"];
        [self.accessPoint setValue:self.accessPointDetails.text forKey:@"details"];
        
    } else {
        // Create a new accessPoint
        NSManagedObject *newaccessPoint = [NSEntityDescription insertNewObjectForEntityForName:@"AccessPoint" inManagedObjectContext:context];
        [newaccessPoint setValue:self.accessPointName.text forKey:@"name"];
        [newaccessPoint setValue:self.accessPointUsername.text forKey:@"username"];
        [newaccessPoint setValue:self.accessPointPassword.text forKey:@"password"];
        [newaccessPoint setValue:self.accessPointDetails.text forKey:@"details"];
        
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
        _accessPointDetails.textColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
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
    [_accessPointDetails resignFirstResponder];
    //here if you created a button like I did to resign the keyboard, you should hide it
    if (_accessPointDetails.text.length == 0) {
        [self setPlaceholder];
    }
}

- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 150; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
