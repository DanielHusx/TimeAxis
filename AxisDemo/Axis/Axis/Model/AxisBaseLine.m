//  AxisBaseLine.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisBaseLine.h"

@implementation AxisBaseLine
- (void)acceptVisitor:(id<AxisVisitor>)visitor {
    [visitor visitAxisBaseLine:self];
}
@end
