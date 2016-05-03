//
//  NavigationControllerDelegate.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 17/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"
#import "DrawerAnimator.h"
#import "FliperAnimator.h"
#import "AppDelegate.h"

@implementation NavigationControllerDelegate{
    AppDelegate *appDelegate;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [panGesture setEdges:(UIRectEdgeLeft)];
    [self.navigationController.view addGestureRecognizer:panGesture];
}
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    int selected = appDelegate.transitionType;
    switch (selected) {
        case 0:
            return [[CircleTransitionAnimator alloc] init];
            break;
        case 1:
            return [[DrawerAnimator alloc]init];
            break;
        case 2:
            return [[FliperAnimator alloc]init];
            break;
            
        default:
            return [[FliperAnimator alloc]init];
            break;
    }
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}

-(void)panned:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation;
    CGFloat completionProgress;
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
            if (self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:TRUE];
            }else if(self.navigationController.viewControllers.count == 1){
                return;
            }else{
                [self.navigationController.topViewController performSegueWithIdentifier:@"PushSegue" sender:nil];
            }
            break;
        case UIGestureRecognizerStateChanged:
            translation = [gestureRecognizer translationInView:self.navigationController.view];
            completionProgress = translation.x/CGRectGetWidth(self.navigationController.view.bounds);
            [self.interactionController updateInteractiveTransition:completionProgress];
            
            break;
        case UIGestureRecognizerStateEnded:
            if ([gestureRecognizer velocityInView:self.navigationController.view].x>0) {
                [self.interactionController finishInteractiveTransition];
            }else {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            break;
            
        default:
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
            break;
    }
}
@end
