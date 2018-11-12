//  AxisAppearanceRecognizer.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisAppearanceRecognizer.h"
#import "AxisData.h"
#import "AxisRule.h"
#import "AxisDigitalDivision.h"
#import "AxisBaseLine.h"
#import "AxisBackground.h"

@interface AxisAppearanceRecognizer ()
/// 整个视图的宽度
@property (nonatomic, strong) AxisAppearance *appearance;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end

@implementation AxisAppearanceRecognizer
- (instancetype)initWithViewSize:(CGSize)viewSize {
    if (self = [super init]) {
        [self setViewSize:viewSize];
    }
    return self;
}
- (instancetype)initWithViewSize:(CGSize)viewSize appearance:(AxisAppearance *)appearance {
    if (self = [self initWithViewSize:viewSize]) {
        [self setAppearance:appearance];
        
        self.width = (appearance.direction == DHAxisDirectionVertical)?self.viewSize.height:self.viewSize.width;
        self.height = (appearance.direction == DHAxisDirectionVertical)?self.viewSize.width:self.viewSize.height;
    }
    return self;
}


- (void)visitAxis:(id<Axis>)aAxis {
    // 啥也不干
}
- (void)visitAxisData:(AxisData *)aAxisData {
    aAxisData.strokeColor = self.appearance.dataStrokeColor;
    switch (self.appearance.dataStrokeSizeType) {
        case DHStrokeSizeTypeFull:
            aAxisData.strokeSize = self.height;
            break;
        case DHStrokeSizeTypeHalf:
            aAxisData.strokeSize = self.height / 2.0;
            break;
        default:
            break;
    }
}
- (void)visitAxisRule:(AxisRule *)aAxisRule {
    aAxisRule.axisDirection = (NSUInteger)self.appearance.direction;
    aAxisRule.strokeColor = self.appearance.ruleColor;
    aAxisRule.strokeSize = self.appearance.ruleStrokeSize;
    switch (self.appearance.ruleOffsetLocationType) {
        case DHStrokeLocationTypeFlexible:
            break;
        case DHStrokeLocationTypeMiddle:
            self.appearance.ruleFixedOffset = self.width/2.0;
            break;
        case DHStrokeLocationTypeMaximum:
            self.appearance.ruleFixedOffset = self.width;
            break;
        case DHStrokeLocationTypeMinimum:
            self.appearance.ruleFixedOffset = 0.0;
            break;
        default:
            break;
    }
    aAxisRule.fixedOffset = self.appearance.ruleFixedOffset;
    
}
- (void)visitAxisBaseLine:(AxisBaseLine *)aAxisBaseLine {
    aAxisBaseLine.strokeColor = self.appearance.baseLineColor;
    aAxisBaseLine.strokeSize = self.appearance.baseLineStrokeSize;
    switch (self.appearance.baseLineOffsetLocationType) {
        case DHStrokeLocationTypeFlexible:
            break;
        case DHStrokeLocationTypeMiddle:
            self.appearance.baseLineFixedOffset = self.height/2.0;
            break;
        case DHStrokeLocationTypeMaximum:
            self.appearance.baseLineFixedOffset = self.height;
            break;
        case DHStrokeLocationTypeMinimum:
            self.appearance.baseLineFixedOffset = 0.0;
            break;
        default:
            break;
    }
    aAxisBaseLine.fixedOffset = self.appearance.baseLineFixedOffset;
}
- (void)visitAxisDigitalDivision:(AxisDigitalDivision *)aAxisDigitalDivision {
    aAxisDigitalDivision.strokeColor = self.appearance.divisionColor;
    aAxisDigitalDivision.strokeSize = self.appearance.divisionStrokeSize;
    aAxisDigitalDivision.digitalAttribute = self.appearance.digitalAttribute;
    aAxisDigitalDivision.minimumScale = self.appearance.minimumScale;
    aAxisDigitalDivision.maximumScale = self.appearance.maximumScale;
    aAxisDigitalDivision.oneToOneScaleMatchMaxHoursInVisible = self.appearance.oneToOneScaleMatchMaxHoursInVisible;
    
}
- (void)visitAxisBackground:(AxisBackground *)aAxisBackground {
    aAxisBackground.strokeColor = self.appearance.backgroundColor;
    switch (self.appearance.backgroundStrokeSizeType) {
        case DHStrokeSizeTypeFull:
            aAxisBackground.strokeSize = self.height;
            break;
        case DHStrokeSizeTypeHalf:
            aAxisBackground.strokeSize = self.height / 2.0;
            break;
        default:
            break;
    }
}
- (AxisAppearance *)appearance {
    if (!_appearance) {
        _appearance = [AxisAppearance sharedAppearance];
    }
    return _appearance;
}
@end
