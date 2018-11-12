//  DHTimeAxisView.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisView.h"
#import "DHTimeAxisRenderer.h"
#import "DHTimeAxisData.h"

@implementation DHTimeAxisView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 必须设置一种颜色，不然drawRect:绘制的图像会重叠
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self setRendererClass:[DHTimeAxisRenderer class]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 非AxisRenderer子类不进行绘制
    if ([self.rendererClass isKindOfClass:[DHTimeAxisRenderer class]]) return;
    
    // 渲染的Visitor
    id<DHTimeAxisVisitor> rendererVisitor = [[self.rendererClass alloc] initWithViewSize:rect.size context:context];
    
    // 先绘制UI
    for (id<DHTimeAxisComponent> axis in _appearanceArray) {
        [axis acceptVisitor:rendererVisitor];
    }
    
    // 再绘制段数据
    for (id<DHTimeAxisComponent> axis in _dataArray) {
        [axis acceptVisitor:rendererVisitor];
    }
}
- (void)refreshViewInMainThread {
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself setNeedsDisplay];
    });
}
- (void)setDataArray:(NSArray<DHTimeAxisData *> *)dataArray {
    _dataArray = dataArray;
    
    [self refreshViewInMainThread];
}
- (void)setAppearanceArray:(NSArray<id<DHTimeAxisComponent>> *)appearanceArray {
    _appearanceArray = appearanceArray;
    
    [self refreshViewInMainThread];
}
@end
