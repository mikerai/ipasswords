//
//  EditWandEViewController.m
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "EditWandEViewController.h"

@interface EditWandEViewController ()

@end

@implementation EditWandEViewController {
    
@private BOOL showPlaceHolder;
    
}

@synthesize wAndE;

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
    
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self setPlaceholder];
    
    if (self.wAndE) {
        self.wAndEName.text = [wAndE valueForKey:@"name"];
        self.wAndEUrl.text = [wAndE valueForKey:@"url"];
        self.wAndEUsername.text = [wAndE valueForKey:@"username"];
        self.wAndEPassword.text = [wAndE valueForKey:@"password"];
        self.wAndEDetails.text = [wAndE valueForKey:@"details"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    if (self.wAndE) {
        self.wAndEName.text = [wAndE valueForKey:@"name"];
        self.wAndEUrl.text = [wAndE valueForKey:@"url"];
        self.wAndEUsername.text = [wAndE valueForKey:@"username"];
        self.wAndEPassword.text = [wAndE valueForKey:@"password"];
        self.wAndEDetails.text = [wAndE valueForKey:@"details"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlaceholder
{
    _wAndEDetails.text = NSLocalizedString(@"Notes & comments", @"placeholder");
    _wAndEDetails.textColor = [UIColor lightGrayColor];
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
    
    if (self.wAndE) {
        // Update existing wAndE
        [self.wAndE setValue:self.wAndEName.text forKey:@"name"];
        [self.wAndE setValue:self.wAndEUrl.text forKey:@"url"];
        [self.wAndE setValue:self.wAndEUsername.text forKey:@"username"];
        [self.wAndE setValue:self.wAndEPassword.text forKey:@"password"];
        [self.wAndE setValue:self.wAndEDetails.text forKey:@"details"];
        
    } else {
        // Create a new wAndE
        NSManagedObject *newwAndE = [NSEntityDescription insertNewObjectForEntityForName:@"WebAndEmail" inManagedObjectContext:context];
        [newwAndE setValue:self.wAndEName.text forKey:@"name"];
        [newwAndE setValue:self.wAndEUrl.text forKey:@"url"];
        [newwAndE setValue:self.wAndEUsername.text forKey:@"username"];
        [newwAndE setValue:self.wAndEPassword.text forKey:@"password"];
        [newwAndE setValue:self.wAndEDetails.text forKey:@"details"];
        
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
        _wAndEDetails.textColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
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
    [_wAndEDetails resignFirstResponder];
    //here if you created a button like I did to resign the keyboard, you should hide it
    if (_wAndEDetails.text.length == 0) {
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
