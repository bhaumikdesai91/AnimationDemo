//
//  CardsViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 02/10/15.
//  Copyright © 2015 Bhaumik P. Desai. All rights reserved.
//

#import "CardsViewController.h"

@interface CardsViewController ()

@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    frame.origin.y = -self.view.frame.size.height; //optional: if you want the view to drop down
    self.cardsDraggableView = [[DraggableViewBackground alloc]initWithFrame:frame];
    self.cardsDraggableView.alpha = 0; //optional: if you want the view to fade in
    
    [self.view addSubview:self.cardsDraggableView];
    
    //optional: animate down and in
    [UIView animateWithDuration:0.5 animations:^{
        self.cardsDraggableView.center = self.view.center;
        self.cardsDraggableView.alpha = 1;
    }];
    // Do any additional setup after loading the view.
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
