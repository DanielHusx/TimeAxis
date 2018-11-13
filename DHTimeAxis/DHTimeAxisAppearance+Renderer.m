//  DHTimeAxisAppearance+Renderer.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisAppearance+Renderer.h"
#import "DHTimeAxisRuleRenderer.h"
#import "DHTimeAxisGearRenderer.h"

@implementation DHTimeAxisAppearance (Renderer)

+ (void)renderRuleAppearanceWithDirection:(DHAxisDirection)direction {
    DHTimeAxisAppearance *appearance = [DHTimeAxisAppearance sharedAppearance];
    appearance.mainBackgroundColor = [UIColor blackColor];
    appearance.rendererClass = [DHTimeAxisRuleRenderer class];
    appearance.direction = direction;
    
    appearance.ruleColor = [UIColor whiteColor];
    appearance.ruleStrokeSize = 1.0;
    appearance.ruleOffsetLocationType = DHStrokeLocationTypeMiddle;
    
    appearance.divisionColor = [UIColor whiteColor];
    appearance.divisionStrokeSize = 1.0;
    
    appearance.digitalAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    appearance.baseLineColor = [UIColor whiteColor];
    appearance.baseLineStrokeSize = 1.0;
    appearance.baseLineFixedOffset = 80.0;
    appearance.baseLineOffsetLocationType = DHStrokeLocationTypeFlexible;
    
    appearance.minimumScale = 0.5;
    appearance.maximumScale = 4.0;
    appearance.oneToOneScaleMatchMaxHoursInVisible = 4;
    
    appearance.dataStrokeColor = [UIColor blueColor];
    appearance.dataStrokeSizeType = DHStrokeSizeTypeFull;
}


+ (void)renderGearAppearanceWithDirection:(DHAxisDirection)direction {
    DHTimeAxisAppearance *appearance = [DHTimeAxisAppearance sharedAppearance];
    appearance.mainBackgroundColor = [UIColor blackColor];
    appearance.rendererClass = [DHTimeAxisGearRenderer class];
    appearance.direction = direction;
    
    appearance.ruleColor = [UIColor whiteColor];
    appearance.ruleStrokeSize = 1.0;
    appearance.ruleOffsetLocationType = DHStrokeLocationTypeMiddle;
    
    appearance.divisionColor = [UIColor whiteColor];
    appearance.divisionStrokeSize = 1.0;
    
    appearance.digitalAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    appearance.baseLineColor = [UIColor whiteColor];
    appearance.baseLineStrokeSize = 1.0;
    appearance.baseLineFixedOffset = 0.0;
    appearance.baseLineOffsetLocationType = DHStrokeLocationTypeFlexible;
    
    appearance.minimumScale = 0.5;
    appearance.maximumScale = 4.0;
    appearance.oneToOneScaleMatchMaxHoursInVisible = 4;
    
    appearance.dataStrokeColor = [[UIColor yellowColor] colorWithAlphaComponent:.5];
    appearance.dataStrokeSizeType = DHStrokeSizeTypeFull;
}

@end
