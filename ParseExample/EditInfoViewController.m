//
//  EditInfoViewController.m
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/18/14.
//  Copyright (c) 2014 Nicholas Barrowclough. All rights reserved.
//

#import "EditInfoViewController.h"
#import "ToDoListViewController.h"
//#import "DBManager.h"

@interface EditInfoViewController ()
/*
@property (nonatomic, strong) DBManager *dbManager;

-(void)loadInfoToEdit;

*/
 
@end

@implementation EditInfoViewController {

@private BOOL showPlaceHolder;
    
}

@synthesize card;

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
    
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    /*_txtNotes.delegate = self;
    _txtNotes.text = @"placeholder text here...";
    _txtNotes.textColor = [UIColor lightGrayColor]; //optional*/
    
    //[self preferredStatusBarStyle];
    
    // Make self the delegate of the textfields.
    /*self.txtCardname.delegate = self;
    self.txtCardtype.delegate = self;
    self.txtCardnumber.delegate = self;
    self.txtCardpin.delegate = self;
    self.txtCardnotes.delegate = self;
    self.txtAccount.delegate = self;
    
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"password.sql"];
    
    // Check if should load specific record for editing.
    if (self.recordIDToEdit != -1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }*/
    
    if (self.card) {
        [self.txtCardname setText:[self.card valueForKey:@"name"]];
        [self.txtCardtype setText:[self.card valueForKey:@"type"]];
        [self.txtCardnumber setText:[self.card valueForKey:@"number"]];
        [self.txtCardpin setText:[self.card valueForKey:@"pin"]];
        [self.txtNotes setText:[self.card valueForKey:@"notes"]];
        [self.dueDay setText:[self.card valueForKey:@"dueday"]];
        [self.txtAccount setText:[self.card valueForKey:@"account"]];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    if (self.card) {
        [self.txtCardname setText:[self.card valueForKey:@"name"]];
        [self.txtCardtype setText:[self.card valueForKey:@"type"]];
        [self.txtCardnumber setText:[self.card valueForKey:@"number"]];
        [self.txtCardpin setText:[self.card valueForKey:@"pin"]];
        [self.txtNotes setText:[self.card valueForKey:@"notes"]];
        [self.dueDay setText:[self.card valueForKey:@"dueday"]];
        [self.txtAccount setText:[self.card valueForKey:@"account"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPlaceholder
{
    _txtNotes.text = NSLocalizedString(@"Notes & comments", @"placeholder");
    _txtNotes.textColor = [UIColor lightGrayColor];
    self->showPlaceHolder = YES; //we save the state so it won't disappear in case you want to re-edit it
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


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
    
    if (self.card) {
        // Update existing device
        [self.card setValue:self.txtCardname.text forKey:@"name"];
        [self.card setValue:self.txtCardtype.text forKey:@"type"];
        [self.card setValue:self.txtAccount.text forKey:@"account"];
        [self.card setValue:self.txtCardnumber.text forKey:@"number"];
        [self.card setValue:self.txtCardpin.text forKey:@"pin"];
        [self.card setValue:self.dueDay.text forKey:@"dueday"];
        [self.card setValue:self.txtNotes.text forKey:@"notes"];
        
    } else {
        // Create a new device
        NSManagedObject *newCard = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:context];
        [newCard setValue:self.txtCardname.text forKey:@"name"];
        [newCard setValue:self.txtCardtype.text forKey:@"type"];
        [newCard setValue:self.txtAccount.text forKey:@"account"];
        [newCard setValue:self.txtCardnumber.text forKey:@"number"];
        [newCard setValue:self.txtCardpin.text forKey:@"pin"];
        [newCard setValue:self.dueDay.text forKey:@"dueday"];
        [newCard setValue:self.txtNotes.text forKey:@"notes"];
        
        NSLog(@"Values saved!");
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    // Prepare the query string.
    // If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
/*    NSString *query;
    if (self.recordIDToEdit == -1) {
        query = [NSString stringWithFormat:@"insert into cardInfo values(null, '%@', '%@', '%@', '%@', '%@', '%@')", self.txtCardname.text, self.txtCardtype.text, self.txtCardnumber.text, self.txtCardpin.text, self.txtCardnotes.text, self.txtAccount.text];
    }
    else{
        query = [NSString stringWithFormat:@"update cardInfo set cardname='%@', cardtype='%@', cardnumber='%@', cardpin='%@', notes='%@', account='%@' where cardInfoID=%d", self.txtCardname.text, self.txtCardtype.text, self.txtCardnumber.text, self.txtCardpin.text, self.txtCardnotes.text, self.txtAccount.text, self.recordIDToEdit];
    }
    
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Inform the delegate that the editing was finished.
        [self.delegate editingInfoWasFinished];
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }*/
}

#pragma mark - Private method implementation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    /*if ([[segue identifier] isEqualToString:@"editInfo"]) {
     
     
     }
     
     if ([[segue identifier] isEqualToString:@"viewDetails"]) {
     DetailViewController *detailViewController = [segue destinationViewController];
     detailViewController.delegate = self;
     detailViewController.recordIDToEdit = self.recordIDToEdit;
     }
     
     EditInfoViewController *editInfoViewController = [segue destinationViewController];
     editInfoViewController.delegate = self;
     editInfoViewController.recordIDToEdit = self.recordIDToEdit; */
    
    if ([[segue identifier] isEqualToString:@"setReminderFromEdit"]) {
        NSManagedObject *selectedCard = [self card];
        ToDoListViewController *destViewController = segue.destinationViewController;
        destViewController.card = selectedCard;
    }
    
}

/*-(void)loadInfoToEdit{
    // Create the query.
    NSString *query = [NSString stringWithFormat:@"select * from cardInfo where cardInfoID=%d", self.recordIDToEdit];
    
    // Load the relevant data.
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Set the loaded data to the textfields.
    self.txtCardname.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"cardname"]];
    self.txtCardtype.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"cardtype"]];
    self.txtCardnumber.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"cardnumber"]];
    self.txtCardpin.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"cardpin"]];
    self.txtCardnotes.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"notes"]];
    self.txtAccount.text = [[results objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"account"]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 18; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}*/

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self->showPlaceHolder == YES)
    {
        _txtNotes.textColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
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
    [_txtNotes resignFirstResponder];
    //here if you created a button like I did to resign the keyboard, you should hide it
    if (_txtNotes.text.length == 0) {
        [self setPlaceholder];
    }
}

- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 160; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


@end
