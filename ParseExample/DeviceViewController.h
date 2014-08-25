//
//  DeviceViewController.h
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 24/08/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
#import "DeviceDetailViewController.h"
#import "LoginViewController.h"

@interface DeviceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblDevices;


-(IBAction)logOut:(id)sender;

@end
