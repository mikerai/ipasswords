//
//  WandEDetailViewController.m
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "WandEDetailViewController.h"
#import "WandEViewController.h"
#import "EditWandEViewController.h"

@interface WandEDetailViewController ()

@property (strong) NSMutableArray *wAndEs;

@end

@implementation WandEDetailViewController

@synthesize wAndE, wAndEName, wAndEUsername, wAndEPassword, wAndEDetails, wAndEUrl;

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
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (self.wAndE) {
        self.wAndEName.text = [wAndE valueForKey:@"name"];
        self.wAndEUrl.text = [wAndE valueForKey:@"url"];
        self.wAndEUsername.text = [wAndE valueForKey:@"username"];
        self.wAndEPassword.text = [wAndE valueForKey:@"password"];
        self.wAndEDetails.text = [wAndE valueForKey:@"details"];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (self.wAndE) {
        self.wAndEName.text = [wAndE valueForKey:@"name"];
        self.wAndEUrl.text = [wAndE valueForKey:@"url"];
        self.wAndEUsername.text = [wAndE valueForKey:@"username"];
        self.wAndEPassword.text = [wAndE valueForKey:@"password"];
        self.wAndEDetails.text = [wAndE valueForKey:@"details"];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
    
    if ([[segue identifier] isEqualToString:@"editwAndE"]) {
        NSManagedObject *selectedwAndE = [self wAndE];
        EditWandEViewController *destViewController = segue.destinationViewController;
        destViewController.wAndE = selectedwAndE;
        destViewController.navigationItem.title = @"Edit";
    }
    
}


#pragma mark - UITextFieldDelegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
