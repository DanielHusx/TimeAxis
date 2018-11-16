//  DHTimeAxis+Appearance.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxis+Appearance.h"
#import "DHTimeAxisAppearance.h"
#import "DHTimeAxisRule.h"
#import "DHTimeAxisDigitalDivision.h"
#import "DHTimeAxisBaseLine.h"
#import "DHTimeAxisBackground.h"
#import "DHTimeAxisAppearanceRecognizer.h"

@implementation DHTimeAxis (Appearance)
- (void)registeAppearanceNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAppearance) name:kDHAppearanceUpdatedNotificationName object:nil];
}
- (void)resignAppearanceNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDHAppearanceUpdatedNotificationName object:nil];
}
- (NSArray *)updateAppearanceArrayWithSize:(CGSize)size {
    DHTimeAxisAppearance *appearance = [DHTimeAxisAppearance sharedAppearance];
    id <DHTimeAxisVisitor> appearanceRecognizer = [[DHTimeAxisAppearanceRecognizer alloc] initWithViewSize:size appearance:appearance];
    id<DHTimeAxisComponent> digital = (id<DHTimeAxisComponent>)[[DHTimeAxisDigitalDivision alloc] init];
    id<DHTimeAxisComponent> rule = (id<DHTimeAxisComponent>)[[DHTimeAxisRule alloc] init];
    id<DHTimeAxisComponent> baseLine = (id<DHTimeAxisComponent>)[[DHTimeAxisBaseLine alloc] init];
    id<DHTimeAxisComponent> background = (id<DHTimeAxisComponent>)[[DHTimeAxisBackground alloc] init];
    
    [rule acceptVisitor:appearanceRecognizer];
    [digital acceptVisitor:appearanceRecognizer];
    [baseLine acceptVisitor:appearanceRecognizer];
    [background acceptVisitor:appearanceRecognizer];
    // 这个顺序千万别错
    return @[background, rule, baseLine, digital];
    
}
- (void)updateAppearanceWithDataArray:(NSArray<DHTimeAxisData *> *)dataArray size:(CGSize)size {
    
    id <DHTimeAxisVisitor> appearanceRecognizer = [[DHTimeAxisAppearanceRecognizer alloc] initWithViewSize:size appearance:[DHTimeAxisAppearance sharedAppearance]];
    
    for (DHTimeAxisData *axisData in dataArray) {
        [axisData acceptVisitor:appearanceRecognizer];
    }
}
- (UIColor *)updateAppearanceMainBackgroundColor {
    return [[DHTimeAxisAppearance sharedAppearance] mainBackgroundColor];
}
- (Class)updateAppearanceRenderer {
    return [[DHTimeAxisAppearance sharedAppearance] rendererClass];
}
- (void)uponAppearanceForUpdateCurrentTimeIntervalFromOffset:(CGPoint)offset viewSize:(CGSize)viewSize toOptimisticOffset:(CGFloat *)opOffset optimisticViewSize:(CGFloat *)opViewSize {
    switch ([[DHTimeAxisAppearance sharedAppearance] direction]) {
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
