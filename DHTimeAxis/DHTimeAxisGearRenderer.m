//  DHTimeAxisGearRenderer.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisGearRenderer.h"

@implementation DHTimeAxisGearRenderer
/// 绘制数据
- (void)visitTimeAxisData:(DHTimeAxisData *)aTimeAxisData {
    // 没有画刻度跳过
    if (![aTimeAxisData isKindOfClass:[DHTimeAxisData class]]) return ;
    
    // 不在可见区间内的时间段 跳过
    if (aTimeAxisData.startTimeInterval > self.maxTimeInVisible
        || aTimeAxisData.endTimeInterval < self.minTimeInVisible) {
        return ;
    }
    
    [super visitTimeAxisData:aTimeAxisData];
    // 画数据线条
    if (self.axisDirection == DHTimeAxisDirectionHorizontal) {
        [self drawLineWithContext:self.context from:CGPointMake((aTimeAxisData.startTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aTimeAxisData.strokeSize/2.0) to:CGPointMake((aTimeAxisData.endTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aTimeAxisData.strokeSize/2.0)];
    } else {
        [self drawLineWithContext:self.context from:CGPointMake(aTimeAxisData.strokeSize/2.0, (aTimeAxisData.startTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel) to:CGPointMake(aTimeAxisData.strokeSize/2.0, (aTimeAxisData.endTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel)];
    }
}
/// 绘制时间轴每段
- (void)visitTimeAxisDigitalDivision:(DHTimeAxisDigitalDivision *)aTimeAxisDigitalDivision {
    
    [super visitTimeAxisDigitalDivision:aTimeAxisDigitalDivision];
    
    // 计算每秒代表的像素宽度
    CGFloat aSecondWidth = self.aSecondOfPixel;
    CGFloat aHourWidth = aSecondWidth * 3600.0;
    CGFloat ruleOffset = self.ruleFixedOffset;
    NSDate *currentHourDate = self.currentHourDate;
    NSInteger currentHour = self.currentHour;
    CGFloat width = self.axisDirection == DHTimeAxisDirectionHorizontal ? self.viewWidth : self.viewHeight;
    
    // 计算当前时间的所在的整点小时时间的差值
    NSTimeInterval diffTime = [[NSDate dateWithTimeIntervalSince1970:self.currentTimeInterval] timeIntervalSinceDate:currentHourDate];// 当前时间距离正点的差值
    
    CGFloat tempX = ruleOffset - diffTime * aSecondWidth;
    
    // 计算最左边的小时数，一般要画到视图外多一个小时
    NSInteger count = 1;
    while ((tempX -= aHourWidth) > 0) {
        count++;
    }
    NSInteger minHour = currentHour - count;
    CGFloat minHourPosition = ruleOffset - (diffTime+60*60*count) * aSecondWidth;
    
    // 计算最右边的小时数，一般要画到视图外多一个小时
    count = 1;
    while ((tempX += aHourWidth) < width) {
        count++;
    }
    CGFloat maxHourPosition = ruleOffset + (diffTime+60*60*count) * aSecondWidth;
    
    // 开始画刻度
    CGFloat tempHourPosition = minHourPosition;
    NSInteger tempHour = minHour;
    
    while (tempHourPosition <= maxHourPosition) {
        if (self.axisDirection == DHTimeAxisDirectionHorizontal) {
            CGPoint point = CGPointMake(tempHourPosition, self.viewHeight);
            // 文字显示
            NSString *time = [NSString stringWithFormat:@"%02ld:00",tempHour > 23 ? tempHour-24 : (tempHour < 0 ? tempHour + 24: tempHour)];
            [time drawInRect:CGRectMake(point.x-13, point.y-30, 40, 20) withAttributes:aTimeAxisDigitalDivision.digitalAttribute];
            
            // 大刻度线(小时)
            CGContextMoveToPoint(self.context, point.x-.5, 40);
            CGContextAddLineToPoint(self.context, point.x-.5, point.y-40);
            CGContextStrokePath(self.context);
            
            // 小刻度线(10分钟)
            int piece = 6;
            for (int i = 1; i < piece; i++) {
                CGPoint point = CGPointMake(aHourWidth/piece*i+tempHourPosition, self.viewHeight);
                CGContextMoveToPoint(self.context, point.x-.5, 60);
                CGContextAddLineToPoint(self.context, point.x-.5, point.y - 60);
                CGContextStrokePath(self.context);
            }
        } else {
            CGPoint point = CGPointMake(self.viewWidth ,tempHourPosition);
            // 文字显示
            NSString *time = [NSString stringWithFormat:@"%02ld:00",tempHour > 23 ? tempHour-24 : (tempHour < 0 ? tempHour + 24: tempHour)];
            [time drawInRect:CGRectMake(10, point.y - 10, 40, 20) withAttributes:aTimeAxisDigitalDivision.digitalAttribute];
            
            // 大刻度线(小时)
            CGContextMoveToPoint(self.context, 60, point.y);
            CGContextAddLineToPoint(self.context, point.x-60, point.y);
            CGContextStrokePath(self.context);
            
            // 小刻度线(10分钟)
            int piece = 6;
            for (int i = 1; i < piece; i++) {
                CGPoint point = CGPointMake(self.viewWidth, aHourWidth/piece*i+tempHourPosition);
                CGContextMoveToPoint(self.context, 80, point.y);
                CGContextAddLineToPoint(self.context, point.x-80, point.y);
                CGContextStrokePath(self.context);
            }
        }
        tempHourPosition += aHourWidth;
        tempHour++;
    }
    
    
}


/// 绘制刻度线
- (void)visitTimeAxisRule:(DHTimeAxisRule *)aTimeAxisRule {
    [super visitTimeAxisRule:aTimeAxisRule];
    if (self.axisDirection == DHTimeAxisDirectionHorizontal) {
        [self drawLineWithContext:self.context from:CGPointMake(aTimeAxisRule.fixedOffset, 0) to:CGPointMake(aTimeAxisRule.fixedOffset, self.viewHeight)];
    } else {
        [self drawLineWithContext:self.context from:CGPointMake(0, aTimeAxisRule.fixedOffset) to:CGPointMake(self.viewWidth, aTimeAxisRule.fixedOffset)];
    }
    
}
/// 绘制基线
- (void)visitTimeAxisBaseLine:(DHTimeAxisBaseLine *)aTimeAxisBaseLine {
    
}
/// 绘制背景
- (void)visitTimeAxisBackground:(DHTimeAxisBackground *)aTimeAxisBackground {
    
}
@end
