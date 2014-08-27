//
//  DeviceDetailViewController.m
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 24/08/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "DeviceViewController.h"
#import "EditDeviceViewController.h"

@interface DeviceDetailViewController ()

@property (strong) NSMutableArray *devices;

@end

@implementation DeviceDetailViewController

@synthesize device, deviceName, deviceUsername, devicePassword, deviceDetails;

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
    
    if (self.device) {
        self.deviceName.text = [device valueForKey:@"name"];
        self.deviceUsername.text = [device valueForKey:@"username"];
        self.devicePassword.text = [device valueForKey:@"password"];
        self.deviceDetails.text = [device valueForKey:@"details"];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (self.device) {
        self.deviceName.text = [device valueForKey:@"name"];
        self.deviceUsername.text = [device valueForKey:@"username"];
        self.devicePassword.text = [device valueForKey:@"password"];
        self.deviceDetails.text = [device valueForKey:@"details"];
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
    
    if ([[segue identifier] isEqualToString:@"editDevice"]) {
        NSManagedObject *selectedDevice = [self device];
        EditDeviceViewController *destViewController = segue.destinationViewController;
        destViewController.device = selectedDevice;
        destViewController.navigationItem.title = @"Edit";
    }
    
}


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
