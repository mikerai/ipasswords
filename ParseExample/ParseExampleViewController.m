//
//  ParseExampleViewController.m
//  ParseExample
//
//  Created by Nick Barrowclough on 3/7/13.
//  Copyright (c) 2013 Nicholas Barrowclough. All rights reserved.
//

#import "ParseExampleViewController.h"
//#import "DBManager.h"

@interface ParseExampleViewController ()

@property (strong) NSMutableArray *cards;
//@property (nonatomic, strong) DBManager *dbManager;
//@property (nonatomic, strong) NSArray *arrCardInfo;
//@property (nonatomic) int recordIDToEdit;


//-(void)loadData;

@end

@implementation ParseExampleViewController

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.tblCards.delegate = self;
    self.tblCards.dataSource = self;
    
    // Initialize the dbManager property.
    //self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"password.sql"];
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Card"];
    self.cards = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [_tblCards reloadData];
    
    // Load the data.
    //[self loadData];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.tblCards.delegate = self;
    self.tblCards.dataSource = self;
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Card"];
    self.cards = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [_tblCards reloadData];
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
    
    if ([[segue identifier] isEqualToString:@"viewDetails"]) {
        NSManagedObject *selectedCard = [self.cards objectAtIndex:[[self.tblCards indexPathForSelectedRow] row]];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.card = selectedCard;
    }
    
}

#pragma mark - IBAction method implementation

/*- (IBAction)addNewRecord:(id)sender {
    // Before performing the segue, set the -1 value to the recordIDToEdit. That way we'll indicate that we want to add a new record and not to edit an existing one.
    //self.recordIDToEdit = -1;
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"editInfo" sender:self];
}*/

-(IBAction)logOut:(id)sender {
    
    [PFUser logOut];
    
    NSLog(@"User logged out");
    
    [self performSegueWithIdentifier:@"loginScreen" sender:self];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Private method implementation
/*
-(void)loadData{
    // Form the query.
    NSString *query = @"select * from cardInfo";
    
    // Get the results.
    if (self.arrCardInfo != nil) {
        self.arrCardInfo = nil;
    }
    self.arrCardInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // Reload the table view.
    [self.tblCards reloadData];
}
*/

#pragma mark - UITableView method implementation

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.arrCardInfo.count;
    return self.cards.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    //NSInteger indexOfCardname = [self.dbManager.arrColumnNames indexOfObject:@"cardname"];
    //NSInteger indexOfCardType = [self.dbManager.arrColumnNames indexOfObject:@"cardtype"];
    //NSInteger indexOfCardNumber = [self.dbManager.arrColumnNames indexOfObject:@"cardnumber"];
    //NSInteger indexOfCardPin = [self.dbManager.arrColumnNames indexOfObject:@"cardpin"];
    //NSInteger indexOfCardNotes = [self.dbManager.arrColumnNames indexOfObject:@"notes"];
    
    // Set the loaded data to the appropriate cell labels.
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrCardInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfCardname]];
    
    NSManagedObject *card = [self.cards objectAtIndex:indexPath.row];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@", [card valueForKey:@"name"]]];
    cell.textLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:20.0f];
    cell.textLabel.textColor = [UIColor colorWithRed:0.275 green:0.314 blue:0.341 alpha:1]; /*#465057*/
    
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrCardInfo objectAtIndex:indexPath.row] objectAtIndex:indexOfCardType]];
    
    [cell.detailTextLabel setText:[card valueForKey:@"type"]];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0f];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71.0;
}


/*-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    // Get the record ID of the selected name and set it to the recordIDToEdit property.
    self.recordIDToEdit = [[[self.arrCardInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    [self performSegueWithIdentifier:@"editInfo" sender:self];
    //[self performSegueWithIdentifier:@"viewDetails" sender:self];
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.recordIDToEdit = [[[self.arrCardInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // Perform the segue.
    //[self performSegueWithIdentifier:@"viewDetails" sender:self];
    //[self performSegueWithIdentifier:@"editInfo" sender:self];
    
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.cards objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.cards removeObjectAtIndex:indexPath.row];
        [self.tblCards deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

/*-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the selected record.
        // Find the record ID.
        //int recordIDToDelete = [[[self.arrCardInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // Prepare the query.
        //NSString *query = [NSString stringWithFormat:@"delete from cardInfo where cardInfoID=%d", recordIDToDelete];
        
        // Execute the query.
        //[self.dbManager executeQuery:query];
        
        // Reload the table view.
        //[self loadData];
    }
}*/

#pragma mark - EditInfoViewControllerDelegate method implementation

/*
-(void)editingInfoWasFinished{
    // Reload the data.
    [self loadData];
}
*/

@end
