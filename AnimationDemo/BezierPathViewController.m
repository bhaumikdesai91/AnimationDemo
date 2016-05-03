//
//  BezierPathViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 08/05/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "BezierPathViewController.h"

@interface BezierPathViewController ()

@end

@implementation BezierPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        
        HeartView *heart = [[HeartView alloc] initWithFrame:CGRectMake(point.x, point.y, 40, 40)];
        [self.view addSubview:heart];
        heart.backgroundColor = [UIColor clearColor];
        heart.center = point;
        [heart fly];
        [self.view layoutIfNeeded];
        [UIView animateKeyframesWithDuration:1 delay:0 options:(UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
                heart.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.3 animations:^{
                heart.layer.transform = CATransform3DIdentity;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
                heart.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
                heart.layer.transform = CATransform3DIdentity;
            }];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    HeartView *heart = [[HeartView alloc] initWithFrame:CGRectMake(0, 400, 40, 40)];
    [self.view addSubview:heart];
    heart.backgroundColor = [UIColor clearColor];
    heart.center = self.view.center;
    [heart fly];
    [self.view layoutIfNeeded];
    [UIView animateKeyframesWithDuration:1 delay:0 options:(UIViewKeyframeAnimationOptionRepeat|UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            heart.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.3 animations:^{
            heart.layer.transform = CATransform3DIdentity;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
            heart.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            heart.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
      
    }];
    
}

@end
