//
//  AssistView.m
//  AnimationDemo
//  Created by Bhaumik P. Desai on 06/10/15.
//  Copyright © 2015 Bhaumik P. Desai. All rights reserved.

#import "AssistView.h"

#define ASSIST_WIDTH 70
#define ASSIST_HEIGHT 70
#define ASSIST_CORNER_RADIUS 35
#define ASSIST_TAG 11745

@implementation AssistView{
    CGPoint lastKnownLocation;
    BOOL shouldMoveAssist;
    BOOL shouldLetTap;
    BOOL snapyShown;
    UIView *snapy;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self != nil){
        [self setFrame:CGRectMake(0, 0, ASSIST_WIDTH, ASSIST_HEIGHT)];
        [self.layer setCornerRadius:ASSIST_CORNER_RADIUS];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
        shouldMoveAssist = NO;
        shouldLetTap = YES;
        self.tag = ASSIST_TAG;
    }
    return self;
}

#pragma mark - CUSTOM_EVENTS

-(void)btnAssistTapped{
    NSLog(@"AssistTaped");
    if (snapyShown) {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:20 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            [self setFrame:CGRectMake(lastKnownLocation.x - ASSIST_WIDTH/2, lastKnownLocation.y - ASSIST_HEIGHT/2, ASSIST_WIDTH, ASSIST_HEIGHT)];
            [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
        } completion:nil];
        snapyShown = NO;
    }else {
        [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:30 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
            [self setFrame:CGRectMake(20 , 50, self.superview.frame.size.width - 40, self.superview.frame.size.height - 100)];
            [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:1.0]];
        } completion:nil];
        snapyShown = YES;
    }
    
    [UIView animateWithDuration:0.3 delay:0.0 usingSpringWithDamping:30 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        
    } completion:nil];
}

#pragma mark - TOUCH EVENTS

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if ([touch locationInView:self].x > 0 && [touch locationInView:self].x < ASSIST_WIDTH && [touch locationInView:self].y > 0 && [touch locationInView:self].y < ASSIST_HEIGHT) {
        [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:1.0]];
        lastKnownLocation = self.center;
        shouldMoveAssist = YES;
        shouldLetTap = YES;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (snapyShown) {
        return;
    }
    shouldLetTap = NO;
    UITouch *touch = [touches anyObject];
    if (shouldMoveAssist) {
        [UIView animateWithDuration:0.1 animations:^{
            [self setCenter:[touch locationInView:[self superview]]];
             }];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (snapyShown) {
        [self btnAssistTapped];
        return;
    }
    shouldMoveAssist = NO;
    shouldLetTap = YES;
    [UIView animateWithDuration:0.1 animations:^{
        [self setCenter:lastKnownLocation];
    } completion:^(BOOL finished) {
        [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
    }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (snapyShown) {
        [self btnAssistTapped];
        return;
    }
    shouldMoveAssist = NO;
    CGPoint newLocation;
    if (CGRectContainsPoint(CGRectMake(lastKnownLocation.x - ASSIST_WIDTH/2, lastKnownLocation.y - ASSIST_HEIGHT/2, ASSIST_WIDTH, ASSIST_HEIGHT) , self.center) && shouldLetTap) {
        [self btnAssistTapped];
        return;
    }
    if (self.center.x < self.superview.frame.size.width/2 && self.center.y < self.superview.frame.size.height/2) {
        if (self.center.x < self.center.y) {
            newLocation = CGPointMake(ASSIST_WIDTH/2, self.center.y);
        } else {
            newLocation = CGPointMake(self.center.x, ASSIST_HEIGHT/2);
        }
    }else if (self.center.x > self.superview.frame.size.width/2 && self.center.y < self.superview.frame.size.height/2) {
        if ((self.superview.frame.size.width - self.center.x) < self.center.y) {
            newLocation = CGPointMake(self.superview.frame.size.width -ASSIST_WIDTH/2, self.center.y);
        } else {
            newLocation = CGPointMake(self.center.x, ASSIST_HEIGHT/2);
        }
    }else if (self.center.x < self.superview.frame.size.width/2 && self.center.y > self.superview.frame.size.height/2) {
        if (self.center.x < (self.superview.frame.size.height - self.center.y)) {
            newLocation = CGPointMake(ASSIST_WIDTH/2, self.center.y);
        } else {
            newLocation = CGPointMake(self.center.x, self.superview.frame.size.height - ASSIST_HEIGHT/2);
        }
    }else {
        if ((self.superview.frame.size.width - self.center.x) < (self.superview.frame.size.height - self.center.y)) {
            newLocation = CGPointMake(self.superview.frame.size.width - ASSIST_WIDTH/2, self.center.y);
        } else {
            newLocation = CGPointMake(self.center.x, self.superview.frame.size.height - ASSIST_HEIGHT/2);
        }
    }
    //NSLog(@"%f %f",newLocation.x , newLocation.y);
    if (newLocation.x < ASSIST_WIDTH/2) {
        newLocation = CGPointMake(ASSIST_WIDTH/2, newLocation.y);
    }
    if (newLocation.x > (self.superview.frame.size.width - ASSIST_WIDTH/2)) {
        newLocation = CGPointMake(self.superview.frame.size.width - ASSIST_WIDTH/2, newLocation.y);
    }
    if (newLocation.y < ASSIST_HEIGHT/2) {
        newLocation = CGPointMake(newLocation.x, ASSIST_HEIGHT/2);
    }
    if (newLocation.y > (self.superview.frame.size.height - ASSIST_HEIGHT/2)) {
        newLocation = CGPointMake(newLocation.x, self.superview.frame.size.height - ASSIST_HEIGHT/2);
    }
    [UIView animateWithDuration:0.1 animations:^{
        [self setCenter:newLocation];
    } completion:^(BOOL finished) {
        [self setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.5]];
    }];
}

@end
