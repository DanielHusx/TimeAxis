//  DHTimeAxisBaseLine.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisBaseLine.h"

@implementation DHTimeAxisBaseLine
- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor {
    [visitor visitTimeAxisBaseLine:self];
}
@end
