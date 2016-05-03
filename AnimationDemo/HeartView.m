//
//  HeartView.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 08/05/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "HeartView.h"

@implementation HeartView

-(UIColor *)calculateRandomColor
{
    CGFloat randomRed = (CGFloat)drand48();
    CGFloat randomGreen = (CGFloat)drand48();
    CGFloat randomBlue = (CGFloat)drand48();
    return [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Move the X-origin to center to simplify
    CGContextTranslateCTM(context, CGRectGetMidX(rect), 0);
    
    // Set up stroke and fill colors
    UIColor *fillColor = [self calculateRandomColor];
    UIColor *strokeColor = [self calculateRandomColor];
    
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    
    // Start and End points
    CGPoint startPoint = {0.0f, 11.50f};
    CGPoint endPoint = {0.0f, 30.0f};
    
    // First control point (top)
    CGPoint cp1 = {7.50f, 1.50f};
    // Second control point (bottom)
    CGPoint cp2 = {22.00f, 13.00f};
    
    // Begin new path and move to starting point
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    
    // Draw Right Side
    CGContextAddCurveToPoint(context, cp1.x, cp1.y, cp2.x, cp2.y, endPoint.x, endPoint.y);
    // Draw Light Side
    CGContextAddCurveToPoint(context, -cp2.x, cp2.y, -cp1.x, cp1.y, startPoint.x, startPoint.y);
    
    // Close and draw path
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

-(void)fly{
    [UIView animateKeyframesWithDuration:10 delay:0 options:(UIViewKeyframeAnimationOptionCalculationModePaced|UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            self.center = CGPointMake(self.center.x - (40+ rand()%50) , self.center.y - 40);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.1 animations:^{
            
            self.center = CGPointMake(self.center.x + 40 , self.center.y - 40);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.1 animations:^{
            self.center = CGPointMake(self.center.x - 40 , self.center.y - 40);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.1 animations:^{
            
            self.center = CGPointMake(self.center.x + 40 , self.center.y - 40);
            self.alpha -= 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.1 animations:^{
            self.center = CGPointMake(self.center.x - 40 , self.center.y - 40);
            self.alpha -= 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.1 animations:^{
            
            self.center = CGPointMake(self.center.x + 40 , self.center.y - 40);
            self.alpha -= 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.1 animations:^{
            self.center = CGPointMake(self.center.x - 40 , self.center.y - 40);
            self.alpha -= 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.1 animations:^{
            
            self.center = CGPointMake(self.center.x + 40 , self.center.y - 40);
            self.alpha -= 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.1 animations:^{
            self.center = CGPointMake(self.center.x - 40 , self.center.y - 40);
            self.alpha -= 0.1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            
            self.center = CGPointMake(self.center.x + 40 , self.center.y - 40);
        }];
    } completion:^(BOOL finished) {
        if (self.center.y < -20) {
            [self removeFromSuperview];
        }else {
            [self fly];
        }
    }];
}

@end
