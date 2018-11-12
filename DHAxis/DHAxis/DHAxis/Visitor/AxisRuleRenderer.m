//  AxisRuleRenderer.m
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisRuleRenderer.h"

@implementation AxisRuleRenderer
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
    if (self.axisDirection == AxisDirectionHorizontal) {
        [self drawLineWithContext:self.context from:CGPointMake((aAxisData.startTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aAxisData.strokeSize/2.0) to:CGPointMake((aAxisData.endTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aAxisData.strokeSize/2.0)];
        //    CGContextMoveToPoint(self.context, (aAxisData.startTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aAxisData.strokeSize/2.0);
        //    CGContextAddLineToPoint(self.context, (aAxisData.endTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel, aAxisData.strokeSize/2.0);
        //    CGContextStrokePath(self.context);
    } else {
        [self drawLineWithContext:self.context from:CGPointMake((self.width-aAxisData.strokeSize)/2.0, (aAxisData.startTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel) to:CGPointMake((self.width+aAxisData.strokeSize)/2.0, (aAxisData.endTimeInterval - self.minTimeInVisible) * self.aSecondOfPixel)];
    }
    
}
/// 绘制时间轴每段
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision {
    
    [super visitAxisDigitalDivision:aAxisDigitalDivision];
    
    if (self.axisDirection == AxisDirectionHorizontal) {
        // 计算每秒代表的像素宽度
        CGFloat aSecondWidth = self.aSecondOfPixel;
        CGFloat aHourWidth = aSecondWidth * 3600.0;
        CGFloat ruleOffset = self.ruleFixedOffset;
        CGFloat baseLineOffset = self.baseLineFixedOffset;
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
            [time drawInRect:CGRectMake(point.x-13, baseLineOffset+5, 40, 20) withAttributes:aAxisDigitalDivision.digitalAttribute];
            
            // 大刻度线(小时)
            CGContextMoveToPoint(self.context, point.x-.5, baseLineOffset);
            CGContextAddLineToPoint(self.context, point.x-.5, baseLineOffset-20.0);
            CGContextStrokePath(self.context);
            
            // 小刻度线(10分钟)
            NSInteger piece = 12;
            for (int i = 1; i < piece; i++) {
                CGPoint point = CGPointMake(aHourWidth/piece*i+tempHourPosition, 20);
                CGContextMoveToPoint(self.context, point.x-.5, baseLineOffset);
                CGContextAddLineToPoint(self.context, point.x-.5, baseLineOffset-10.0);
                CGContextStrokePath(self.context);
            }
            
            tempHourPosition += aHourWidth;
            tempHour++;
        }
    } else {
        // 计算每秒代表的像素宽度
        CGFloat aSecondWidth = self.aSecondOfPixel;
        CGFloat aHourWidth = aSecondWidth * 3600.0;
        CGFloat ruleOffset = self.ruleFixedOffset;
        CGFloat baseLineOffset = self.baseLineFixedOffset;
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
        while ((tempX += aHourWidth) < self.height) {
            count++;
        }
        CGFloat rightHourPosition = ruleOffset + (diffTime+60*60*count) * aSecondWidth;
        
        // 开始画刻度
        CGFloat tempHourPosition = leftHourPosition;
        NSInteger tempHour = leftHour;
        
        
        while (tempHourPosition <= rightHourPosition) {
            
            CGPoint point = CGPointMake(baseLineOffset, tempHourPosition);
            // 文字显示
            NSString *time = [NSString stringWithFormat:@"%02ld:00",tempHour > 23 ? tempHour-24 : (tempHour < 0 ? tempHour + 24: tempHour)];
            [time drawInRect:CGRectMake(point.x-50, point.y-10, 40, 20) withAttributes:aAxisDigitalDivision.digitalAttribute];
            
            // 大刻度线(小时)
            CGContextMoveToPoint(self.context, point.x, point.y);
            CGContextAddLineToPoint(self.context, point.x+20.0, point.y);
            CGContextStrokePath(self.context);
            
            // 小刻度线(10分钟)
            NSInteger piece = 12;
            for (int i = 1; i < piece; i++) {
                CGPoint mPoint = CGPointMake(baseLineOffset, aHourWidth/piece*i+tempHourPosition);
                CGContextMoveToPoint(self.context, mPoint.x, mPoint.y);
                CGContextAddLineToPoint(self.context, mPoint.x+10.0, mPoint.y);
                CGContextStrokePath(self.context);
            }
            
            tempHourPosition += aHourWidth;
            tempHour++;
        }
    }
}


/// 绘制刻度线
- (void)visitAxisRule:(AxisRule *)aAxisRule {
    [super visitAxisRule:aAxisRule];
    if (self.axisDirection == AxisDirectionHorizontal) {
        [self drawLineWithContext:self.context from:CGPointMake(aAxisRule.fixedOffset, 0) to:CGPointMake(aAxisRule.fixedOffset, self.height)];
    } else {
        [self drawLineWithContext:self.context from:CGPointMake(0, aAxisRule.fixedOffset) to:CGPointMake(self.width, aAxisRule.fixedOffset)];
    }
    
}
/// 绘制基线
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine {
    [super visitAxisBaseLine:aAxisBaseLine];
    
    if (self.axisDirection == AxisDirectionHorizontal) {
        [self drawLineWithContext:self.context from:CGPointMake(0, aAxisBaseLine.fixedOffset-aAxisBaseLine.strokeSize/2.0) to:CGPointMake(self.width, aAxisBaseLine.fixedOffset-aAxisBaseLine.strokeSize/2.0)];
    } else {
        [self drawLineWithContext:self.context from:CGPointMake(aAxisBaseLine.fixedOffset-aAxisBaseLine.strokeSize/2.0, 0) to:CGPointMake(aAxisBaseLine.fixedOffset-aAxisBaseLine.strokeSize/2.0, self.height)];
    }
}
/// 绘制背景
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground {
    
}
@end
