//  AxisAppearance.m
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisAppearance.h"
#import "AxisRenderer.h"

@implementation AxisAppearance
static AxisAppearance *_instance = nil;
+ (instancetype)sharedAppearance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AxisAppearance alloc] init];
        // 默认初始化数据
        [_instance defaultInitial];
    });
    return _instance;
}
//断言
+ (instancetype)alloc{
    NSCAssert(!_instance, @"AxisAppearance类只能初始化一次");
    return [super alloc];
}
- (void)defaultInitial {
    _mainBackgroundColor = [UIColor blackColor];
    _rendererClass = [AxisRenderer class];
    _direction = DHAxisDirectionHorizontal;
    
    _backgroundColor = [UIColor whiteColor];
    _backgroundStrokeSize = 0.0;
    _backgroundStrokeSizeType = DHStrokeSizeTypeFlexible;
    
    _ruleColor = [UIColor whiteColor];
    _ruleFixedOffset = 0.0;
    _ruleStrokeSize = 1.0;
    _ruleOffsetLocationType = DHStrokeLocationTypeMiddle;
    
    _divisionColor = [UIColor whiteColor];
    _divisionStrokeSize = 1.0;
    _digitalAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    _baseLineColor = [UIColor whiteColor];
    _baseLineStrokeSize = 1.0;
    _baseLineFixedOffset = 0.0;
    _baseLineOffsetLocationType = DHStrokeLocationTypeFlexible;
    
    _minimumScale = 1.0;
    _maximumScale = 2.0;
    _oneToOneScaleMatchMaxHoursInVisible = 4;
    
    _dataStrokeColor = [UIColor blueColor];
    _dataStrokeSize = 1.0;
    _dataStrokeSizeType = DHStrokeSizeTypeFull;
}
- (void)initial {
    _backgroundColor = [UIColor blackColor];
    _rendererClass = [AxisRenderer class];
    _direction = DHAxisDirectionHorizontal;
    
    _ruleColor = [UIColor whiteColor];
    _ruleFixedOffset = 20.0;
    _ruleStrokeSize = 1.0;
    _ruleOffsetLocationType = DHStrokeLocationTypeMiddle;
    
    _divisionColor = [UIColor whiteColor];
    _divisionStrokeSize = 1.0;
    
    _digitalAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    _baseLineColor = [UIColor whiteColor];
    _baseLineStrokeSize = 1.0;
    
    _baseLineFixedOffset = 0.0;
    _baseLineOffsetLocationType = DHStrokeLocationTypeFlexible;
    
    _minimumScale = 0.5;
    _maximumScale = 4.0;
    _oneToOneScaleMatchMaxHoursInVisible = 4;
    
    _dataStrokeColor = [UIColor blueColor];
    _dataStrokeSize = 1.0;
    _dataStrokeSizeType = DHStrokeSizeTypeFull;
    
}

- (void)clockAppearanceWithViewSize:(CGSize)viewSize {
    
}
- (void)gearAppearanceWithViewSize:(CGSize)viewSize {
    
}
- (void)ruleAppearanceWithViewSize:(CGSize)viewSize {
    
}
@end
