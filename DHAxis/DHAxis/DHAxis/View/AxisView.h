//  AxisView.h
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <UIKit/UIKit.h>
#import "Axis.h"

NS_ASSUME_NONNULL_BEGIN

/**
 只负责画东西
 */
@interface AxisView : UIView

@property (nonatomic, strong) NSArray<id<Axis>> *appearanceArray;
@property (nonatomic, strong) NSArray<AxisData *> *dataArray;
/// 渲染类，默认为 AxisRenderer
@property (nonatomic, assign) Class rendererClass;
@end

NS_ASSUME_NONNULL_END
