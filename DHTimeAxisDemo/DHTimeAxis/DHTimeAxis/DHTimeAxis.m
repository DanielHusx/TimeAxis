//  DHTimeAxis.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxis.h"
#import "DHTimeAxisData.h"
#import "DHTimeAxisRule.h"
#import "DHTimeAxisDigitalDivision.h"
#import "DHTimeAxisBaseLine.h"
#import "DHTimeAxis+Dynamic.h"
#import "DHTimeAxis+Appearance.h"
#import "DHTimeAxisView.h"

@interface DHTimeAxis ()
/// 真正的时间轴视图
@property (nonatomic, strong) DHTimeAxisView *axisView;

@property (nonatomic, assign) NSTimeInterval tempTimeInterval;
@property (nonatomic, assign) CGFloat tempScale;

@property (nonatomic, readwrite, assign) __block NSTimeInterval currentTimeInterval;
@property (nonatomic, readwrite, assign) CGFloat currentScale;

@property (nonatomic, readwrite, assign, getter=isPaning) __block BOOL paning;
@property (nonatomic, readwrite, assign, getter=isPinching) BOOL pinching;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGesture;

@property (nonatomic, strong) DHTimeAxisRule *rule;
@property (nonatomic, strong) DHTimeAxisDigitalDivision *digital;

/// 包装AxisView的UI数据
@property (nonatomic, strong) NSMutableArray *axisAppearanceArray;
@end
@implementation DHTimeAxis

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor yellowColor]];
        [self configCommon];
        
    }
    return self;
}
- (void)dealloc {
    [self removeObserver:self forKeyPath:@"currentTimeInterval"];
    [self removeObserver:self forKeyPath:@"currentScale"];
    [self removeObserver:self forKeyPath:@"paning"];
    [self removeObserver:self forKeyPath:@"pinching"];
}

#pragma mark - config method
/// 共同设置
- (void)configCommon {
    self.backgroundColor = [UIColor yellowColor];
    
    
    [self addSubview:self.axisView];
    
    [self updateAppearance];
    
    [self addGestureRecognizer:self.panGesture];
    [self addGestureRecognizer:self.pinchGesture];
    
    [self addObserver:self forKeyPath:@"currentTimeInterval" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"currentScale" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"paning" options:NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"pinching" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - public method
- (void)updateAppearance {
    self.axisView.backgroundColor = [self updateAppearanceBackgroundColor];
    self.axisView.rendererClass = [self updateAppearanceRenderer];
    // 重新获取新的界面
    NSArray *temp = [self updateAppearanceArrayWithSize:self.axisView.frame.size];
    
    for (id<DHTimeAxisComponent> axis in temp) {
        if ([axis isKindOfClass:[DHTimeAxisRule class]]) {
            _rule = axis;
        } else if ([axis isKindOfClass:[DHTimeAxisDigitalDivision class]]) {
            _digital = axis;
        }
    }
    
    self.currentTimeInterval = _rule.currentTimeInterval;
    self.currentScale = _digital.currentScale;
    
    self.axisAppearanceArray = [temp mutableCopy];
    
    [self updateAxisViewAppearanceArray];
}
- (void)updateWithCurrentTimeInterval:(NSTimeInterval)currentTimeInterval {
    self.currentTimeInterval = currentTimeInterval;
}
- (void)updateWithDataArray:(NSArray<DHTimeAxisData *> *)dataArray {
    __weak typeof(self) weakself = self;
    CGSize viewSize = weakself.axisView.frame.size;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [weakself updateAppearanceWithDataArray:dataArray size:viewSize];
        [weakself.axisView setDataArray:dataArray];
    });
}
- (void)manuallyStopRolling {
    // 刹车
    [self manuallyStopRollingWithDecelerating];
    // 更新变量
    self.paning = NO;
    self.currentTimeInterval = _rule.currentTimeInterval;
}
#pragma mark - private method
/// 判断在停止拖动的情况下，数据数组是否存在包含当前时间的数据项
- (void)judgeExistDataInTheInterval:(NSTimeInterval)targetTimeInterval fromDataArray:(NSArray <DHTimeAxisData *> *)dataArray withPanState:(BOOL)isPaning {
    if (isPaning == NO || !dataArray) return;
    
    if ([dataArray count] == 0) return ;
    
    // 异步处理数组
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        for (int i = 0; i < [dataArray count]; i++) {
            DHTimeAxisData *subData = [dataArray objectAtIndex:i];
            
            if (subData.startTimeInterval >= targetTimeInterval && subData.endTimeInterval <= targetTimeInterval) {
                if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(timeAxis:didEndedAtDataSection:)]) {
                    [weakself.delegate timeAxis:weakself didEndedAtDataSection:[subData copy]];
                    break;
                }
            }
        }
    });
}
/// 组装AxisView的InterfaceArray
- (void)updateAxisViewAppearanceArray {
    self.axisView.appearanceArray = [self.axisAppearanceArray copy];
}
/// 更新当前时间算法
- (void)updateCurrentTimeIntervalFrom:(NSTimeInterval)from offset:(CGPoint)offset viewSize:(CGSize)viewSize {
    CGFloat optimisticOffset = 0.0;
    CGFloat optimisticViewSize = 0.0;
    
    if (_delegate && [_delegate respondsToSelector:@selector(translationCurrentTimeIntervalFromOffset:viewSize:toOptimisticOffset:optimisticViewSize:)]) {
        [_delegate translationCurrentTimeIntervalFromOffset:offset viewSize:viewSize toOptimisticOffset:&optimisticOffset optimisticViewSize:&optimisticViewSize];
    } else {
        [self uponAppearanceForUpdateCurrentTimeIntervalFromOffset:offset viewSize:viewSize toOptimisticOffset:&optimisticOffset optimisticViewSize:&optimisticViewSize];
    }
    
    self.currentTimeInterval = from - (optimisticOffset * 1.0 / [_digital aSecondOfPixelWithViewWidth:optimisticViewSize]);
}
#pragma mark - observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentTimeInterval"] || [keyPath isEqualToString:@"currentScale"]) {
        _rule.currentTimeInterval = _currentTimeInterval;
        _digital.currentScale = _currentScale;
        // 这里通知当前时间改变
        [self updateAxisViewAppearanceArray];
    }
    
    if ([keyPath isEqualToString:@"currentTimeInterval"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(timeAxis:didChangedTimeInterval:)]) {
            [_delegate timeAxis:self didChangedTimeInterval:_currentTimeInterval];
        }
        // 判断停止时是否存在数据
        [self judgeExistDataInTheInterval:_currentTimeInterval fromDataArray:self.axisView.dataArray withPanState:self.isPaning];
        
    } else if ([keyPath isEqualToString:@"currentScale"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(timeAxis:didChangedScale:)]) {
            [_delegate timeAxis:self didChangedScale:_currentScale];
        }
    } else if ([keyPath isEqualToString:@"paning"]) {
        
        if (self.isPaning) {
            if (_delegate && [_delegate respondsToSelector:@selector(timeAxisDidBeginScrolling:)]) {
                [_delegate timeAxisDidBeginScrolling:self];
            }
        } else {
            if (_delegate && [_delegate respondsToSelector:@selector(timeAxisDidEndScrolling:)]) {
                [_delegate timeAxisDidEndScrolling:self];
            }
        }
    } else if ([keyPath isEqualToString:@"pinching"]) {
        
        if (self.isPinching) {
            if (_delegate && [_delegate respondsToSelector:@selector(timeAxisDidBeginPinching:)]) {
                [_delegate timeAxisDidBeginPinching:self];
            }
        } else {
            if (_delegate && [_delegate respondsToSelector:@selector(timeAxisDidEndPinching:)]) {
                [_delegate timeAxisDidEndPinching:self];
            }
        }
    }
}

#pragma mark - gesture recongnizer method
/// 单手拖动响应
- (void)panAction:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            _tempTimeInterval = _currentTimeInterval;
            self.paning = YES;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint point = [sender translationInView:sender.view];
            [self updateCurrentTimeIntervalFrom:_tempTimeInterval offset:point viewSize:self.axisView.frame.size];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            // 松手后的速度——即理论上脱手后能达到的偏移距离，乘以0.5是怕你飘了~
            CGPoint velocity = [sender velocityInView:sender.view];
            velocity.x *= 0.5;
            velocity.y *= 0.5;
            CGSize viewSize = self.axisView.frame.size;
            // 更新temp的值 指向松手后的点
            _tempTimeInterval = _currentTimeInterval;
            
            // 模拟减速效果
            __weak typeof(self) weakself = self;
            [self deceleratingAnimateWithVelocityPoint:velocity action:^(CGPoint deceleratingSpeedPoint, BOOL stop) {
                
                if (stop) {
                    weakself.paning = NO;
                }
                
                // deceleratingSpeedPoint是衰减速度，与velocity的意思一样，它是由velocity值慢慢衰减到0的
                // 两个的差值即每隔一定时间的变化量 与 手势状态UIGestureRecognizerStateChanged反馈的效果一致
                [weakself updateCurrentTimeIntervalFrom:weakself.tempTimeInterval offset:CGPointMake(velocity.x - deceleratingSpeedPoint.x, velocity.y - deceleratingSpeedPoint.y) viewSize:viewSize];
            }];
            break;
        }
        default:
            self.paning = NO;
            break;
    }
    
}

/// 两手指捏合响应
- (void)pinchAction:(UIPinchGestureRecognizer *)sender {
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _tempScale = _currentScale;
            self.pinching = YES;
            break;
        case UIGestureRecognizerStateChanged:
            self.currentScale = _tempScale + sender.scale - 1;
            break;
        default:
            self.pinching = NO;
            break;
    }
    
}

#pragma mark - getters
- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        _panGesture.maximumNumberOfTouches = 1;
    }
    return _panGesture;
}
- (UIPinchGestureRecognizer *)pinchGesture {
    if (!_pinchGesture) {
        _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    }
    return _pinchGesture;
}
- (DHTimeAxisView *)axisView {
    if (!_axisView) {
        _axisView = [[DHTimeAxisView alloc] initWithFrame:self.bounds];
    }
    return _axisView;
}
- (NSMutableArray *)axisAppearanceArray {
    if (!_axisAppearanceArray) {
        _axisAppearanceArray = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return _axisAppearanceArray;
}
- (void)setCurrentScale:(CGFloat)currentScale {
    /// 优化比例值
    [_digital updateToOptimisticScale:&currentScale];
    _currentScale = currentScale;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.axisView.frame = self.bounds;
}

@end
