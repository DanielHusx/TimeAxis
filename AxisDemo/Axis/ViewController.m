//  ViewController.m
//  Axis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "ViewController.h"
#import "AxisController.h"
//#import "AxisDefault.h"
#import "AxisAppearance.h"
#import "AxisClockRenderer.h"
#import "AxisRuleRenderer.h"
@interface ViewController ()
@property (nonatomic, strong) AxisController *axis;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [AxisAppearance sharedAppearance].direction = DHAxisDirectionVertical;
    [AxisAppearance sharedAppearance].rendererClass = [AxisRuleRenderer class];
    [AxisAppearance sharedAppearance].baseLineFixedOffset = 80.0;
    _axis = [[AxisController alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2.0-100, self.view.frame.size.width, 200)];
    [self.view addSubview:_axis];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    AxisData *data = [[AxisData alloc] init];
    data.startTimeInterval = [[[NSDate dateWithTimeIntervalSince1970:self.axis.currentTimeInterval] dateByAddingTimeInterval:arc4random()%3600] timeIntervalSince1970];
    data.duration = 600;
    
    
    [_axis updateWithDataArray:@[data]];
}


@end
