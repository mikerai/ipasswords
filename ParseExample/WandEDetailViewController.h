//
//  WandEDetailViewController.h
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/25/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface WandEDetailViewController : UIViewController

@property (strong) NSManagedObject *wAndE;

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *wAndEName;
@property (weak, nonatomic) IBOutlet UILabel *wAndEUrl;
@property (weak, nonatomic) IBOutlet UILabel *wAndEUsername;
@property (weak, nonatomic) IBOutlet UILabel *wAndEPassword;
@property (weak, nonatomic) IBOutlet UILabel *wAndEDetails;

@end
