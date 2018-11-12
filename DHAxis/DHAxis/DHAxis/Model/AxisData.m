//  AxisData.m
//  DHAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisData.h"

@implementation AxisData
- (void)acceptVisitor:(id<AxisVisitor>)visitor {
    [visitor visitAxisData:self];
}

- (id)copyWithZone:(NSZone *)zone {
    AxisData *axisData = [[AxisData allocWithZone:zone] init];
    axisData.startTimeInterval = self.startTimeInterval;
    axisData.duration = self.duration;
    axisData.strokeColor = self.strokeColor;
    axisData.data = self.data;
    
    return axisData;
}
- (NSTimeInterval)endTimeInterval {
    return self.startTimeInterval + self.duration;
}
@end
