//  AxisController.h
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <UIKit/UIKit.h>
#import "AxisData.h"
#import "Axis.h"

@class AxisController;
@protocol AxisControllerDelegate <NSObject>
/// 更新当前时间
- (void)axis:(AxisController *)axis didChangedTimeInterval:(NSTimeInterval)currentTimeInterval;
/// 更新放缩比例
- (void)axis:(AxisController *)axis didChangedScale:(CGFloat)currentScale;
/// 停止的位置存在数据
- (void)axis:(AxisController *)axis didEndedAtDataSection:(AxisData *)aAxisData;
/// 开始滚动
- (void)axisDidBeginScrolling:(AxisController *)axis;
/// 结束滚动
- (void)axisDidEndScrolling:(AxisController *)axis;
/// 开始捏合手势
- (void)axisDidBeginPinching:(AxisController *)axis;
/// 结束捏合手势
- (void)axisDidEndPinching:(AxisController *)axis;
/**
 
 */
- (void)translationCurrentTimeIntervalFromOffset:(CGPoint)offset viewSize:(CGSize)viewSize toOptimisticOffset:(CGFloat *)opOffset optimisticViewSize:(CGFloat *)opViewSize;
@end


NS_ASSUME_NONNULL_BEGIN

@interface AxisController : UIView

@property (nonatomic, weak) id<AxisControllerDelegate> delegate;

@property (nonatomic, readonly, assign) NSTimeInterval currentTimeInterval;
@property (nonatomic, readonly, assign) CGFloat currentScale;

@property (nonatomic, readonly, assign, getter=isPaning) __block BOOL paning;
@property (nonatomic, readonly, assign, getter=isPinching) BOOL pinching;

/**
 更新外观
 */
- (void)updateAppearance;
/**
 外部驱动时间轴更新
 
 @param currentTimeInterval 当前时间刻度
 */
- (void)updateWithCurrentTimeInterval:(NSTimeInterval)currentTimeInterval;

/**
 更新时间段数据
 
 @param dataArray 段数据
 */
- (void)updateWithDataArray:(NSArray <AxisData *>*)dataArray;

/**
 手动停止滚动
 */
- (void)manuallyStopRolling;
@end

NS_ASSUME_NONNULL_END
