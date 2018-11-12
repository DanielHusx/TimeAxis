//  AxisVisitor.h
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol Axis;
@class AxisData, AxisRule, AxisBaseLine, AxisDigitalDivision, AxisBackground;
@protocol AxisVisitor <NSObject>

/// 通用绘制方法
- (void)visitAxis:(id<Axis>)aAxis;
/// 绘制数据
- (void)visitAxisData:(AxisData *)aAxisData;
/// 绘制刻度线
- (void)visitAxisRule:(AxisRule *)aAxisRule;
/// 绘制基线
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine;
/// 绘制数字与分割线
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision;
/// 绘制背景
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground;

@property (nonatomic, assign) CGSize viewSize;
/**
 初始化画布的宽度
 
 @param viewSize CGSize尺寸
 @return an intance which confirm protocol AxisVisitor
 */
- (instancetype)initWithViewSize:(CGSize)viewSize;

@end
