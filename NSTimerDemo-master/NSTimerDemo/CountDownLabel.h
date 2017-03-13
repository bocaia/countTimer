//
//  CountDownLabel.h
//  NSTimerDemo
//
//  Created by Gin on 16/10/25.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownLabel : UILabel

/// 根据传入的时间计算和当前时间的进行比较，开始倒计时
- (void)setupCountDownWithTargetTime:(NSDate *)targetTime;

/// 根据传入的具体秒数，开始倒计时
- (void)beginCountDownWithTimeInterval:(NSTimeInterval)timerInterval;

/// 根据传入的两个时间差，开始倒计时
- (void)beginCountDownFromTime:(NSDate *)fromDate toTime:(NSDate *)toDate;

@end
