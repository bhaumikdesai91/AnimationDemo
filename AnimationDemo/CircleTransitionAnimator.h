//
//  CircleTransitionAnimator.h
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 17/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CircleTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property __strong id<UIViewControllerContextTransitioning> transitionContext;
@end
