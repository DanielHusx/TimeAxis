//  DHTimeAxisVisitor.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DHTimeAxisComponent;
@class DHTimeAxisData, DHTimeAxisRule, DHTimeAxisBaseLine, DHTimeAxisDigitalDivision, DHTimeAxisBackground;
@protocol DHTimeAxisVisitor <NSObject>

/// 通用绘制方法
- (void)visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxis;
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

@property (nonatomic, assign) CGSize viewSize;
/**
 初始化画布的宽度
 
 @param viewSize CGSize尺寸
 @return an intance which confirm protocol DHTimeAxisVisitor
 */
- (instancetype)initWithViewSize:(CGSize)viewSize;
@end


