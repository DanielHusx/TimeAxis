//  DHTimeAxis+Appearance.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxis.h"

NS_ASSUME_NONNULL_BEGIN

@interface DHTimeAxis (Appearance)
/// 获取更新的皮肤组件
- (NSArray *)updateAppearanceArrayWithSize:(CGSize)size;
/// 给数据数组组装皮肤
- (void)updateAppearanceWithDataArray:(NSArray<DHTimeAxisData *> *)dataArray size:(CGSize)size;
/// 获取更新的渲染类
- (Class)updateAppearanceRenderer;
/// 获取更新的背景色
- (UIColor *)updateAppearanceMainBackgroundColor;
/// 基于外观 提供正确的偏移位置与视图宽度
- (void)uponAppearanceForUpdateCurrentTimeIntervalFromOffset:(CGPoint)offset viewSize:(CGSize)viewSize toOptimisticOffset:(CGFloat *)opOffset optimisticViewSize:(CGFloat *)opViewSize;
/// 注册Appearance通知
- (void)registeAppearanceNotification;
/// 销毁Appearance通知
- (void)resignAppearanceNotification;
@end

NS_ASSUME_NONNULL_END
