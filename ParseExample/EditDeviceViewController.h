//
//  EditDeviceViewController.h
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 24/08/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface EditDeviceViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (strong) NSManagedObject *device;

@property (weak,nonatomic) IBOutlet UITextField *deviceName;
@property (weak,nonatomic) IBOutlet UITextField *deviceUsername;
@property (weak,nonatomic) IBOutlet UITextField *devicePassword;
@property (weak,nonatomic) IBOutlet UITextView *deviceDetails;

- (IBAction)saveInfo:(id)sender;

- (void)setPlaceholder;

@end
