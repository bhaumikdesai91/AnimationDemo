//
//  MaterialViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 22/04/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "MaterialViewController.h"

#define KANIMATEMAINVIEW 110
#define KANIMATEBAR1VIEW 111
#define KANIMATEBAR2VIEW 112
#define KANIMATEBAR3VIEW 113

@interface MaterialViewController ()
@property (strong, nonatomic) IBOutlet UIView *materialView;
@property (weak, nonatomic) IBOutlet UIButton *go;
@property (nonatomic) BOOL isOn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthForMainView;
@property (strong, nonatomic) UIView *goSnap;
@end

@implementation MaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goSnap = [[UIView alloc] init];
    self.go.layer.cornerRadius = self.go.frame.size.width/2;
    self.materialView.alpha = 0.0;
    self.goSnap.backgroundColor = self.go.backgroundColor;
    [self.goSnap setFrame:self.go.frame];
    self.goSnap.layer.cornerRadius = self.goSnap.frame.size.width/2;
    self.materialView.layer.masksToBounds = YES;
    [self.goSnap setAutoresizesSubviews:NO];
    UIView *main = [self.view viewWithTag:KANIMATEMAINVIEW];
    main.layer.cornerRadius = main.frame.size.height/2;
    main.layer.borderColor = [UIColor purpleColor].CGColor;
    main.layer.borderWidth = 0.5;
    [main setClipsToBounds:YES];

    // Do any additional setup after loading the view.
}
- (IBAction)goClicked:(id)sender {
    if (!self.isOn) {
        
        UIView *bar1 = [self.view viewWithTag:KANIMATEBAR1VIEW];
        UIView *bar2 = [self.view viewWithTag:KANIMATEBAR2VIEW];
        UIView *bar3 = [self.view viewWithTag:KANIMATEBAR3VIEW];
        
        self.goSnap = [[UIView alloc] init];
        self.go.layer.cornerRadius = self.go.frame.size.width/2;
        self.materialView.alpha = 0.0;
        self.goSnap.backgroundColor = self.go.backgroundColor;
        [self.goSnap setFrame:self.go.frame];
        self.goSnap.layer.cornerRadius = self.goSnap.frame.size.width/2;
        self.materialView.layer.masksToBounds = YES;
        [self.goSnap setAutoresizesSubviews:NO];

        [self.view addSubview:self.goSnap];
        [self.goSnap setFrame:self.go.frame];
        [self.view layoutIfNeeded];
               [UIView animateKeyframesWithDuration:1 delay:0 options:(UIViewKeyframeAnimationOptionCalculationModeLinear) animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
                bar1.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -10, 0, 0);
                bar3.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -10, 0, 0);
                bar1.layer.transform = CATransform3DRotate(bar1.layer.transform, 45, 1, 0, 1);
                bar2.layer.transform = CATransform3DTranslate(CATransform3DIdentity, -30, 0, 0);
                bar3.layer.transform = CATransform3DRotate(bar3.layer.transform, -45, 1, 0, 1);
                [self.widthForMainView setConstant:self.widthForMainView.constant + 100];
                [self.view layoutIfNeeded];
                self.goSnap.center = CGPointMake(self.materialView.frame.size.width/2, self.materialView.frame.size.height/2 + 100);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
                [self.goSnap removeFromSuperview];
                self.materialView.maskView = self.goSnap;
                self.goSnap.center = CGPointMake(self.materialView.frame.size.width/2, self.materialView.frame.size.height/2);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
                self.goSnap.layer.transform = CATransform3DMakeScale(30, 30, 30);
                
                self.materialView.alpha = 1.0;
            }];
        } completion:^(BOOL finished) {
            self.materialView.maskView = nil;
            
        }];
        
        self.isOn = YES;
    }else{
        UIView *bar1 = [self.view viewWithTag:KANIMATEBAR1VIEW];
        UIView *bar2 = [self.view viewWithTag:KANIMATEBAR2VIEW];
        UIView *bar3 = [self.view viewWithTag:KANIMATEBAR3VIEW];
               self.goSnap = [[UIView alloc] init];
        self.go.layer.cornerRadius = self.go.frame.size.width/2;
        self.goSnap.backgroundColor = self.go.backgroundColor;
        [self.goSnap setFrame:self.go.frame];
        self.goSnap.layer.cornerRadius = self.goSnap.frame.size.width/2;
        self.materialView.layer.masksToBounds = YES;
        [self.goSnap setAutoresizesSubviews:NO];
        [self.view addSubview:self.goSnap];
        self.goSnap.layer.transform = CATransform3DMakeScale(30, 30, 30);
        self.goSnap.center = CGPointMake(self.materialView.frame.size.width/2, self.materialView.frame.size.height/2);
        [self.view layoutIfNeeded];
        [UIView animateKeyframesWithDuration:1 delay:0 options:(UIViewKeyframeAnimationOptionCalculationModeLinear) animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
                [self.goSnap removeFromSuperview];
                self.materialView.maskView = self.goSnap;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.2 animations:^{
                self.goSnap.center = CGPointMake(self.materialView.frame.size.width/2, self.materialView.frame.size.height/2);
            }];
            [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                self.goSnap.layer.transform = CATransform3DIdentity;
                self.goSnap.center = CGPointMake(self.materialView.frame.size.width/2, self.materialView.frame.size.height/2 + 100);
                self.materialView.alpha  = 0.0;
                [self.widthForMainView setConstant:self.widthForMainView.constant - 100];
                [self.view layoutIfNeeded];
                bar1.layer.transform = CATransform3DIdentity;
                bar2.layer.transform = CATransform3DIdentity;
                bar3.layer.transform = CATransform3DIdentity;

            }];
        } completion:^(BOOL finished) {
            self.materialView.maskView = nil;
        }];
        self.isOn = NO;
    }
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
