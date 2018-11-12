//  DHTimeAxisRuleRenderer.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisRenderer.h"

NS_ASSUME_NONNULL_BEGIN

@interface DHTimeAxisRuleRenderer : DHTimeAxisRenderer
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
