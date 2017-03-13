//
//  CountDownLabel.m
//  NSTimerDemo
//
//  Created by Gin on 16/10/25.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import "CountDownLabel.h"
#import "ControlRunLoopTool.h"

@interface CountDownLabel ()

/// 定时器，使用 weak 或者 strong 都行
@property (nonatomic, strong) NSTimer *timer;
/// 剩余天数
@property (nonatomic, assign) NSUInteger day;
/// 剩余小时数
@property (nonatomic, assign) NSUInteger hour;
/// 剩余分钟数
@property (nonatomic, assign) NSUInteger minute;
/// 剩余秒数
@property (nonatomic, assign) NSUInteger second;

@end

@implementation CountDownLabel

/// 根据传入的时间计算和当前时间的进行比较，开始倒计时
- (void)setupCountDownWithTargetTime:(NSDate *)targetTime {
    
    // 计算传入的时间和当前的时间差
    NSTimeInterval interval = [targetTime timeIntervalSinceDate:[NSDate date]];
    [self initTimeParametersWithTimeInterval:(NSInteger)interval];
}

/// 根据传入的具体秒数，开始倒计时
- (void)beginCountDownWithTimeInterval:(NSTimeInterval)timerInterval {
    
    [self initTimeParametersWithTimeInterval:timerInterval];
}

/// 根据传入的两个时间差，开始倒计时
- (void)beginCountDownFromTime:(NSDate *)fromDate toTime:(NSDate *)toDate {
    
    NSTimeInterval interval = [fromDate timeIntervalSinceDate:toDate];
    [self initTimeParametersWithTimeInterval:interval];
}

/// 通过传入的时间间隔对时间参数进行初始化
- (void)initTimeParametersWithTimeInterval:(NSInteger)interval {
    
    NSUInteger secondPerDay = 24 * 60 * 60;
    NSUInteger secondPerHour = 60 * 60;
    NSUInteger secondPerMinute = 60;
    
    // 计算天数
    self.day = interval / secondPerDay;
    // 剩余小时不应该大于24小时，所以应该先除去满足一天的秒数，再计算还剩下多少小时
    self.hour = interval % secondPerDay / secondPerHour;
    // 剩余分钟数与上面同理
    self.minute = interval % secondPerHour / secondPerMinute;
    // 剩余秒数直接等于秒数对每分钟秒数所取的余数
    self.second = interval % secondPerMinute;
    
    // 更新值
    [self updateText];
    
    // 最好不要使用 currentRunLoop，虽然使用下面方法能够让其工作
//    dispatch_async(dispatch_queue_create(0, 0), ^{
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
//        [[NSRunLoop currentRunLoop] run];
//    });
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    if ([[ControlRunLoopTool sharedTool] useRunLoop]) {
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

/// 时间减一秒方法
- (void)updateTimer {
    
    // 减一秒
    self.second--;
    // 判断秒数
    if (self.second == -1) {
        self.second = 59;
        self.minute--;
    }
    // 判断分钟数
    if (self.minute == -1) {
        self.minute = 59;
        self.hour--;
    }
    // 判断小时数
    if (self.hour == -1) {
        self.hour = 23;
        self.day--;
    }
    // 判断是否没时间了
    if (self.day == 0 && self.hour == 0 && self.minute == 0 && self.second == 0) {
        [self.timer invalidate];
    }
    // 更新值
    [self updateText];
    
    NSLog(@"%s, %@", __func__, [[NSRunLoop currentRunLoop] currentMode]);
}

- (void)updateText {
    
    self.text = [NSString stringWithFormat:@"倒计时：%02zd 天 %02zd:%02zd:%02zd", self.day, self.hour, self.minute, self.second];
}

// best solution
- (void)removeFromSuperview {
    
    [super removeFromSuperview];
    [self.timer invalidate];
}

// this solution don't work....
// - (void)dealloc {
//    
//     [self.timer invalidate];
// }

@end
