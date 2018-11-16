//  DHTimeAxisAppearance.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisAppearance.h"
#import "DHTimeAxisRenderer.h"

@implementation DHTimeAxisAppearance
static DHTimeAxisAppearance *_instance = nil;
+ (instancetype)sharedAppearance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DHTimeAxisAppearance alloc] init];
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
    _rendererClass = [DHTimeAxisRenderer class];
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

- (void)setRendererClass:(Class)rendererClass {
    NSAssert(![rendererClass isKindOfClass:[DHTimeAxisRenderer class]], @"renderClass must be subclass of DHTimeAxisRender");
    _rendererClass = rendererClass;
    
}

- (void)updateAppearance {
    [[NSNotificationCenter defaultCenter] postNotificationName:kDHAppearanceUpdatedNotificationName object:nil];
}
@end
