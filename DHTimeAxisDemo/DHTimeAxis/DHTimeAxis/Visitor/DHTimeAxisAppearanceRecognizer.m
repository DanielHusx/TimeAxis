//  DHTimeAxisAppearanceRecognizer.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisAppearanceRecognizer.h"
#import "DHTimeAxisData.h"
#import "DHTimeAxisRule.h"
#import "DHTimeAxisDigitalDivision.h"
#import "DHTimeAxisBaseLine.h"
#import "DHTimeAxisBackground.h"

/// 整个视图的宽度
@interface DHTimeAxisAppearanceRecognizer()

@property (nonatomic, strong) DHTimeAxisAppearance *appearance;

@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, assign) CGFloat viewHeight;
@end

@implementation DHTimeAxisAppearanceRecognizer
- (instancetype)initWithViewSize:(CGSize)viewSize {
    if (self = [super init]) {
        [self setViewSize:viewSize];
    }
    return self;
}
- (instancetype)initWithViewSize:(CGSize)viewSize appearance:(DHTimeAxisAppearance *)appearance {
    if (self = [self initWithViewSize:viewSize]) {
        [self setAppearance:appearance];
        
        self.viewWidth = viewSize.width;
        self.viewHeight = viewSize.height;
//        self.width = (appearance.direction == DHAxisDirectionVertical)?self.viewSize.height:self.viewSize.width;
//        self.height = (appearance.direction == DHAxisDirectionVertical)?self.viewSize.width:self.viewSize.height;
    }
    return self;
}


- (void)visitTimeAxis:(id<DHTimeAxisComponent>)aTimeAxis {
    // 啥也不干
}
- (void)visitTimeAxisData:(DHTimeAxisData *)aTimeAxisData {
    aTimeAxisData.strokeColor = self.appearance.dataStrokeColor;
    switch (self.appearance.dataStrokeSizeType) {
        case DHStrokeSizeTypeFull:
            aTimeAxisData.strokeSize = self.appearance.direction == DHAxisDirectionHorizontal ? self.viewHeight : self.viewWidth;
            break;
        case DHStrokeSizeTypeHalf:
            aTimeAxisData.strokeSize = (self.appearance.direction == DHAxisDirectionHorizontal ? self.viewHeight : self.viewWidth) / 2.0;
            break;
        default:
            aTimeAxisData.strokeSize = self.appearance.dataStrokeSize;
            break;
    }
}
- (void)visitTimeAxisRule:(DHTimeAxisRule *)aTimeAxisRule {
    aTimeAxisRule.axisDirection = (NSUInteger)self.appearance.direction;
    aTimeAxisRule.strokeColor = self.appearance.ruleColor;
    aTimeAxisRule.strokeSize = self.appearance.ruleStrokeSize;
    switch (self.appearance.ruleOffsetLocationType) {
        case DHStrokeLocationTypeFlexible:
            break;
        case DHStrokeLocationTypeMiddle:
            self.appearance.ruleFixedOffset = (self.appearance.direction == DHAxisDirectionHorizontal ? self.viewWidth : self.viewHeight) / 2.0;
            break;
        case DHStrokeLocationTypeMaximum:
            self.appearance.ruleFixedOffset = self.appearance.direction == DHAxisDirectionHorizontal ? self.viewWidth : self.viewHeight;
            break;
        case DHStrokeLocationTypeMinimum:
            self.appearance.ruleFixedOffset = 0.0;
            break;
        default:
            break;
    }
    aTimeAxisRule.fixedOffset = self.appearance.ruleFixedOffset;
    
}
- (void)visitTimeAxisBaseLine:(DHTimeAxisBaseLine *)aTimeAxisBaseLine {
    aTimeAxisBaseLine.strokeColor = self.appearance.baseLineColor;
    aTimeAxisBaseLine.strokeSize = self.appearance.baseLineStrokeSize;
    switch (self.appearance.baseLineOffsetLocationType) {
        case DHStrokeLocationTypeFlexible:
            break;
        case DHStrokeLocationTypeMiddle:
            self.appearance.baseLineFixedOffset = (self.appearance.direction == DHAxisDirectionHorizontal ? self.viewHeight : self.viewWidth)/2.0;
            break;
        case DHStrokeLocationTypeMaximum:
            self.appearance.baseLineFixedOffset = self.appearance.direction == DHAxisDirectionHorizontal ? self.viewHeight : self.viewWidth;
            break;
        case DHStrokeLocationTypeMinimum:
            self.appearance.baseLineFixedOffset = 0.0;
            break;
        default:
            break;
    }
    aTimeAxisBaseLine.fixedOffset = self.appearance.baseLineFixedOffset;
}
- (void)visitTimeAxisDigitalDivision:(DHTimeAxisDigitalDivision *)aTimeAxisDigitalDivision {
    aTimeAxisDigitalDivision.strokeColor = self.appearance.divisionColor;
    aTimeAxisDigitalDivision.strokeSize = self.appearance.divisionStrokeSize;
    aTimeAxisDigitalDivision.digitalAttribute = self.appearance.digitalAttribute;
    aTimeAxisDigitalDivision.minimumScale = self.appearance.minimumScale;
    aTimeAxisDigitalDivision.maximumScale = self.appearance.maximumScale;
    aTimeAxisDigitalDivision.oneToOneScaleMatchMaxHoursInVisible = self.appearance.oneToOneScaleMatchMaxHoursInVisible;
    
}
- (void)visitTimeAxisBackground:(DHTimeAxisBackground *)aTimeAxisBackground {
    aTimeAxisBackground.strokeColor = self.appearance.backgroundColor;
    switch (self.appearance.backgroundStrokeSizeType) {
        case DHStrokeSizeTypeFull:
            aTimeAxisBackground.strokeSize = self.appearance.direction == DHAxisDirectionHorizontal ? self.viewHeight : self.viewWidth;
            break;
        case DHStrokeSizeTypeHalf:
            aTimeAxisBackground.strokeSize = (self.appearance.direction == DHAxisDirectionHorizontal ? self.viewHeight : self.viewWidth) / 2.0;
            break;
        default:
            aTimeAxisBackground.strokeSize = self.appearance.backgroundStrokeSize;
            break;
    }
}
- (DHTimeAxisAppearance *)appearance {
    if (!_appearance) {
        _appearance = [DHTimeAxisAppearance sharedAppearance];
    }
    return _appearance;
}
@end

