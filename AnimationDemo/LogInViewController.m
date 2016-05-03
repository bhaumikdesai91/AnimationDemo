//
//  LogInViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 09/03/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usernameConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordConstraint;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *cancel;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.login.layer.cornerRadius = 5;
    self.cancel.layer.cornerRadius = 5;
    self.btnStart.layer.cornerRadius = 5;
    [self hideStart];
}
- (IBAction)btnStartClicked:(id)sender {
    [self hideStart];
}

-(void)showStart{
    CATransform3D firstTransform = CATransform3DMakeScale(1.3, 1.3, 1);
    [UIView animateKeyframesWithDuration:0.4 delay:0.0 options:(UIViewKeyframeAnimationOptionCalculationModeLinear) animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.7 animations:^{
            [self.btnStart.layer setTransform:firstTransform];
            [self.btnStart setAlpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            [self.btnStart.layer setTransform:CATransform3DIdentity];
        }];
    } completion:^(BOOL finished) {
        [self.btnStart.layer setTransform:CATransform3DIdentity];
    }];
}

-(void)hideStart{
    CATransform3D transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.4 animations:^{
        [self.btnStart.layer setTransform:transform];
        [self.btnStart setAlpha:0.0];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)calcelClicked:(id)sender forEvent:(UIEvent*)event{
    [self showStart];
    UIView *button = (UIView *)sender;
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint location = [touch locationInView:button];
    UIView *rippleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    rippleView.layer.cornerRadius = rippleView.frame.size.width/2;
    rippleView.center = location;
    rippleView.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    rippleView.alpha = 0.4;
    rippleView.backgroundColor = [UIColor whiteColor];
    [self.cancel addSubview:rippleView];
    [self.cancel setClipsToBounds:YES];
    [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        rippleView.alpha = 0;
        rippleView.layer.transform = CATransform3DMakeScale(10, 10, 10);
    } completion:^(BOOL finished) {
        [rippleView removeFromSuperview];
    }];
    
}
- (IBAction)loginClicked:(id)sender {
    
    CGRect bounds = self.login.bounds;
    UIColor *color = self.login.backgroundColor;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.alpha = 1.0;
    activityIndicator.hidesWhenStopped = NO;
    activityIndicator.center = CGPointMake(self.login.bounds.size.width - 30, self.login.bounds.size.height/2 - 5);
    UIColor *pasColor = [self.txtPassword backgroundColor];
    CGRect framePass = self.txtPassword.frame;
    UIView *snapShot = [self.txtPassword snapshotViewAfterScreenUpdates:NO];
    [snapShot setFrame:framePass];
    [self.view addSubview:snapShot];
    
    [activityIndicator startAnimating];
    [UIView animateWithDuration:1
                          delay:0.0
         usingSpringWithDamping:0.5 initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         snapShot.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.2);
                         [snapShot setBackgroundColor:[UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1]];
                         snapShot.layer.borderColor = [UIColor redColor].CGColor;
                         snapShot.layer.cornerRadius = 5;
                         snapShot.layer.borderWidth = 5;
        [self.login setBounds:CGRectMake(bounds.origin.x - 30, bounds.origin.y - 10, bounds.size.width + 60, bounds.size.height)];
        [self.login.titleLabel setFont:[self.login.titleLabel.font fontWithSize:20]];
        [self.view layoutIfNeeded];
        [self.login addSubview:activityIndicator];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.login.bounds = bounds;
            [self.login.titleLabel setFont:[self.login.titleLabel.font fontWithSize:15]];
            [self.login setBackgroundColor:color];
            [self.txtPassword setBounds:framePass];
            [self.txtPassword setBackgroundColor:pasColor];
            
            [self.view layoutIfNeeded];
            [snapShot removeFromSuperview];
            [activityIndicator removeFromSuperview];
        } completion:^(BOOL finished) {
            [snapShot removeFromSuperview];
        }];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.usernameConstraint.constant -= self.view.bounds.size.width;
    self.passwordConstraint.constant -= self.view.bounds.size.width;
    
    self.login.alpha = 0.0;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.usernameConstraint.constant += self.view.bounds.size.width;
               [self.view layoutIfNeeded];
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.passwordConstraint.constant += self.view.bounds.size.width;
        [self.view layoutIfNeeded];
    } completion:nil];
    
    [UIView animateWithDuration:0.2 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
      self.login.alpha = 1.0;
    } completion:nil];
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
