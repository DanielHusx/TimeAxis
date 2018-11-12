//  Axis.h
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AxisVisitor.h"

typedef NS_ENUM(NSUInteger, AxisDirection) {
    AxisDirectionHorizontal,
    AxisDirectionVertical,
};

@protocol Axis <NSObject>
@optional
/// 最小比例
@property (nonatomic, assign) CGFloat minimumScale;
/// 最大比例
@property (nonatomic, assign) CGFloat maximumScale;
/// 当前放大比例
@property (nonatomic, assign) CGFloat currentScale;

/// 当前时间戳
@property (nonatomic, assign) NSTimeInterval currentTimeInterval;
/// 开始时间戳
@property (nonatomic, assign) NSTimeInterval startTimeInterval;
/// 结束时间戳
@property (nonatomic, readonly, assign) NSTimeInterval endTimeInterval;
/// 时长
@property (nonatomic, assign) NSTimeInterval duration;


/// 绘制的画笔颜色
@property (nonatomic, strong) UIColor *strokeColor;
/// 绘制的线条粗细
@property (nonatomic, assign) CGFloat strokeSize;
/// 方向
@property (nonatomic, assign) AxisDirection axisDirection;

/// 额外附带数据
@property (nonatomic, strong) id data;


/**
 访问者 响应方法
 
 @param visitor id<AxisVisitor>访问者
 */
- (void)acceptVisitor:(id<AxisVisitor>)visitor;


@end
