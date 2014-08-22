//
//  ToDoListViewController.h
//  LocalNotificationDemo
//
//  Created by Simon on 9/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ToDoListViewController : UITableViewController

@property (strong) NSManagedObject *card;

-(IBAction)dismissButton:(id)sender;

@end
