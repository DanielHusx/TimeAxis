//  AxisBackground.h
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "Axis.h"

NS_ASSUME_NONNULL_BEGIN

/**
 背景
 */
@interface AxisBackground : NSObject <Axis>

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

- (void)acceptVisitor:(id<AxisVisitor>)visitor;

@end

NS_ASSUME_NONNULL_END