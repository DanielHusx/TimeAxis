//  AxisController+Appearance.h
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AxisController (Appearance)
/// 获取更新的皮肤组件
- (NSArray *)updateAppearanceArrayWithSize:(CGSize)size;
/// 给数据数组组装皮肤
- (void)updateAppearanceWithDataArray:(NSArray<AxisData *> *)dataArray size:(CGSize)size;
/// 获取更新的渲染类
- (Class)updateAppearanceRenderer;
/// 获取更新的背景色
- (UIColor *)updateAppearanceBackgroundColor;
/// 基于外观 提供正确的偏移位置与视图宽度
- (void)uponAppearanceForUpdateCurrentTimeIntervalFromOffset:(CGPoint)offset viewSize:(CGSize)viewSize toOptimisticOffset:(CGFloat *)opOffset optimisticViewSize:(CGFloat *)opViewSize;
@end

NS_ASSUME_NONNULL_END
