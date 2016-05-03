//
//  DrawerAnimator.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 18/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "DrawerAnimator.h"
#import "AppDelegate.h"

@implementation DrawerAnimator{
    AppDelegate *appDelegate;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return  self;
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [containerView addSubview:toViewController.view];
    containerView.backgroundColor = [UIColor grayColor];
    
    CATransform3D fromTransform1 = CATransform3DIdentity;
    CATransform3D toTransform1 = CATransform3DIdentity;
    fromTransform1 = CATransform3DTranslate(fromTransform1,0,0,-100);
    fromTransform1 = CATransform3DScale(fromTransform1, 1.5, 1.5, 0);
    
    CABasicAnimation *maskLayerAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    maskLayerAnimation1.fromValue = [NSValue valueWithCATransform3D:fromTransform1];
    maskLayerAnimation1.toValue = [NSValue valueWithCATransform3D:toTransform1];
    maskLayerAnimation1.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation1.delegate = self;
    [toViewController.view.layer addAnimation:maskLayerAnimation1 forKey:@"transform"];
    
    CATransform3D fromTransform = CATransform3DIdentity;
    CATransform3D toTransform = CATransform3DMakeScale(0.6, 0.6, 1);
    toTransform = CATransform3DTranslate(toTransform, fromViewController.view.bounds.size.width,0, 100);
    toTransform = CATransform3DRotate(toTransform, M_PI/6 , 0, -1, 0);
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    maskLayerAnimation.fromValue = [NSValue valueWithCATransform3D:fromTransform];
    maskLayerAnimation.toValue = [NSValue valueWithCATransform3D:toTransform];
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [fromViewController.view.layer addAnimation:maskLayerAnimation forKey:@"transform"];
    fromViewController.view.layer.masksToBounds = NO;
    fromViewController.view.layer.shadowOffset = CGSizeMake(-15, 20);
    fromViewController.view.layer.shadowRadius = 2;
    fromViewController.view.layer.shadowOpacity = 0.5;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [[self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer removeAnimationForKey:@"transform"];
    //[[self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer removeAnimationForKey:@"transform"];
}


@end
