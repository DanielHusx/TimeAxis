//  DHTimeAxisAppearance+Renderer.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisAppearance.h"
#import "DHTimeAxisRenderer.h"

NS_ASSUME_NONNULL_BEGIN

@interface DHTimeAxisAppearance (Renderer)

+ (void)renderRuleAppearanceWithDirection:(DHAxisDirection)direction;
+ (void)renderGearAppearanceWithDirection:(DHAxisDirection)direction;

@end

NS_ASSUME_NONNULL_END
