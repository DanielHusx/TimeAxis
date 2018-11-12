//  DHTimeAxisBaseLine.h
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import <Foundation/Foundation.h>
#import "DHTimeAxisComponent.h"

NS_ASSUME_NONNULL_BEGIN
/**
 底线
 */
@interface DHTimeAxisBaseLine : NSObject <DHTimeAxisComponent>
@property (nonatomic, assign) CGFloat fixedOffset;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor;

@end

NS_ASSUME_NONNULL_END
