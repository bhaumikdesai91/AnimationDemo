//
//  AppDelegate.h
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 09/03/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "appirater-master/Appirater.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) CGRect rectForTransition;
@property (nonatomic) int transitionType;

+(UIColor *)calculateRandomColor;
-(BOOL)isAssistiveTouchVisible;
-(void)setAssistiveTouchVisible:(BOOL)visible;
@end

