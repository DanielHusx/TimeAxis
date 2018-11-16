//  DHTimeAxisRenderer.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "DHTimeAxisVisitor.h"
#import "DHTimeAxisData.h"
#import "DHTimeAxisRule.h"
#import "DHTimeAxisDigitalDivision.h"
#import "DHTimeAxisBaseLine.h"
#import "DHTimeAxisBackground.h"
NS_ASSUME_NONNULL_BEGIN
/**
 渲染绘制方法
 如需自定义绘制方法，
 1. 继承实现此类所有visit方法
 2. 更改DHTimeAxisAppearance的渲染rendererClass为自定义类名即可
 */
@interface DHTimeAxisRenderer : NSObject <DHTimeAxisVisitor>
@property (nonatomic, assign) CGContextRef context;
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;

- (instancetype)initWithViewSize:(CGSize)viewSize context:(CGContextRef)context;


#pragma mark - 通过updateValue...方法更新的变量
@property (nonatomic, assign) NSTimeInterval minTimeInVisible;
@property (nonatomic, assign) NSTimeInterval maxTimeInVisible;

@property (nonatomic, strong) NSDate *currentHourDate;
@property (nonatomic, assign) NSInteger currentHour;
@property (nonatomic, assign) NSTimeInterval currentTimeInterval;

@property (nonatomic, assign) CGFloat ruleFixedOffset;
@property (nonatomic, assign) CGFloat baseLineFixedOffset;
@property (nonatomic, assign) CGFloat backgroundSize;

@property (nonatomic, assign) CGFloat aSecondOfPixel;
@property (nonatomic, assign) DHTimeAxisDirection axisDirection;

#pragma mark - 用于更新以上变量值
- (void)updateValueWithTimeAxisRule:(DHTimeAxisRule *)aTimeAxisRule;
- (void)updateValueWithTimeAxisBaseLine:(DHTimeAxisBaseLine *)aTimeAxisBaseLine;
- (void)updateValueWithTimeAxisDigitalDivision:(DHTimeAxisDigitalDivision *)aTimeAxisDigitalDivision;
- (void)updateValueWithTimeAxisBackground:(DHTimeAxisBackground *)aTimeAxisBackground;

#pragma mark - 辅助方法
- (void)drawLineWithContext:(CGContextRef)context from:(CGPoint)from to:(CGPoint)to;


#pragma mark - DHTimeAxisVisitor
/// 通用绘制方法
- (void)visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxis;

#pragma mark  子类需要重写的方法 且调用super
/// 绘制数据
- (void)visitTimeAxisData:(DHTimeAxisData *)aTimeAxisData;
/// 绘制刻度线
- (void)visitTimeAxisRule:(DHTimeAxisRule *)aTimeAxisRule;
/// 绘制基线
- (void)visitTimeAxisBaseLine:(DHTimeAxisBaseLine *)aTimeAxisBaseLine;
/// 绘制数字与分割线
- (void)visitTimeAxisDigitalDivision:(DHTimeAxisDigitalDivision *)aTimeAxisDigitalDivision;
/// 绘制背景
- (void)visitTimeAxisBackground:(DHTimeAxisBackground *)aTimeAxisBackground;

@end

NS_ASSUME_NONNULL_END
