//  DHTimeAxisBackground.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisBackground.h"

@implementation DHTimeAxisBackground
- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor {
    [visitor visitTimeAxisBackground:self];
}
@end
