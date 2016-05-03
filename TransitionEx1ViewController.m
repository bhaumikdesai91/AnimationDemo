//
//  TransitionEx1ViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 16/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "TransitionEx1ViewController.h"
#import "AppDelegate.h"

@interface TransitionEx1ViewController ()
{
    UIView *blueLayer;
    CATransform3D transformToAnimate;
}
@end

@implementation TransitionEx1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[AppDelegate calculateRandomColor]];
    blueLayer = [[UIView alloc] initWithFrame:self.rectFrom];
    blueLayer.layer.cornerRadius = blueLayer.frame.size.width/2;
    blueLayer.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES];
    switch ([self.transitionType intValue]) {
        case 1:
            transformToAnimate = CATransform3DMakeScale(40, 40, 1);
            break;
        case 2:
            blueLayer.layer.transform = CATransform3DMakeScale(40, 40, 1);
            transformToAnimate = CATransform3DMakeRotation(M_PI/2, 1, 0, 0);
            transformToAnimate = CATransform3DScale(transformToAnimate, .001, 0.001, 1);
            break;
        case 3:
            transformToAnimate = CATransform3DMakeTranslation(100, 0, 20);
            transformToAnimate = CATransform3DScale(transformToAnimate, 40, 40, 1);
            break;
        case 4:
            transformToAnimate = CATransform3DMakeTranslation(0, -200, 100);
            transformToAnimate = CATransform3DScale(transformToAnimate,40, 40, 1);

            break;
        case 5:
            transformToAnimate = CATransform3DMakeTranslation(0, 200, 100);
            transformToAnimate = CATransform3DScale(transformToAnimate,40, 40, 1);
            break;
            
        default:
            break;
    }
    // Do any additional setup after loading the view.
}
-(IBAction)close:(UIButton *)sender{
    blueLayer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - 100, self.view.frame.size.width, self.view.frame.size.height +200)];
    blueLayer.layer.cornerRadius = blueLayer.frame.size.width/2;
    blueLayer.backgroundColor = [UIColor blackColor];
    blueLayer.layer.transform = CATransform3DMakeScale(40, 60, 1);
    transformToAnimate = CATransform3DIdentity;
    transformToAnimate = CATransform3DMakeRotation(M_PI/2, 1, 0, 0);
    transformToAnimate = CATransform3DScale(transformToAnimate, .01, 0.01, 1);
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view.layer setMask:blueLayer.layer];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:1.0 animations:^{
        blueLayer.layer.transform = transformToAnimate;
    } completion:^(BOOL finished) {
        [blueLayer removeFromSuperview];
    }];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
     [blueLayer removeFromSuperview];
    }
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
