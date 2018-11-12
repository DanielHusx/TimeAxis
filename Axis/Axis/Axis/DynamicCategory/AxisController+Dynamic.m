//  AxisController+Dynamic.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisController+Dynamic.h"
#import <objc/runtime.h>
#import "AxisDynamicItem.h"
@implementation AxisController (Dynamic)
- (void)manuallyStopRollingWithDecelerating {
    if (self.inertialBehavior != nil) {
        if (self.animator == nil) {
            self.animator = [[UIDynamicAnimator alloc] init];
        }
        [self.animator removeBehavior:self.inertialBehavior];
        self.inertialBehavior = nil;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 停止整个滚动
    [self manuallyStopRolling];
}
- (void)deceleratingAnimateWithVelocityPoint:(CGPoint)velocityPoint action:(void(^)(CGPoint deceleratingSpeedPoint, BOOL stop))action {
    if (self.animator == nil) {
        self.animator = [[UIDynamicAnimator alloc] init];
    }
    if (self.inertialBehavior != nil) {
        [self.animator removeBehavior:self.inertialBehavior];
    }
    // velocity是在手势结束的时候获取的水平方向的手势速度
    AxisDynamicItem *item = [[AxisDynamicItem alloc] init];
    item.center = CGPointMake(0, 0);
    UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[item]];
    
    [inertialBehavior addLinearVelocity:velocityPoint forItem:item];
    // 阻尼，衰减系数
    inertialBehavior.resistance = 2.0;
    
    __weak typeof(self) weakself = self;
    inertialBehavior.action = ^{
        
        CGFloat speedX = [weakself.inertialBehavior linearVelocityForItem:item].x;
        CGFloat speedY = [weakself.inertialBehavior linearVelocityForItem:item].y;
        
        if ((speedX >= -0.2 && speedX <= 0.2) && (speedY >= -0.2 && speedY <= 0.2)) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                action(CGPointMake(speedX, speedY), YES);
            });
            // 停止行为
            [weakself.animator removeBehavior:weakself.inertialBehavior];
            weakself.inertialBehavior = nil;
            
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                action(CGPointMake(speedX, speedY), NO);
            });
        }
    };
    self.inertialBehavior = inertialBehavior;
    [self.animator addBehavior:inertialBehavior];
    
}

- (UIDynamicAnimator *)animator {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAnimator:(UIDynamicAnimator *)animator {
    objc_setAssociatedObject(self, @selector(animator), animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIDynamicItemBehavior *)inertialBehavior {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setInertialBehavior:(UIDynamicItemBehavior *)inertialBehavior {
    objc_setAssociatedObject(self, @selector(inertialBehavior), inertialBehavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
