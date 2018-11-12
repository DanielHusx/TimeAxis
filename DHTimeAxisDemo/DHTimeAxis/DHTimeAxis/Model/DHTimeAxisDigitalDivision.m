//  DHTimeAxisDigitalDivision.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisDigitalDivision.h"

@implementation DHTimeAxisDigitalDivision
- (instancetype)init {
    if (self = [super init]) {
        _currentScale = 1.0;
    }
    return self;
}

- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor {
    [visitor visitTimeAxisDigitalDivision:self];
}
- (void)setCurrentScale:(CGFloat)currentScale {
    [self updateToOptimisticScale:&currentScale];
    _currentScale = currentScale;
}


- (CGFloat)aSecondOfPixelWithViewWidth:(CGFloat)width {
    return ((width/_oneToOneScaleMatchMaxHoursInVisible)*_currentScale)/3600.0;
}
- (void)updateToOptimisticScale:(CGFloat *)scale {
    if (*scale < _minimumScale) {
        *scale = _minimumScale;
    } else if (*scale > _maximumScale) {
        *scale = _maximumScale;
    }
}
@end
