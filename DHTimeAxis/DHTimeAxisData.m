//  DHTimeAxisData.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisData.h"

@implementation DHTimeAxisData
- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor {
    [visitor visitTimeAxisData:self];
}

- (id)copyWithZone:(NSZone *)zone {
    DHTimeAxisData *axisData = [[DHTimeAxisData allocWithZone:zone] init];
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
