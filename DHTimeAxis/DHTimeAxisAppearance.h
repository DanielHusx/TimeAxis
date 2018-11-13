//  DHTimeAxisAppearance.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DHAxisDirection) {
    DHAxisDirectionHorizontal,  // 水平
    DHAxisDirectionVertical,    // 垂直
};

typedef NS_ENUM(NSUInteger, DHStrokeLocationType) {
    DHStrokeLocationTypeFlexible,   // 自行设置的值生效
    DHStrokeLocationTypeMiddle,     // 中间位置
    DHStrokeLocationTypeMinimum,    // 最小位置，一般是对应为0.0的位置
    DHStrokeLocationTypeMaximum,    // 最大位置
};
typedef NS_ENUM(NSUInteger, DHStrokeSizeType) {
    DHStrokeSizeTypeFlexible,   // 自行设置的值生效
    DHStrokeSizeTypeFull,       // 全部
    DHStrokeSizeTypeHalf,       // 一半
};

NS_ASSUME_NONNULL_BEGIN
/**
 外观管理器
 */
@interface DHTimeAxisAppearance : NSObject

+ (instancetype)sharedAppearance;
/// 渲染Class，必须是DHTimeAxisRenderer子类
@property (nonatomic, assign) Class rendererClass;
/// 方向
@property (nonatomic, assign) DHAxisDirection direction;
/// 主背景色，即对DHTimeAxisView的backgroundColor的设置
@property (nonatomic, strong) UIColor *mainBackgroundColor;

#pragma mark - 背景色设置，对应的DHTimeAxisBackground模型的设置
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, assign) CGFloat backgroundStrokeSize;
@property (nonatomic, assign) DHStrokeSizeType backgroundStrokeSizeType;

#pragma mark - 刻度尺设置，对应DHTimeAxisRule模型的设置
@property (nonatomic, strong) UIColor *ruleColor;
@property (nonatomic, assign) CGFloat ruleStrokeSize;
@property (nonatomic, assign) CGFloat ruleFixedOffset;
@property (nonatomic, assign) DHStrokeLocationType ruleOffsetLocationType;

#pragma mark - 数字、分割线的设置，对应DHTimeAxisDigitalDivision模型的设置
@property (nonatomic, strong) UIColor *divisionColor;
@property (nonatomic, assign) CGFloat divisionStrokeSize;
@property (nonatomic, strong) NSDictionary *digitalAttribute;
@property (nonatomic, assign) CGFloat minimumScale;
@property (nonatomic, assign) CGFloat maximumScale;
@property (nonatomic, assign) CGFloat oneToOneScaleMatchMaxHoursInVisible;

#pragma mark - 基线的设置，对应DHTimeAxisBaseLine模型的设置
@property (nonatomic, strong) UIColor *baseLineColor;
@property (nonatomic, assign) CGFloat baseLineStrokeSize;
@property (nonatomic, assign) CGFloat baseLineFixedOffset;
@property (nonatomic, assign) DHStrokeLocationType baseLineOffsetLocationType;

#pragma mark - 数据段的设置，对应DHTimeAxisData模型的设置
@property (nonatomic, strong) UIColor *dataStrokeColor;
@property (nonatomic, assign) CGFloat dataStrokeSize;
@property (nonatomic, assign) DHStrokeSizeType dataStrokeSizeType;

@end

NS_ASSUME_NONNULL_END
