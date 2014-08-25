//
//  APDetailViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface APDetailViewController : UIViewController

@property (strong) NSManagedObject *accessPoint;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *accessPointName;
@property (weak, nonatomic) IBOutlet UILabel *accessPointUsername;
@property (weak, nonatomic) IBOutlet UILabel *accessPointPassword;
@property (weak, nonatomic) IBOutlet UILabel *accessPointDetails;

@end
