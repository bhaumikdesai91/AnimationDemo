//
//  FieldBehaviorViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 01/10/15.
//  Copyright © 2015 Bhaumik P. Desai. All rights reserved.
//

#import "FieldBehaviorViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "Ellipse.h"


@interface FieldBehaviorViewController ()
{
    UIDynamicAnimator *animator;
    UIFieldBehavior *fieldBehavior;
    UIGravityBehavior *gravity;
    UIView *currentView;
    UIView *square;
    NSMutableArray *items;
    Ellipse *circle;
    Ellipse *circle1;
    Ellipse *circle2;
    Ellipse *circle3;
    NSLayoutConstraint *constraintForTopSpace;
}
@property (weak, nonatomic) IBOutlet UISlider *sliderField;
@property (nonatomic, strong) CMMotionManager *manager;
@end

@implementation FieldBehaviorViewController

- (void)keyboardWasShown:(NSNotification *)notification {
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    // Here you can set your constraint's constant to lift your container up.
    [UIView animateWithDuration:0.5 animations:^{
        [constraintForTopSpace setConstant:constraintForTopSpace.constant + height];
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int height = MIN(keyboardSize.height,keyboardSize.width);
    
    // Here you can set your constraint's constant to move your container down.
    [UIView animateWithDuration:0.5 animations:^{
        [constraintForTopSpace setConstant:constraintForTopSpace.constant - height];
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    square = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 100, 100))];
    [square setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:square];
    
    circle = [[Ellipse alloc] initWithFrame:(CGRectMake(0, 0, 100, 100))];
    [circle setBackgroundColor:[UIColor greenColor]];
    [circle.layer setCornerRadius:50];
    [circle setClipsToBounds:YES];
    [self.view addSubview:circle];
    
    circle1 = [[Ellipse alloc] initWithFrame:(CGRectMake(100, 0, 100, 100))];
    [circle1 setBackgroundColor:[UIColor yellowColor]];
    [circle1.layer setCornerRadius:50];
    [circle1 setClipsToBounds:YES];
    [self.view addSubview:circle1];
    
    circle2 = [[Ellipse alloc] initWithFrame:(CGRectMake(150, 0, 100, 100))];
    [circle2 setBackgroundColor:[UIColor redColor]];
    [circle2.layer setCornerRadius:50];
    [circle2 setClipsToBounds:YES];
    [self.view addSubview:circle2];
    
    circle3 = [[Ellipse alloc] initWithFrame:(CGRectMake(200, 0, 100, 100))];
    [circle3 setBackgroundColor:[UIColor purpleColor]];
    [circle3.layer setCornerRadius:50];
    [circle3 setClipsToBounds:YES];
    [self.view addSubview:circle3];
    
    items = [[NSMutableArray alloc] initWithObjects:square, circle, circle1, circle2, circle3, nil];
    
    gravity = [[UIGravityBehavior alloc] initWithItems:items];
    [animator addBehavior:gravity];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    dispatch_queue_t queue = dispatch_queue_create("Calculation", 0);
    dispatch_async(queue, ^{
        fieldBehavior = [UIFieldBehavior noiseFieldWithSmoothness:1.0 animationSpeed:1];
        [fieldBehavior addItem:square];
        [fieldBehavior addItem:circle];
        [fieldBehavior addItem:circle1];
        [fieldBehavior addItem:circle2];
        [fieldBehavior addItem:circle3];
        [fieldBehavior setStrength:0.5];
        [animator addBehavior:fieldBehavior];
        
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
        [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:(UIEdgeInsetsMake(20, 5, 5, 5))];
        [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
        [animator addBehavior:collisionBehavior];
        self.manager = [[CMMotionManager alloc] init];
        if (self.manager.isDeviceMotionAvailable) {
            [self.manager startDeviceMotionUpdates];
            [self.manager setDeviceMotionUpdateInterval:0.1];
            [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
                if (!error) {
                    [gravity setGravityDirection:(CGVectorMake(motion.gravity.x, -motion.gravity.y))];
                }
            }];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    [fieldBehavior setStrength:sender.value*100];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *subView in self.view.subviews) {
        CGPoint point = [[touches anyObject] locationInView:subView];
        if (point.x >0 && point.y >0 && point.x< subView.frame.size.width && point.y< subView.frame.size.height) {
            currentView = subView;
            [self.manager stopDeviceMotionUpdates];
            [items removeObject:subView];
            [animator removeAllBehaviors];
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [currentView setCenter:[[touches anyObject] locationInView:self.view]];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (currentView == nil) {
        return;
    }
    [items addObject:currentView];
    currentView = nil;
    gravity = [[UIGravityBehavior alloc] initWithItems:items];
    [animator addBehavior:gravity];
    
    fieldBehavior = [UIFieldBehavior noiseFieldWithSmoothness:1.0 animationSpeed:1];
    [fieldBehavior addItem:square];
    [fieldBehavior addItem:circle];
    [fieldBehavior addItem:circle1];
    [fieldBehavior addItem:circle2];
    [fieldBehavior addItem:circle3];
    [fieldBehavior setStrength:self.sliderField.value*100];
    [animator addBehavior:fieldBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:(UIEdgeInsetsMake(20, 5, 5, 5))];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
    [animator addBehavior:collisionBehavior];
    self.manager = [[CMMotionManager alloc] init];
    
    if (self.manager.isDeviceMotionAvailable) {
        [self.manager startDeviceMotionUpdates];
        [self.manager setDeviceMotionUpdateInterval:0.1];
        [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (!error) {
                [gravity setGravityDirection:(CGVectorMake(motion.gravity.x, -motion.gravity.y))];
            }
        }];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (currentView == nil) {
        return;
    }
    [items addObject:currentView];
    currentView = nil;
    gravity = [[UIGravityBehavior alloc] initWithItems:items];
    [animator addBehavior:gravity];
    
    fieldBehavior = [UIFieldBehavior noiseFieldWithSmoothness:1.0 animationSpeed:1];
    [fieldBehavior addItem:square];
    [fieldBehavior addItem:circle];
    [fieldBehavior addItem:circle1];
    [fieldBehavior addItem:circle2];
    [fieldBehavior addItem:circle3];
    [fieldBehavior setStrength:self.sliderField.value*100];
    [animator addBehavior:fieldBehavior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:(UIEdgeInsetsMake(20, 5, 5, 5))];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
    [animator addBehavior:collisionBehavior];
    self.manager = [[CMMotionManager alloc] init];
    
    [self.manager startDeviceMotionUpdates];
    
    if (self.manager.isDeviceMotionAvailable) {
        [self.manager setDeviceMotionUpdateInterval:0.1];
        [self.manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            [gravity setGravityDirection:(CGVectorMake(motion.gravity.x*2, -motion.gravity.y*2))];
        }];
    }
}

@end
