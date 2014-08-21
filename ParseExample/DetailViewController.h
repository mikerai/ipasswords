//
//  DetailViewController.h
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 18/08/14.
//  Copyright (c) 2014 Nicholas Barrowclough. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface DetailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) int recordIDToEdit;

@property (weak, nonatomic) IBOutlet UILabel *txtCardname;
@property (weak, nonatomic) IBOutlet UILabel *txtCardtype;
@property (weak, nonatomic) IBOutlet UILabel *txtCardnumber;
@property (weak, nonatomic) IBOutlet UILabel *txtCardpin;
@property (weak, nonatomic) IBOutlet UILabel *txtCardnotes;
@property (weak, nonatomic) IBOutlet UILabel *txtCardAccount;

@property (strong) NSManagedObject *card;

@end
