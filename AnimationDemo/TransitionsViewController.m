//
//  TransitionsViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 16/06/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "TransitionsViewController.h"
#import "TransitionEx1ViewController.h"

@interface TransitionsViewController ()

@end

@implementation TransitionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(IBAction)btnClicked:(UIButton *)sender{
    TransitionEx1ViewController *transEx = [[TransitionEx1ViewController alloc] init];
    transEx = [self.storyboard instantiateViewControllerWithIdentifier:@"transEX"];
    transEx.transitionType = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    transEx.rectFrom = sender.frame;
    [self.navigationController pushViewController:transEx animated:NO];
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
