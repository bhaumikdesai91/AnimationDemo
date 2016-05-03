//
//  ActivityViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 07/05/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController (){

}

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ActivityView.layer.cornerRadius =  self.ActivityView.frame.size.width/2;
    self.ActivityView.layer.borderWidth = 2;
    self.activityView2.backgroundColor = [UIColor clearColor];
    self.activityView2.layer.borderColor = [UIColor blackColor].CGColor;
    self.activityView2.layer.borderWidth = 10;
    self.activityView2.layer.cornerRadius = self.activityView2.frame.size.width/2;
    [self.view addSubview:self.activityView2];
    self.activityView2.center = self.ActivityView.center;
    [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(reAnimate) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reAnimate
{
    int i = rand()%6;
    [UIView animateKeyframesWithDuration:1 delay:0 options:(UIViewKeyframeAnimationOptionAutoreverse) animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            self.ActivityView.layer.transform = CATransform3DMakeRotation(rand()%30, 1, 1, 0);
            self.ActivityView.backgroundColor = [self calculateRandomColor];
            self.ActivityView.layer.borderColor = [self calculateRandomColor].CGColor;
            self.ActivityView.layer.transform = CATransform3DMakeScale(i/10, i/10, 1);
            self.activityView2.layer.transform = CATransform3DMakeRotation(rand()%30, 1, 1, 0);
            self.activityView2.layer.borderColor = [self calculateRandomColor].CGColor;
            self.activityView2.layer.transform = CATransform3DMakeScale(i/10, i/10, 1);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.25 animations:^{
            self.ActivityView.layer.transform = CATransform3DMakeRotation(rand()%30, 0, 1, 1);
            self.ActivityView.backgroundColor = [self calculateRandomColor];
            self.ActivityView.layer.borderColor = [self calculateRandomColor].CGColor;
            self.activityView2.layer.transform = CATransform3DMakeRotation(rand()%30, 0, 1, 1);
            self.activityView2.layer.borderColor = [self calculateRandomColor].CGColor;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
            self.ActivityView.layer.transform = CATransform3DMakeRotation(rand()%30, 1, 0, 1);
            self.ActivityView.backgroundColor = [self calculateRandomColor];
            self.ActivityView.layer.borderColor = [self calculateRandomColor].CGColor;
            self.activityView2.layer.transform = CATransform3DMakeRotation(rand()%30, 1, 0, 1);
            self.activityView2.layer.borderColor = [self calculateRandomColor].CGColor;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
            self.ActivityView.layer.transform = CATransform3DIdentity;
            self.ActivityView.backgroundColor = [self calculateRandomColor];
            self.ActivityView.layer.borderColor = [self calculateRandomColor].CGColor;
            self.activityView2.layer.transform = CATransform3DIdentity;
            self.activityView2.layer.borderColor = [self calculateRandomColor].CGColor;
        }];
    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}

-(UIColor *)calculateRandomColor
{
    CGFloat randomRed = (CGFloat)drand48();
    CGFloat randomGreen = (CGFloat)drand48();
    CGFloat randomBlue = (CGFloat)drand48();
    return [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1.0];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
