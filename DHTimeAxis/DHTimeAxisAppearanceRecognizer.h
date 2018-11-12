//  DHTimeAxisAppearanceRecognizer.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "DHTimeAxisVisitor.h"
#import "DHTimeAxisAppearance.h"

NS_ASSUME_NONNULL_BEGIN
/**
 获取设置数据
 */
@interface DHTimeAxisAppearanceRecognizer : NSObject <DHTimeAxisVisitor>
@property (nonatomic, assign) CGSize viewSize;

- (instancetype)initWithViewSize:(CGSize)viewSize appearance:(DHTimeAxisAppearance *)appearance;

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
@end

NS_ASSUME_NONNULL_END
