//  AxisGearRenderer.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisGearRenderer.h"

@implementation AxisGearRenderer

#pragma mark - public method

/// 绘制数据
- (void)visitAxisData:(AxisData *)aAxisData {
    // 没有画刻度跳过
    if (![aAxisData isKindOfClass:[AxisData class]]) return ;
    
    // 不在可见区间内的时间段 跳过
    if (aAxisData.startTimeInterval > self.maxTimeInVisible
        || aAxisData.endTimeInterval < self.minTimeInVisible) {
        return ;
    }
    
    
    // 画数据线条
    [super visitAxisData:aAxisData];
    CGContextMoveToPoint(self.context, (aAxisData.startTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aAxisData.strokeSize/2.0);
    CGContextAddLineToPoint(self.context, (aAxisData.endTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aAxisData.strokeSize/2.0);
    CGContextStrokePath(self.context);
    
}
/// 绘制时间轴每段
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision {
    
    [super visitAxisDigitalDivision:aAxisDigitalDivision];
    
    // 计算每秒代表的像素宽度
    CGFloat aSecondWidth = self.aSecondOfPixel;
    CGFloat aHourWidth = aSecondWidth * 3600.0;
    CGFloat ruleOffset = self.ruleFixedOffset;
    NSDate *currentHourDate = self.currentHourDate;
    NSInteger currentHour = self.currentHour;
    // 计算当前时间的所在的整点小时时间的差值
    
    NSTimeInterval diffTime = [[NSDate dateWithTimeIntervalSince1970:self.currentTimeInterval] timeIntervalSinceDate:currentHourDate];// 当前时间距离正点的差值
    
    CGFloat tempX = ruleOffset - diffTime * aSecondWidth;
    
    // 计算最左边的小时数，一般要画到视图外多一个小时
    NSInteger count = 1;
    while ((tempX -= aHourWidth) > 0) {
        count++;
    }
    NSInteger leftHour = currentHour - count;
    CGFloat leftHourPosition = ruleOffset - (diffTime+60*60*count) * aSecondWidth;
    
    // 计算最右边的小时数，一般要画到视图外多一个小时
    count = 1;
    while ((tempX += aHourWidth) < self.width) {
        count++;
    }
    CGFloat rightHourPosition = ruleOffset + (diffTime+60*60*count) * aSecondWidth;
    
    // 开始画刻度
    CGFloat tempHourPosition = leftHourPosition;
    NSInteger tempHour = leftHour;
    
    while (tempHourPosition <= rightHourPosition) {
        
        CGPoint point = CGPointMake(tempHourPosition, 10);
        // 文字显示
        NSString *time = [NSString stringWithFormat:@"%02ld:00",tempHour > 23 ? tempHour-24 : (tempHour < 0 ? tempHour + 24: tempHour)];
        [time drawInRect:CGRectMake(point.x-13, point.y+self.height-30, 40, 20) withAttributes:aAxisDigitalDivision.digitalAttribute];
        
        // 大刻度线(小时)
        CGContextMoveToPoint(self.context, point.x-.5, point.y);
        CGContextAddLineToPoint(self.context, point.x-.5, point.y+self.height-30);
        CGContextStrokePath(self.context);
        
        // 小刻度线(10分钟)
        NSInteger piece = 6;
        for (int i = 1; i < piece; i++) {
            CGPoint point = CGPointMake(aHourWidth/piece*i+tempHourPosition, 20);
            CGContextMoveToPoint(self.context, point.x-.5, point.y);
            CGContextAddLineToPoint(self.context, point.x-.5, point.y+self.height-50);
            CGContextStrokePath(self.context);
        }
        
        tempHourPosition += aHourWidth;
        tempHour++;
    }
    
    
}


/// 绘制刻度线
- (void)visitAxisRule:(AxisRule *)aAxisRule {
    [super visitAxisRule:aAxisRule];
    
    CGContextMoveToPoint(self.context, aAxisRule.fixedOffset, 0);
    CGContextAddLineToPoint(self.context, aAxisRule.fixedOffset, self.height);
    CGContextStrokePath(self.context);
    
}
/// 绘制基线
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine {
    
}
/// 绘制背景
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground {
    
}
@end
