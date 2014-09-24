//
//  InfoViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 9/24/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *disclaimerButton;

- (IBAction)disclaimerOpen:(id)sender;

@end
