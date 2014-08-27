//
//  APDetailViewController.m
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "APDetailViewController.h"
#import "APViewController.h"
#import "EditAPViewController.h"

@interface APDetailViewController ()

@property (strong) NSMutableArray *accessPoints;

@end

@implementation APDetailViewController

@synthesize accessPoint, accessPointName, accessPointUsername, accessPointPassword, accessPointDetails;

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
    self.mainScrollView.contentSize = CGSizeMake(320, 700);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
    if (self.accessPoint) {
        self.accessPointName.text = [accessPoint valueForKey:@"name"];
        self.accessPointUsername.text = [accessPoint valueForKey:@"username"];
        self.accessPointPassword.text = [accessPoint valueForKey:@"password"];
        self.accessPointDetails.text = [accessPoint valueForKey:@"details"];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (self.accessPoint) {
        self.accessPointName.text = [accessPoint valueForKey:@"name"];
        self.accessPointUsername.text = [accessPoint valueForKey:@"username"];
        self.accessPointPassword.text = [accessPoint valueForKey:@"password"];
        self.accessPointDetails.text = [accessPoint valueForKey:@"details"];
    }
    
     self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1];
    
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
    
    if ([[segue identifier] isEqualToString:@"editAccessPoint"]) {
        NSManagedObject *selectedaccessPoint = [self accessPoint];
        EditAPViewController *destViewController = segue.destinationViewController;
        destViewController.accessPoint = selectedaccessPoint;
        destViewController.navigationItem.title = @"Edit";
    }
    
}


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
