//
//  DrawerAnimator.h
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 18/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawerAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property __strong id<UIViewControllerContextTransitioning> transitionContext;
@end

