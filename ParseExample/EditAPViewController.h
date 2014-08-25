//
//  EditAPViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EditAPViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong) NSManagedObject *accessPoint;

@property (weak,nonatomic) IBOutlet UITextField *accessPointName;
@property (weak,nonatomic) IBOutlet UITextField *accessPointUsername;
@property (weak,nonatomic) IBOutlet UITextField *accessPointPassword;
@property (weak,nonatomic) IBOutlet UITextView *accessPointDetails;

- (IBAction)saveInfo:(id)sender;

- (void)setPlaceholder;

@end
