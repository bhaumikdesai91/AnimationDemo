//
//  CircleTransitionAnimator.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 17/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "CircleTransitionAnimator.h"
#import "AppDelegate.h"

@implementation CircleTransitionAnimator{
    AppDelegate *appDelegate;
    CAShapeLayer *maskLayer;
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
    
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:[appDelegate rectForTransition]];
    
    CGPoint extremePoint = CGPointMake([appDelegate rectForTransition].origin.x + [appDelegate rectForTransition].size.width/2 + CGRectGetWidth(toViewController.view.bounds) ,[appDelegate rectForTransition].origin.x + [appDelegate rectForTransition].size.height/2 + CGRectGetHeight(toViewController.view.bounds));
    
    CGFloat radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset([appDelegate rectForTransition], -radius, -radius)];
                                     
    maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toViewController.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [maskLayer removeFromSuperlayer];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
}

@end
