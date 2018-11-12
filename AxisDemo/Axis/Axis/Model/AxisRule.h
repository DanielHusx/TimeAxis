//  AxisRule.h
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "Axis.h"

NS_ASSUME_NONNULL_BEGIN

/**
 刻度尺
 */
@interface AxisRule : NSObject <Axis>

@property (nonatomic, assign) AxisDirection axisDirection;
/// 刻度尺在视图中的固定偏移位置
@property (nonatomic, assign) CGFloat fixedOffset;

@property (nonatomic, assign) NSTimeInterval currentTimeInterval;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

/// 当前时间的整时
@property (nonatomic, readonly, strong) NSDate *currentHourDate;
@property (nonatomic, readonly, assign) NSInteger currentHour;

- (void)acceptVisitor:(id<AxisVisitor>)visitor;

- (NSInteger)fetchCurrentTimeValueWithUnit:(NSCalendarUnit)unit;
@end
NS_ASSUME_NONNULL_END
