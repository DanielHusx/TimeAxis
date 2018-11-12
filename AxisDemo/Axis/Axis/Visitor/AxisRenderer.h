//  AxisRenderer.h
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "AxisVisitor.h"
#import "AxisData.h"
#import "AxisRule.h"
#import "AxisDigitalDivision.h"
#import "AxisBaseLine.h"
#import "AxisBackground.h"

NS_ASSUME_NONNULL_BEGIN

/**
 渲染绘制方法
 如需自定义绘制方法，需要实现此类所有的方法，最后只要更改AxisView.h的渲染Visitor的初始化即可
 */
@interface AxisRenderer : NSObject <AxisVisitor>

@property (nonatomic, assign) CGContextRef context;
@property (nonatomic, assign) CGSize viewSize;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

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
@property (nonatomic, assign) AxisDirection axisDirection;

#pragma mark - 用于更新以上变量值
- (void)updateValueWithAxisRule:(AxisRule *)aAxisRule;
- (void)updateValueWithAxisBaseLine:(AxisBaseLine *)aAxisBaseLine;
- (void)updateValueWithWithAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision;
- (void)updateValueWithAxisBackground:(AxisBackground *)aAxisBackground;

#pragma mark - 辅助方法
- (void)drawLineWithContext:(CGContextRef)context from:(CGPoint)from to:(CGPoint)to;


#pragma mark - AxisVisitor
- (void)visitAxis:(id<Axis>)aAxis;

#pragma mark  子类需要重写的方法 且调用super
- (void)visitAxisData:(AxisData *)aAxisData;
- (void)visitAxisRule:(AxisRule *)aAxisRule;
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine;
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision;
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground;
@end

NS_ASSUME_NONNULL_END
