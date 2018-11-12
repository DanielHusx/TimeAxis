//  AxisRenderer.m
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisRenderer.h"

@implementation AxisRenderer
- (instancetype)initWithViewSize:(CGSize)viewSize {
    if (self = [super init]) {
        [self setViewSize:viewSize];
    }
    return self;
}
- (instancetype)initWithViewSize:(CGSize)viewSize context:(CGContextRef)context {
    if (self = [self initWithViewSize:viewSize]) {
        [self setContext:context];
        self.width = viewSize.width;
        self.height = viewSize.height;
    }
    return self;
}
#pragma mark - update values method
- (void)updateValueWithWithAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision {
    CGFloat width = _axisDirection == AxisDirectionHorizontal ? self.width : self.height;
    _aSecondOfPixel = [aAxisDigitalDivision aSecondOfPixelWithViewWidth:width];
    
    // 可见最小时间 = 当前时间(s) - 刻度线偏移位置(像素)/每秒对应的宽度(像素/s)
    _minTimeInVisible = _currentTimeInterval - _ruleFixedOffset/_aSecondOfPixel;
    // 可见最大时间 = 当前时间(s) + （可见视图宽度(像素) - 刻度线偏移位置(像素))/每秒对应的宽度(像素/s)
    _maxTimeInVisible = _currentTimeInterval + (width - _ruleFixedOffset)/_aSecondOfPixel;
    NSLog(@"最小时间: %.2f", _minTimeInVisible);
    NSLog(@"当前时间: %.2f", _currentTimeInterval);
    NSLog(@"最大时间: %.2f", _maxTimeInVisible);
}
- (void)updateValueWithAxisRule:(AxisRule *)aAxisRule {
    _currentTimeInterval = aAxisRule.currentTimeInterval;
    _ruleFixedOffset = aAxisRule.fixedOffset;
    _currentHourDate = aAxisRule.currentHourDate;
    _currentHour = aAxisRule.currentHour;
    _axisDirection = aAxisRule.axisDirection;
    
}

- (void)updateValueWithAxisBaseLine:(AxisBaseLine *)aAxisBaseLine {
    _baseLineFixedOffset = aAxisBaseLine.fixedOffset;
}
- (void)updateValueWithAxisBackground:(AxisBackground *)aAxisBackground {
    _backgroundSize = aAxisBackground.strokeSize;
}
#pragma mark - public method
- (void)visitAxis:(id<Axis>)aAxis {
    // 默认行为
    CGContextSetStrokeColorWithColor(_context, [aAxis.strokeColor CGColor]);
    CGContextSetLineWidth(_context, aAxis.strokeSize);
}

/// 绘制数据
- (void)visitAxisData:(AxisData *)aAxisData {
    // 设置色彩，宽度
    [self visitAxis:(id<Axis>)aAxisData];
}
/// 绘制时间轴每段
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision {
    // 更新值
    [self updateValueWithWithAxisDigitalDivision:aAxisDigitalDivision];
    
    // 设置色彩，宽度
    [self visitAxis:(id<Axis>)aAxisDigitalDivision];
}


/// 绘制刻度线
- (void)visitAxisRule:(AxisRule *)aAxisRule {
    // 更新值
    [self updateValueWithAxisRule:aAxisRule];
    // 设置色彩，宽度
    [self visitAxis:(id<Axis>)aAxisRule];
}
/// 绘制基线
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine {
    // 更新值
    [self updateValueWithAxisBaseLine:aAxisBaseLine];
    // 设置色彩，宽度
    [self visitAxis:(id<Axis>)aAxisBaseLine];
}
/// 绘制背景
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground {
    // 更新值
    [self updateValueWithAxisBackground:aAxisBackground];
    // 设置色彩，宽度
    [self visitAxis:(id<Axis>)aAxisBackground];
}

- (void)drawLineWithContext:(CGContextRef)context from:(CGPoint)from to:(CGPoint)to {
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    CGContextStrokePath(context);
}
@end
