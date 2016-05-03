//
//  PathAnimationVC.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 21/04/16.
//  Copyright © 2016 Bhaumik P. Desai. All rights reserved.
//

#import "PathAnimationVC.h"

@interface PathAnimationVC (){
    CGPoint newLocation;
    CGMutablePathRef curvedPath;
}
@end

@implementation PathAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_movingView.layer setShadowColor:[UIColor grayColor].CGColor];
    [_movingView.layer setShadowRadius:3.0];
    [_movingView.layer setShadowOpacity:0.4];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    //Setting Endpoint of the animation
    
    newLocation = [touch locationInView:self.view];
    
    CGPoint currentLocation = [_movingView.layer.presentationLayer position];
    [_movingView.layer setPosition:currentLocation];
    
    // Set up path movement
    curvedPath = CGPathCreateMutable();
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGPoint controlPoint1 = CGPointMake(newLocation.x, currentLocation.y);
    CGPoint controlPoint2 = CGPointMake(currentLocation.x, newLocation.y);
        
    CGPathMoveToPoint(curvedPath, NULL, currentLocation.x, currentLocation.y);
    CGPathAddCurveToPoint(curvedPath, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, newLocation.x, newLocation.y);
    pathAnimation.path = curvedPath;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    CGPathRelease(curvedPath);
    pathAnimation.duration = 0.7f;

    [_movingView.layer addAnimation:pathAnimation forKey:pathAnimation.keyPath];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [_movingView.layer setPosition:newLocation];
}

@end
