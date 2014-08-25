//
//  DeviceDetailViewController.h
//  ParseExample
//
//  Created by Miguel Angel Rodriguez Alvarez Icaza on 24/08/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DeviceDetailViewController : UIViewController

@property (strong) NSManagedObject *device;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *deviceName;
@property (weak, nonatomic) IBOutlet UILabel *deviceUsername;
@property (weak, nonatomic) IBOutlet UILabel *devicePassword;
@property (weak, nonatomic) IBOutlet UILabel *deviceDetails;

@end
