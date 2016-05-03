//
//  ViewController.m
//  AnimationDemo
//
//  Created by Bhaumik P. Desai on 09/03/15.
//  Copyright (c) 2015 Bhaumik P. Desai. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AssistView.h"

@interface ViewController ()
{
    AppDelegate *appDelegate;
}
@end

@implementation ViewController
- (IBAction)segTransitionType:(UISegmentedControl *)sender {
    int selected = (int)[sender selectedSegmentIndex];
    appDelegate.transitionType = selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)drawerOpen:(id)sender{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CGRect rect = [self.tableView rectForRowAtIndexPath:[[self.tableView indexPathsForSelectedRows] firstObject]];
//    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[[self.tableView indexPathsForSelectedRows] firstObject]];
//    CGRect rect = cell.frame;
//    appDelegate.rectForTransition = rect;
}

@end
