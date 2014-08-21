//
//  EditInfoViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/18/14.
//  Copyright (c) 2014 Nicholas Barrowclough. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EditInfoViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtCardname;
@property (weak, nonatomic) IBOutlet UITextField *txtCardtype;
@property (weak, nonatomic) IBOutlet UITextField *txtCardnumber;
@property (weak, nonatomic) IBOutlet UITextField *txtCardpin;
@property (weak, nonatomic) IBOutlet UITextField *txtCardnotes;
@property (weak, nonatomic) IBOutlet UITextField *txtAccount;

//@property (weak, nonatomic) IBOutlet UITextView *accountText;
//@property (nonatomic) int recordIDToEdit;
@property (strong) NSManagedObject *card;


//- (IBAction)cancel:(id)sender;
- (IBAction)saveInfo:(id)sender;

@end
