//
//  ViewController.h
//  TransactionApp
//
//  Created by winify on 1/4/16.
//  Copyright © 2016 Mihai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImoDynamicTableView.h>

@interface ViewController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
{
	 NSInteger transitionNr;
	IBOutlet ImoDynamicTableView *tableView;
	NSMutableArray *section;
}


@property (strong, nonatomic) IBOutlet UIView *transportedView;

@end

