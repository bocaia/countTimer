//
//  ViewController.m
//  NSTimerDemo
//
//  Created by Gin on 16/10/25.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"
#import "ControlRunLoopTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)jumpBtnClick:(id)sender {
    
    NewViewController *newVc = [[NewViewController alloc] init];
    [self presentViewController:newVc animated:YES completion:nil];
}

- (IBAction)segmentChanged:(id)sender {
    
    [[ControlRunLoopTool sharedTool] setUseRunLoop:![ControlRunLoopTool sharedTool].useRunLoop];
}

@end
