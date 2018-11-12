//  AxisRuleRenderer.h
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisRenderer.h"

NS_ASSUME_NONNULL_BEGIN

@interface AxisRuleRenderer : AxisRenderer

- (void)visitAxisData:(AxisData *)aAxisData;
- (void)visitAxisRule:(AxisRule *)aAxisRule;
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine;
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision;
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground;
@end

NS_ASSUME_NONNULL_END
