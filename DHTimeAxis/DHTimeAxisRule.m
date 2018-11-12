//  DHTimeAxisRule.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "DHTimeAxisRule.h"

@implementation DHTimeAxisRule
- (instancetype)init {
    if (self = [super init]) {
        _currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        _axisDirection = DHTimeAxisDirectionHorizontal;
    }
    return self;
}
- (void)acceptVisitor:(id<DHTimeAxisVisitor>)visitor {
    [visitor visitTimeAxisRule:self];
}
- (NSDate *)currentHourDate {
    NSDateComponents *dateComponent = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:[NSDate dateWithTimeIntervalSince1970:self.currentTimeInterval]];
    dateComponent.minute = 0;
    dateComponent.second = 0;
    dateComponent.nanosecond = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponent];
}
- (NSInteger)currentHour {
    return [self fetchCurrentTimeValueWithUnit:NSCalendarUnitHour];
}
- (NSInteger)fetchCurrentTimeValueWithUnit:(NSCalendarUnit)unit {
    return [[NSCalendar currentCalendar] component:unit fromDate:[NSDate dateWithTimeIntervalSince1970:self.currentTimeInterval]];
}
@end
