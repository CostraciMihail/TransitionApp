//
//  ViewController.m
//  TransactionApp
//
//  Created by winify on 1/4/16.
//  Copyright © 2016 Mihai. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import <ImoDynamicDefaultCell.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{	
	[super viewDidLoad];
	
	
	section = [NSMutableArray new];
	tableView.dynamicTableViewDelegate = self;
	tableView.shouldAutoAdjustScroll = YES;
	
	{
		IDDCellSource *source = [[IDDCellSource alloc] init];
		source.title = @"Slide Transaction";
		source.selector = @selector(slideAction);
		[section addObject:source];
	}
	
	{
		IDDCellSource *source = [[IDDCellSource alloc] init];
		source.title = @"Scale Transaction";
		source.selector = @selector(rotateAction);
		[section addObject:source];
	}
	
	{
		IDDCellSource *source = [[IDDCellSource alloc] init];
		source.title = @"Rotate Transaction";
		source.selector = @selector(scaleAction);
		[section addObject:source];
	}
	
	{
		IDDCellSource *source = [[IDDCellSource alloc] init];
		source.title = @" Transaction";
		[section addObject:source];
	}
	
	[tableView.source addObject:section];
	[tableView reloadData];

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	NSLog(@"anchorPoint.x: %.1f", self.view.layer.anchorPoint.x);
	NSLog(@"anchorPoint.y: %.1f", self.view.layer.anchorPoint.y);
	
	NSLog(@"position.x: %.1f", self.view.layer.position.x);
	NSLog(@"position.y: %.1f", self.view.layer.position.y);
	
	//self.view.layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
	//self.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source;
{
	return  self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
	return 20;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{

	// get reference to our fromView, toView and the container view that we should perform the transition in
	UIView *container = [transitionContext containerView];
	ViewController2 *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	[[transitionContext containerView] addSubview:toVC.view];
	
	
	switch (transitionNr)
	{
		case 1: [self slideTransitionFrom:fromVC to:toVC transitionContext:transitionContext container:container];
				break;
			
		case 2:	[self scalingTransitionFrom:fromVC to:toVC transitionContext:transitionContext container:container];
				break;
			
		case 3:[self rotateTransitionFrom:fromVC to:toVC transitionContext:transitionContext container:container];
				break;
			
			
	default: nil;
			break;
	}
	
}

- (void)settingView
{
	UIStoryboard *strd = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	ViewController2 *vc2 = [strd instantiateViewControllerWithIdentifier:@"ViewController2ID"];
	vc2.comeBack = YES;
	vc2.modalPresentationStyle = UIModalPresentationCustom;
	[vc2 setTransitioningDelegate:self];
	[self presentViewController:vc2 animated:YES completion:^{ }];
}


	//SCALING TRANSITION
- (void)scalingTransitionFrom:(ViewController *)fromViewController to:(ViewController2 *)toViewController transitionContext:(nullable id <UIViewControllerContextTransitioning>)transitionContext container:(UIView *)container
{
	toViewController.view.alpha = 0.0f;
	fromViewController.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
	
	// add the both views to our view controller
	[container addSubview:toViewController.view];
	
	
		[UIView animateWithDuration:0.8 animations:^{
	
			fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1); //0.1, 0.1
			toViewController.view.alpha = 1.0f;
			//fromViewController.view.transform = CGAffineTransformMakeRotation(30);
	
		} completion:^(BOOL finished) {
	
			NSLog(@"scalingTransition");
			fromViewController.view.transform = CGAffineTransformIdentity;
//			self.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
			[transitionContext completeTransition:YES];
	
		}];
}

- (void)slideTransitionFrom:(ViewController *)fromViewController to:(ViewController2 *)toViewController transitionContext:(nullable id <UIViewControllerContextTransitioning>)transitionContext container:(UIView *)container
{
	// set up from 2D transforms that we'll use in the animation
	CGAffineTransform offScreenRight = CGAffineTransformMakeTranslation(container.frame.size.width, 0);
	CGAffineTransform offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.size.width, 0);
	
	// start the toView to the right of the screen
	toViewController.view.transform = offScreenRight;
	
	// add the both views to our view controller
	[container addSubview:toViewController.view];
	[container addSubview:fromViewController.view];
	
	
	
	// perform the animation!
	// for this example, just slid both fromView and toView to the left at the same time
	// meaning fromView is pushed off the screen and toView slides into view
	// we also use the block animation usingSpringWithDamping for a little bounce
	[UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
		
		fromViewController.view.transform = offScreenLeft;
		toViewController.view.transform = CGAffineTransformIdentity;
		
		
	} completion:^(BOOL finished) {
		
		NSLog(@"slideTransition");
		[transitionContext completeTransition:YES];
//		self.view.layer.anchorPoint = CGPointMake(0, 0);
		
	}];
}

- (void)rotateTransitionFrom:(ViewController *)fromViewController to:(ViewController2 *)toViewController transitionContext:(nullable id <UIViewControllerContextTransitioning>)transitionContext container:(UIView *)container
{
	
	// set up from 2D transforms that we'll use in the animation
	CGFloat π = 3.14159265359;
	
	CGAffineTransform offScreenRotateIn = CGAffineTransformMakeRotation(-π/2);
	CGAffineTransform offScreenRotateOut = CGAffineTransformMakeRotation(π/2);
	
	// set the start location of toView depending if we're presenting or not
	toViewController.view.transform = offScreenRotateIn;
	//toViewController.transform = self.presenting ? offScreenRotateIn : offScreenRotateOut
	
	
	// set the anchor point so that rotations happen from the top-left corner
	toViewController.view.layer.anchorPoint = CGPointMake(0, 0);
	fromViewController.view.layer.anchorPoint = CGPointMake(0, 0);
	
	// updating the anchor point also moves the position to we have to move the center position to the top-left to compensate
	toViewController.view.layer.position = CGPointMake(0, 0);
	fromViewController.view.layer.position = CGPointMake(0, 0);
	
	
	[UIView animateWithDuration:0.8 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
		
		fromViewController.view.transform = offScreenRotateIn;
		toViewController.view.transform = CGAffineTransformIdentity;
		
		
	} completion:^(BOOL finished) {
		
		NSLog(@"rotateTransition");
		[transitionContext completeTransition:YES];
		self.view.layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
		self.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
	}];
}


#pragma mark Action

- (void)slideAction {
	transitionNr = 1;
	[self settingView];
}

- (void)rotateAction {
	transitionNr = 2;
	[self settingView];
}

- (void)scaleAction {
	transitionNr = 3;
	[self settingView];
}

- (void)tableView:(ImoDynamicTableView *)tableView didTouchUpInsideCellSource:(IDDCellSource*)cellSource atIndexPath:(NSIndexPath *)indexPath
{
	if ([cellSource isKindOfClass:[IDDCellSource class]]) {
		[self performSelector:cellSource.selector];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
