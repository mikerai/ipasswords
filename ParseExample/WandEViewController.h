//
//  WandEViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "WandEDetailViewController.h"
#import "LoginViewController.h"

@interface WandEViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblWandE;

-(IBAction)logOut:(id)sender;

@end
