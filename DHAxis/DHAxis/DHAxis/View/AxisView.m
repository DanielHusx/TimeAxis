//  AxisView.m
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisView.h"
#import "AxisRenderer.h"
#import "AxisData.h"


@implementation AxisView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 必须设置一种颜色，不然drawRect:绘制的图像会重叠
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setRendererClass:[AxisRenderer class]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 非AxisRenderer子类不进行绘制
    if ([self.rendererClass isKindOfClass:[AxisRenderer class]]) return;
    
    // 渲染的Visitor
    id<AxisVisitor> rendererVisitor = [[self.rendererClass alloc] initWithViewSize:rect.size context:context];
    
    // 先绘制UI
    for (id<Axis> axis in _appearanceArray) {
        [axis acceptVisitor:rendererVisitor];
    }
    
    // 再绘制段数据
    for (id<Axis> axis in _dataArray) {
        [axis acceptVisitor:rendererVisitor];
    }
}
- (void)refreshViewInMainThread {
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself setNeedsDisplay];
    });
}
- (void)setDataArray:(NSArray<AxisData *> *)dataArray {
    _dataArray = dataArray;
    
    [self refreshViewInMainThread];
}
- (void)setAppearanceArray:(NSArray<id<Axis>> *)appearanceArray {
    _appearanceArray = appearanceArray;
    
    [self refreshViewInMainThread];
}
@end
