//  AxisController+Appearance.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisController+Appearance.h"
#import "AxisAppearance.h"
#import "AxisRule.h"
#import "AxisDigitalDivision.h"
#import "AxisBaseLine.h"
#import "AxisBackground.h"
#import "AxisAppearanceRecognizer.h"

@implementation AxisController (Appearance)
- (NSArray *)updateAppearanceArrayWithSize:(CGSize)size {
    AxisAppearance *appearance = [AxisAppearance sharedAppearance];
    id <AxisVisitor> appearanceRecognizer = [[AxisAppearanceRecognizer alloc] initWithViewSize:size appearance:appearance];
    id<Axis> digital = (id<Axis>)[[AxisDigitalDivision alloc] init];
    id<Axis> rule = (id<Axis>)[[AxisRule alloc] init];
    id<Axis> baseLine = (id<Axis>)[[AxisBaseLine alloc] init];
    id<Axis> background = (id<Axis>)[[AxisBackground alloc] init];
    
    [rule acceptVisitor:appearanceRecognizer];
    [digital acceptVisitor:appearanceRecognizer];
    [baseLine acceptVisitor:appearanceRecognizer];
    [background acceptVisitor:appearanceRecognizer];
    // 这个顺序千万别错
    return @[background, rule, baseLine, digital];
    
}
- (void)updateAppearanceWithDataArray:(NSArray<AxisData *> *)dataArray size:(CGSize)size {
    
    id <AxisVisitor> appearanceRecognizer = [[AxisAppearanceRecognizer alloc] initWithViewSize:size appearance:[AxisAppearance sharedAppearance]];
    
    for (AxisData *axisData in dataArray) {
        [axisData acceptVisitor:appearanceRecognizer];
    }
}
- (UIColor *)updateAppearanceBackgroundColor {
    return [[AxisAppearance sharedAppearance] backgroundColor];
}
- (Class)updateAppearanceRenderer {
    return [[AxisAppearance sharedAppearance] rendererClass];
}
- (void)uponAppearanceForUpdateCurrentTimeIntervalFromOffset:(CGPoint)offset viewSize:(CGSize)viewSize toOptimisticOffset:(CGFloat *)opOffset optimisticViewSize:(CGFloat *)opViewSize {
    switch ([[AxisAppearance sharedAppearance] direction]) {
        case DHAxisDirectionHorizontal:
            *opOffset = offset.x;
            *opViewSize = viewSize.width;
            break;
        case DHAxisDirectionVertical:
            *opOffset = offset.y;
            *opViewSize = viewSize.height;
            break;
    }
}
@end
