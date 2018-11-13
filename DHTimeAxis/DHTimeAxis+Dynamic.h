//  DHTimeAxis+Dynamic.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxis.h"


/**
 物理引擎模拟减速效果分类
 */
@interface DHTimeAxis (Dynamic)
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIDynamicItemBehavior *inertialBehavior;
/// 手动停止滚动减速
- (void)manuallyStopRollingWithDeceleratingExtraUpdate:(void(^)(void))extraUpdate;
/// 模拟减速动画
- (void)deceleratingAnimateWithVelocityPoint:(CGPoint)velocityPoint action:(void(^)(CGPoint deceleratingSpeedPoint, BOOL stop))action;
@end


