//
//  AssistiveTouchVC.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 06/10/15.
//  Copyright © 2015 Bhaumik P. Desai. All rights reserved.
//

#import "AssistiveTouchVC.h"
#import "AppDelegate.h"
#import "AssistView.h"

@interface AssistiveTouchVC (){
    AppDelegate *delegate;
}
@property (weak, nonatomic) IBOutlet UISwitch *assistOn;

@end

@implementation AssistiveTouchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.assistOn setOn:[delegate isAssistiveTouchVisible] animated:NO];
        // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)setAssistiveTouch:(UISwitch *)sender {
    AssistView *popView = (AssistView *)[[UIApplication sharedApplication].keyWindow viewWithTag:ASSIST_TAG];
    if (sender.isOn) {
        if (popView == nil) {
            popView = [[AssistView alloc] init];
        }
        [[UIApplication sharedApplication].keyWindow addSubview:popView];
        [delegate setAssistiveTouchVisible:YES];
    }else{
        [popView removeFromSuperview];
        popView = nil;
        [delegate setAssistiveTouchVisible:NO];
    }
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
