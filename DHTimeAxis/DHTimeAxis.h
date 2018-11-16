//  DHTimeAxis.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DHTimeAxisData.h"
#import "DHTimeAxisAppearance+Renderer.h"
#import "DHTimeAxisAppearance.h"

@class DHTimeAxis;
@protocol DHTimeAxisDelegate <NSObject>
@optional
/// 更新当前时间
- (void)timeAxis:(DHTimeAxis *)timeAxis didChangedTimeInterval:(NSTimeInterval)currentTimeInterval;
/// 更新放缩比例
- (void)timeAxis:(DHTimeAxis *)timeAxis didChangedScale:(CGFloat)currentScale;
/// 停止的位置存在数据
- (void)timeAxis:(DHTimeAxis *)timeAxis didEndedAtDataSection:(DHTimeAxisData *)aAxisData;
/// 开始滚动
- (void)timeAxisDidBeginScrolling:(DHTimeAxis *)timeAxis;
/// 结束滚动
- (void)timeAxisDidEndScrolling:(DHTimeAxis *)timeAxis;
/// 开始捏合手势
- (void)timeAxisDidBeginPinching:(DHTimeAxis *)timeAxis;
/// 结束捏合手势
- (void)timeAxisDidEndPinching:(DHTimeAxis *)timeAxis;
/**
 外部提供偏移当前时间参数 的计算方法
 @param offset 手势造成的偏移
 @param viewSize 视图长宽
 @param opOffset 计算后的偏移值
 @param opViewSize 计算后的尺寸
 */
- (void)translationCurrentTimeIntervalFromOffset:(CGPoint)offset viewSize:(CGSize)viewSize toOptimisticOffset:(CGFloat *)opOffset optimisticViewSize:(CGFloat *)opViewSize;
@end


NS_ASSUME_NONNULL_BEGIN

@interface DHTimeAxis : UIControl

@property (nonatomic, weak) id<DHTimeAxisDelegate> delegate;

@property (nonatomic, readonly, assign) NSTimeInterval currentTimeInterval;
@property (nonatomic, readonly, assign) CGFloat currentScale;

@property (nonatomic, readonly, assign, getter=isPaning) __block BOOL paning;
@property (nonatomic, readonly, assign, getter=isPinching) BOOL pinching;

/**
 外部驱动时间轴更新
 
 @param currentTimeInterval 当前时间刻度
 */
- (void)updateWithCurrentTimeInterval:(NSTimeInterval)currentTimeInterval;

/**
 更新时间段数据
 
 @param dataArray 段数据
 */
- (void)updateWithDataArray:(NSArray <DHTimeAxisData *>*)dataArray;

/**
 手动停止滚动
 */
- (void)manuallyStopRolling;
@end

NS_ASSUME_NONNULL_END
