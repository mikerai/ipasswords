//
//  EditWandEViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EditWandEViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong) NSManagedObject *wAndE;

@property (weak,nonatomic) IBOutlet UITextField *wAndEName;
@property (weak,nonatomic) IBOutlet UITextField *wAndEUrl;
@property (weak,nonatomic) IBOutlet UITextField *wAndEUsername;
@property (weak,nonatomic) IBOutlet UITextField *wAndEPassword;
@property (weak,nonatomic) IBOutlet UITextView *wAndEDetails;

- (IBAction)saveInfo:(id)sender;

- (void)setPlaceholder;

@end
