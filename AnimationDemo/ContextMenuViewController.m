//
//  ContextMenuViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 08/05/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "ContextMenuViewController.h"

@interface ContextMenuViewController ()
{
    NSMutableArray<UIButton *> *arForButtons;
}
@end

@implementation ContextMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arForButtons = (NSMutableArray<UIButton *> *)[[NSMutableArray alloc] init];
    [arForButtons addObject:self.btn1];
    [arForButtons addObject:self.btn2];
    [arForButtons addObject:self.btn3];
    [arForButtons addObject:self.btn4];
    [arForButtons addObject:self.btn5];
    
    [_btnMain.layer setShadowColor:[UIColor grayColor].CGColor];
    [_btnMain.layer setShadowRadius:3.0];
    [_btnMain.layer setShadowOpacity:0.4];
    for (UIButton *btn in arForButtons) {
        [btn.layer setShadowColor:[UIColor grayColor].CGColor];
        [btn.layer setShadowRadius:3.0];
        [btn.layer setShadowOpacity:0.4];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnMainTapped:(id)sender {
    if (_btnMain.selected) {
        [_btnMain setSelected:NO];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:(UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            for (UIButton *btn in arForButtons)btn.center = self.btnMain.center;
        } completion:^(BOOL finished) {
            for (UIButton *btn in arForButtons)btn.center = self.btnMain.center;
        }];
    }else{
        [_btnMain setSelected:YES];
        UIView *snapShot = [[UIView alloc] init];
        snapShot.frame = self.btnMain.frame;
        snapShot.layer.cornerRadius = snapShot.frame.size.width/2;
        snapShot.backgroundColor = self.btnMain.backgroundColor;
        [self.view addSubview:snapShot];
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:(UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            for (UIButton *btn in arForButtons)btn.frame = CGRectZero;
            snapShot.layer.transform = CATransform3DMakeScale(20, 20, 20);
            snapShot.alpha = 0.0;
        } completion:^(BOOL finished) {
            [snapShot removeFromSuperview];
        }];
    }
}

-(IBAction)btnClicked:(UIButton *)sender{
    [_btnMain setSelected:NO];
    UIView *snapShot = [[UIView alloc] init];
    snapShot.frame = sender.frame;
    snapShot.layer.cornerRadius = snapShot.frame.size.width/2;
    snapShot.backgroundColor = sender.backgroundColor;
    [self.view addSubview:snapShot];
    CGRect currentbuttonFrame = sender.frame;
    [self.view bringSubviewToFront:sender];
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        for (int i = 1; i <= 5; i++) {
            [UIView addKeyframeWithRelativeStartTime:0.1*i relativeDuration:0.45 animations:^{
                [(UIButton *)[arForButtons objectAtIndex:i - 1]setFrame:currentbuttonFrame];
            }];
        }
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
            snapShot.layer.transform = CATransform3DMakeScale(20, 20, 20);
            snapShot.alpha = 0.0;
            [self.view bringSubviewToFront:self.btnMain];
        }];
    } completion:^(BOOL finished) {
        for (UIButton *btn in arForButtons)btn.frame = currentbuttonFrame;
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:(UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState) animations:^{
            for (UIButton *btn in arForButtons)btn.center = self.btnMain.center;
        } completion:^(BOOL finished) {
            for (UIButton *btn in arForButtons)btn.center = self.btnMain.center;
        }];
    }];
}

@end
