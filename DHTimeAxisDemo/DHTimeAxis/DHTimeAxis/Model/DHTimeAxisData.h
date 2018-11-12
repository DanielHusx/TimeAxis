//  DHTimeAxisData.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "DHTimeAxisComponent.h"

NS_ASSUME_NONNULL_BEGIN
/**
 时间轴上的段数据
 */
@interface DHTimeAxisData : NSObject <DHTimeAxisComponent, NSCopying>

@property (nonatomic, assign) NSTimeInterval startTimeInterval;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, readonly, assign) NSTimeInterval endTimeInterval;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

@property (nonatomic, strong) id data;

- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor;

- (id)copyWithZone:(nullable NSZone *)zone;
@end

NS_ASSUME_NONNULL_END
