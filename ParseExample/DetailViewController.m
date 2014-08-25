//
//  DetailViewController.m
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 18/08/14.
//  Copyright (c) 2014 Nicholas Barrowclough. All rights reserved.
//

#import "DetailViewController.h"
#import "CardsViewController.h"
#import "EditInfoViewController.h"
#import "ToDoListViewController.h"
//#import "DBManager.h"

@interface DetailViewController ()
@property (strong) NSMutableArray *cards;

//@property (nonatomic, strong) DBManager *dbManager;

//-(void)loadInfoToEdit;

@end

@implementation DetailViewController

@synthesize card, txtCardname, txtCardnotes, txtCardnumber, txtCardpin, txtCardtype, txtCardAccount;

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

- (void)viewDidLayoutSubviews {
    self.mainScrollView.contentSize = CGSizeMake(320, 640);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Make self the delegate of the textfields.
    /*self.txtCardname.delegate = self;
    self.txtCardtype.delegate = self;
    self.txtCardnumber.delegate = self;
    self.txtCardpin.delegate = self;
    self.txtCardnotes.delegate = self;
    
    _txtCardname.enabled = NO;
    _txtCardtype.enabled = NO;
    _txtCardnumber.enabled = NO;
    _txtCardpin.enabled = NO;
    _txtCardnotes.enabled = NO;
    
    // Set the navigation bar tint color.
    self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    
    // Initialize the dbManager object.
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"password.sql"];
    
    // Load the record with the specific ID from the database.
    [self loadInfoToEdit];*/
    
    if (self.card) {
        self.txtCardname.text = [card valueForKey:@"name"];
        self.txtCardtype.text = [card valueForKey:@"type"];
        self.txtCardnumber.text = [card valueForKey:@"number"];
        self.txtCardAccount.text = [card valueForKey:@"account"];
        self.txtCardnotes.text = [card valueForKey:@"notes"];
        self.txtCardpin.text = [card valueForKey:@"pin"];
        self.dueDay.text = [card valueForKey:@"dueday"];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (self.card) {
        self.txtCardname.text = [card valueForKey:@"name"];
        self.txtCardtype.text = [card valueForKey:@"type"];
        self.txtCardnumber.text = [card valueForKey:@"number"];
        self.txtCardAccount.text = [card valueForKey:@"account"];
        self.txtCardnotes.text = [card valueForKey:@"notes"];
        self.txtCardpin.text = [card valueForKey:@"pin"];
        self.dueDay.text = [card valueForKey:@"dueday"];
    }
    
    // Make self the delegate of the textfields.
    /*self.txtCardname.delegate = self;
    self.txtCardtype.delegate = self;
    self.txtCardnumber.delegate = self;
    self.txtCardpin.delegate = self;
    self.txtCardnotes.delegate = self;
    
    _txtCardname.enabled = NO;
    _txtCardtype.enabled = NO;
    _txtCardnumber.enabled = NO;
    _txtCardpin.enabled = NO;
    _txtCardnotes.enabled = NO;*/
    
    // Set the navigation bar tint color.
    //self.navigationController.navigationBar.tintColor = self.navigationItem.rightBarButtonItem.tintColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Initialize the dbManager object.
    //self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"password.sql"];
    
    // Check if should load specific record for editing.
    /*if (self.recordIDToEdit !=1) {
        // Load the record with the specific ID from the database.
        [self loadInfoToEdit];
    }*/
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if ([[segue identifier] isEqualToString:@"editDetails"]) {
        NSManagedObject *selectedCard = [self card];
        EditInfoViewController *destViewController = segue.destinationViewController;
        destViewController.card = selectedCard;
        destViewController.navigationItem.title = @"Edit";
    }
    
    if ([[segue identifier] isEqualToString:@"setReminderFromDetails"]) {
        NSManagedObject *selectedCard = [self card];
        ToDoListViewController *destViewController = segue.destinationViewController;
        destViewController.card = selectedCard;
    }
    
}


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - IBAction method implementation
/*
- (IBAction)saveInfo:(id)sender {
    // Prepare the query string.
    // If the recordIDToEdit property has value other than -1, then create an update query. Otherwise create an insert query.
    NSString *query;
    if (self.recordIDToEdit == -1) {
        query = [NSString stringWithFormat:@"insert into cardInfo values(null, '%@', '%@', '%@', '%@', '%@')", self.txtCardname.text, self.txtCardtype.text, self.txtCardnumber.text, self.txtCardpin.text, self.txtCardnotes.text];
    }
    else{
        query = [NSString stringWithFormat:@"update cardInfo set cardname='%@', cardtype='%@', cardnumber='%@', cardpin='%@', notes='%@', where cardInfoID=%d", self.txtCardname.text, self.txtCardtype.text, self.txtCardnumber.text, self.txtCardpin.text, self.txtCardnotes.text, self.recordIDToEdit];
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
    }
}

*/
#pragma mark - Private method implementation
/*
-(void)loadInfoToEdit{
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
}
*/
@end
