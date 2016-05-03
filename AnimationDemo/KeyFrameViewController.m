//
//  KeyFrameViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 09/03/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "KeyFrameViewController.h"

@interface KeyFrameViewController ()
{
    UIView *greenView;
    CGRect frame;
    UIView *snapShotMove;
    CGPoint startLocation;
}
@end

@implementation KeyFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView{
    greenView = [[UIView alloc] initWithFrame:self.view.bounds];
    greenView.backgroundColor = [UIColor lightGrayColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    imageView.image = [UIImage imageNamed:@"bg.jpg"];
    [greenView setAutoresizesSubviews:YES];
    [imageView setClipsToBounds:YES];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    UIButton *dissmissButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 60, self.view.bounds.size.height / 2 - 20, 120, 40)];
    [dissmissButton setTitle:@"Send Now!" forState:UIControlStateNormal];
    [dissmissButton addTarget:self action:@selector(dissmissClicked) forControlEvents:UIControlEventTouchUpInside];
    dissmissButton.backgroundColor = [UIColor brownColor];
    dissmissButton.layer.cornerRadius = 5;
    [greenView addSubview:imageView];
    [greenView addSubview:dissmissButton];
    [self.view addSubview:greenView];
    frame = dissmissButton.frame;
}

-(void)dissmissClicked{
    CGRect bounds = greenView.bounds;
    
    CGRect smallFrame = CGRectInset(greenView.frame, greenView.frame.size.width/4, greenView.frame.size.height/4);
    CGRect finalFrame = CGRectOffset(smallFrame, bounds.size.width,0);
    
    UIView *snapshot = [greenView snapshotViewAfterScreenUpdates:NO];
    
    [snapshot setContentMode:UIViewContentModeScaleToFill];
    snapshot.layer.borderWidth = 5;
    snapshot.layer.borderColor = [UIColor brownColor].CGColor;
    
    [greenView setContentMode:UIViewContentModeScaleToFill];
    snapshot.frame = frame;
    [self.view addSubview:snapshot];
    [snapshot setAlpha:0.1];
    
    
    //[greenView removeFromSuperview];
    [UIView animateKeyframesWithDuration:2 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic|UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.3 animations:^{
            snapshot.center = CGPointMake(snapshot.center.x + 150, snapshot.center.y);
            snapshot.transform = CGAffineTransformMakeScale(0.7, 2);
            [snapshot setAlpha:1.0];
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
            snapshot.transform = CGAffineTransformIdentity;
            snapshot.frame = smallFrame;
            
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
            snapshot.frame = finalFrame;
            snapshot.transform = CGAffineTransformRotate(snapshot.transform, M_PI/2);
        }];
    } completion:^(BOOL finished) {
        [snapshot removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = (UITouch *)[[touches objectEnumerator] nextObject];
    startLocation = [touch locationInView:self.view];

    snapShotMove = [greenView snapshotViewAfterScreenUpdates:NO];
    
    [snapShotMove setContentMode:UIViewContentModeScaleToFill];
    snapShotMove.layer.borderWidth = 5;
    snapShotMove.layer.borderColor = [UIColor brownColor].CGColor;
    [self.view addSubview:snapShotMove];
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = (UITouch *)[[touches objectEnumerator] nextObject];
    
    CGPoint newOrigin;
    
    newOrigin.x = [touch locationInView:self.view].x - startLocation.x;
    newOrigin.y = [touch locationInView:self.view].y - startLocation.y;
    
    [snapShotMove setFrame:CGRectMake(newOrigin.x / 4,newOrigin.y / 4, snapShotMove.frame.size.width, snapShotMove.frame.size.height)];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (startLocation.y < [[[touches objectEnumerator] nextObject] locationInView:self.view].y - 20) {
        
         CGRect bounds = greenView.bounds;
        CGRect smallFrame = CGRectInset(greenView.frame, greenView.frame.size.width/4, greenView.frame.size.height/4);
        CGRect finalFrame = CGRectOffset(smallFrame, 0,bounds.size.height);
        [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic|UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            
            [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1 animations:^{
                snapShotMove.frame = finalFrame;
            }];
        } completion:^(BOOL finished) {
            [snapShotMove removeFromSuperview];
        }];

    }else{
        [UIView animateWithDuration:1 animations:^{
            snapShotMove.center = self.view.center;
            snapShotMove.alpha = 0.1;
        } completion:^(BOOL finished) {
            [snapShotMove removeFromSuperview];
        }];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:1 animations:^{
        snapShotMove.center = self.view.center;
        snapShotMove.alpha = 0.1;
    } completion:^(BOOL finished) {
        [snapShotMove removeFromSuperview];
    }];
}

@end
