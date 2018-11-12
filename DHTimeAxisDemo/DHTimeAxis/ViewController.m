//  ViewController.m
//  DHTimeAxis
//
//  Create by daniel.hu on 2018/11/12.
//  Copyright © 2018年 daniel. All rights reserved.

#import "ViewController.h"
#import "DHTimeAxis.h"
#import "DHTimeAxisAppearance.h"
#import "DHTimeAxisAppearance+Renderer.h"
@interface ViewController ()
@property (nonatomic, strong) DHTimeAxis *axis;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    CGSize viewSize = CGSizeMake(400, 300);
    
    [DHTimeAxisAppearance renderGearAppearanceWithViewSize:viewSize direction:DHAxisDirectionHorizontal];
    _axis = [[DHTimeAxis alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2.0-100, viewSize.width, viewSize.height)];
    [self.view addSubview:_axis];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DHTimeAxisData *data = [[DHTimeAxisData alloc] init];
    data.startTimeInterval = [[[NSDate dateWithTimeIntervalSince1970:self.axis.currentTimeInterval] dateByAddingTimeInterval:arc4random()%3600] timeIntervalSince1970];
    data.duration = 600;
    [_axis updateWithDataArray:@[data]];
}

@end
