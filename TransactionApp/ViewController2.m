//
//  ViewController2.m
//  TransactionApp
//
//  Created by winify on 1/4/16.
//  Copyright © 2016 Mihai. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
 
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];

}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (IBAction)buttonPressed:(id)sender {
	
	if (_comeBack) {
		[self setTransitioningDelegate:self];
		_comeBack = NO;
	}
	
	[self dismissViewControllerAnimated:YES completion:^{ }];
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed
{
	return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
	return 40;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	// get reference to our fromView, toView and the container view that we should perform the transition in
	UIView *container = [transitionContext containerView];
	ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	ViewController2 *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	[[transitionContext containerView] addSubview:toVC.view];	
	
	
	// set up from 2D transforms that we'll use in the animation
	CGAffineTransform offScreenRight = CGAffineTransformMakeTranslation(container.frame.size.width, 0);
	CGAffineTransform offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.size.width, 0);
	
	// start the toView to the right of the screen
	toVC.view.transform = offScreenLeft;
	
	
	// add the both views to our view controller
	[container addSubview:toVC.view];
	[container addSubview:fromVC.view];
	
	
	[UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
		
		fromVC.view.transform = offScreenRight;
		toVC.view.transform = CGAffineTransformIdentity;
		
		
	} completion:^(BOOL finished) {
	
		[transitionContext completeTransition:YES];
		
		//to not dissapear view after it will dismiss
		[[UIApplication sharedApplication].keyWindow addSubview: toVC.view];
	}];
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
