//
//  ViewController2.h
//  TransactionApp
//
//  Created by winify on 1/4/16.
//  Copyright © 2016 Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property BOOL comeBack;
- (IBAction)buttonPressed:(id)sender;

@end
