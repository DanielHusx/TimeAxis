//  AxisBackground.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "AxisBackground.h"

@implementation AxisBackground
- (void)acceptVisitor:(id<AxisVisitor>)visitor {
    [visitor visitAxisBackground:self];
}
@end
