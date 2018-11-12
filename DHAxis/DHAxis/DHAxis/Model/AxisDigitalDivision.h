//  AxisDigitalDivision.h
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "Axis.h"
NS_ASSUME_NONNULL_BEGIN

/**
 刻度线、数字与分割线
 */
@interface AxisDigitalDivision : NSObject <Axis>
/// 当前比例，默认为1.0
@property (nonatomic, assign) CGFloat currentScale;
/// 最小比例
@property (nonatomic, assign) CGFloat minimumScale;
/// 最大比例，只能在内部更改
@property (nonatomic, assign) CGFloat maximumScale;
/// 1比1时 可见视图内最多的小时数；   倒数 乘以 可见视图尺寸 即 每小时对应的宽度 像素/小时
@property (nonatomic, assign) CGFloat oneToOneScaleMatchMaxHoursInVisible;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

@property (nonatomic, strong) NSDictionary *digitalAttribute;

- (void)acceptVisitor:(id<AxisVisitor>)visitor;

/**
 时间一秒所对应的像素  单位：点/秒
 
 @param width 水平时指高度，垂直时指高度
 @return 像素
 */
- (CGFloat)aSecondOfPixelWithViewWidth:(CGFloat)width;

/**
 优化比例，得到正确的比例
 
 @param scale 比例值
 */
- (void)updateToOptimisticScale:(CGFloat *)scale;
@end

NS_ASSUME_NONNULL_END
