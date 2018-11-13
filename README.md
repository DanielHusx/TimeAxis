# TimeAxis
录像时间轴，无限滚动

使用物理引擎模拟实现UIScrollView的滚动效果

提供丰富的代理反馈，可以详细查看DHTimeAxisDelegate



Pod 

```
pod 'TimeAxis'
```



使用方式

```objective-c
#import <DHTimeAxis.h>
	/**
	DHTimeAxisAppearance是个单例类，用于控制外观属性，具体属性请查看该类
	其中属性rendererClass 必须是继承DHTimeAxisRenderer的子类，它是能够使用DHTimeAxisAppearance属性进行绘制的类，具体使用方式可以参照DHTimeAxisGearRenderer或DHTimeAxisRuleRenderer的实现
	*/
	[DHTimeAxisAppearance renderGearAppearanceWithDirection:DHAxisDirectionHorizontal];
    DHTimeAxis *axis = [[DHTimeAxis alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2.0-100, self.view.frame.size.width, 100)];
    [self.view addSubview:axis];
```



效果图：

GearRenderer

![GearExample-2087123](/Users/goscam_husx/Documents/iPrivacy/iMarkdown/Untitled.assets/GearExample-2087123.png)

RuleRenderer

![RuleExample-2087144](/Users/goscam_husx/Documents/iPrivacy/iMarkdown/Untitled.assets/RuleExample-2087144.png)