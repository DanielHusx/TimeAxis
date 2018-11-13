//  ViewController.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "ViewController.h"
#import "DHTimeAxis.h"
#import "DHTimeAxisAppearance.h"
#import "DHTimeAxisAppearance+Renderer.h"
@interface ViewController () <DHTimeAxisDelegate>
@property (nonatomic, strong) DHTimeAxis *axis;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize viewSize = CGSizeMake(self.view.frame.size.width, 100);
    
    [DHTimeAxisAppearance renderRuleAppearanceWithDirection:DHAxisDirectionHorizontal];
    _axis = [[DHTimeAxis alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2.0-100, viewSize.width, viewSize.height)];
    _axis.delegate = self;
    [self.view addSubview:_axis];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(_axis.frame)-40, self.view.frame.size.width, 30)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.timeLabel];
}

- (void)timeAxis:(DHTimeAxis *)timeAxis didChangedTimeInterval:(NSTimeInterval)currentTimeInterval {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.timeLabel.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:currentTimeInterval]]];
}
- (void)timeAxis:(DHTimeAxis *)timeAxis didEndedAtDataSection:(DHTimeAxisData *)aAxisData {
    NSLog(@"End Stop at data section. it contains data: %@", aAxisData.data);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DHTimeAxisData *data = [[DHTimeAxisData alloc] init];
    data.startTimeInterval = [[[NSDate dateWithTimeIntervalSince1970:self.axis.currentTimeInterval] dateByAddingTimeInterval:arc4random()%3600] timeIntervalSince1970];
    data.duration = 600;
    [_axis updateWithDataArray:@[data]];
}

@end
