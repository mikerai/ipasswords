//
//  CustomSegue.m
//  ParseExample
//
//  Created by Miguel Ángel Rodríguez Álvarez Icaza on 8/21/14.
//  Copyright (c) 2014 Phiveleven. All rights reserved.
//

#import "CustomSegue.h"
#import "QuartzCore/QuartzCore.h"

@implementation CustomSegue

-(void)perform {
    
    __block UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    __block UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    /* @"cameraIris"
     @"cameraIrisHollowOpen"
     @"cameraIrisHollowClose"
     @"cube"
     @"alignedCube"
     @"flip"
     @"alignedFlip"
     @"oglFlip"
     @"rotate"
     @"pageCurl"
     @"pageUnCurl"
     @"rippleEffect"
     @"suckEffect"
     @"spewEffect"
     @"genieEffect"
     @"unGenieEffect"
     @"rippleEffect"
     @"twist"
     @"tubey"
     @"swirl"
     @"charminUltra"
     @"zoomyIn"
     @"zoomyOut"
     */
    
    CATransition* transition = [CATransition animation];
    transition.duration = .61;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"alignedFlip";//kCATransitionPush; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    transition.removedOnCompletion = YES; // force removal of animation when completed.
    
    [sourceViewController.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    
    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
    
}

@end
