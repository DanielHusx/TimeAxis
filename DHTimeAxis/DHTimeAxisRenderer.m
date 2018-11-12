//  DHTimeAxisRenderer.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisRenderer.h"

@implementation DHTimeAxisRenderer
- (instancetype)initWithViewSize:(CGSize)viewSize {
    if (self = [super init]) {
        [self setViewSize:viewSize];
    }
    return self;
}
- (instancetype)initWithViewSize:(CGSize)viewSize context:(CGContextRef)context {
    if (self = [self initWithViewSize:viewSize]) {
        [self setContext:context];
        self.viewWidth = viewSize.width;
        self.viewHeight = viewSize.height;
    }
    return self;
}
#pragma mark - update values method
- (void)updateValueWithTimeAxisDigitalDivision:(DHTimeAxisDigitalDivision *)aTimeAxisDigitalDivision {
    CGFloat width = _axisDirection == DHTimeAxisDirectionHorizontal ? self.viewWidth : self.viewHeight;
    _aSecondOfPixel = [aTimeAxisDigitalDivision aSecondOfPixelWithViewWidth:width];
    
    // 可见最小时间 = 当前时间(s) - 刻度线偏移位置(像素)/每秒对应的宽度(像素/s)
    _minTimeInVisible = _currentTimeInterval - _ruleFixedOffset/_aSecondOfPixel;
    // 可见最大时间 = 当前时间(s) + （可见视图宽度(像素) - 刻度线偏移位置(像素))/每秒对应的宽度(像素/s)
    _maxTimeInVisible = _currentTimeInterval + (width - _ruleFixedOffset)/_aSecondOfPixel;
}
- (void)updateValueWithTimeAxisRule:(DHTimeAxisRule *)aTimeAxisRule {
    _currentTimeInterval = aTimeAxisRule.currentTimeInterval;
    _ruleFixedOffset = aTimeAxisRule.fixedOffset;
    _currentHourDate = aTimeAxisRule.currentHourDate;
    _currentHour = aTimeAxisRule.currentHour;
    _axisDirection = aTimeAxisRule.axisDirection;
    
}

- (void)updateValueWithTimeAxisBaseLine:(DHTimeAxisBaseLine *)aTimeAxisBaseLine {
    _baseLineFixedOffset = aTimeAxisBaseLine.fixedOffset;
}
- (void)updateValueWithTimeAxisBackground:(DHTimeAxisBackground *)aTimeAxisBackground {
    _backgroundSize = aTimeAxisBackground.strokeSize;
}
#pragma mark - public method
- (void)visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxis {
    // 默认行为
    CGContextSetStrokeColorWithColor(_context, [aTimeAxis.strokeColor CGColor]);
    CGContextSetLineWidth(_context, aTimeAxis.strokeSize);
}

/// 绘制数据
- (void)visitTimeAxisData:(DHTimeAxisData *)aTimeAxisData {
    // 设置色彩，宽度
    [self visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxisData];
}
/// 绘制时间轴每段
- (void)visitTimeAxisDigitalDivision:(DHTimeAxisDigitalDivision *)aTimeAxisDigitalDivision {
    // 更新值
    [self updateValueWithTimeAxisDigitalDivision:aTimeAxisDigitalDivision];
    
    // 设置色彩，宽度
    [self visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxisDigitalDivision];
}


/// 绘制刻度线
- (void)visitTimeAxisRule:(DHTimeAxisRule *)aTimeAxisRule {
    // 更新值
    [self updateValueWithTimeAxisRule:aTimeAxisRule];
    // 设置色彩，宽度
    [self visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxisRule];
}
/// 绘制基线
- (void)visitTimeAxisBaseLine:(DHTimeAxisBaseLine *)aTimeAxisBaseLine {
    // 更新值
    [self updateValueWithTimeAxisBaseLine:aTimeAxisBaseLine];
    // 设置色彩，宽度
    [self visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxisBaseLine];
}
/// 绘制背景
- (void)visitTimeAxisBackground:(DHTimeAxisBackground *)aTimeAxisBackground {
    // 更新值
    [self updateValueWithTimeAxisBackground:aTimeAxisBackground];
    // 设置色彩，宽度
    [self visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxisBackground];
}

- (void)drawLineWithContext:(CGContextRef)context from:(CGPoint)from to:(CGPoint)to {
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
}
@end
