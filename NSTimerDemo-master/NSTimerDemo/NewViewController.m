//
//  NewViewController.m
//  NSTimerDemo
//
//  Created by Gin on 16/10/25.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import "NewViewController.h"
#import "CountDownLabel.h"

@interface NewViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet CountDownLabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [_countDownLabel setupCountDownWithTargetTime:[NSDate dateWithTimeIntervalSinceNow:20]];
    
    _textView.delegate = (id)self;
}

- (IBAction)closeBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"--dismiss--");
    }];
}

#pragma mark - UITextViewDelegate<

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    NSLog(@"%s, %@", __func__, [[NSRunLoop mainRunLoop] currentMode]);
}

@end
