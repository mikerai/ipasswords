//
//  ParseExampleViewController.h
//  ParseExample
//
//  Created by Nick Barrowclough on 3/7/13.
//  Copyright (c) 2013 Nicholas Barrowclough. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>
//#import "ParseExampleCell.h"
#import "EditInfoViewController.h"
#import "DetailViewController.h"
#import "LoginViewController.h"

@interface ParseExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
}

@property (weak, nonatomic) IBOutlet UITableView *tblCards;


-(IBAction)logOut:(id)sender;

@end
