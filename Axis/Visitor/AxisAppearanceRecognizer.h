//  AxisAppearanceRecognizer.h
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "AxisVisitor.h"
#import "AxisAppearance.h"

NS_ASSUME_NONNULL_BEGIN

/**
 获取默认数据
 */
@interface AxisAppearanceRecognizer : NSObject <AxisVisitor>

@property (nonatomic, assign) CGSize viewSize;

- (instancetype)initWithViewSize:(CGSize)viewSize appearance:(AxisAppearance *)appearance;

- (void)visitAxis:(id<Axis>)aAxis;
- (void)visitAxisData:(AxisData *)aAxisData;
- (void)visitAxisRule:(AxisRule *)aAxisRule;
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine;
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision;
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground;
@end

NS_ASSUME_NONNULL_END
