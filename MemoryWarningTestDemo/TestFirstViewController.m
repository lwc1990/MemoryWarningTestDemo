//
//  TestFirstViewController.m
//  MemoryWarningTestDemo
//
//  Created by cheyipai on 2020/1/16.
//  Copyright © 2020 cheyipai. All rights reserved.
//

#import "TestFirstViewController.h"
#import "TestSecondViewController.h"
@interface TestFirstViewController ()
@property (nonatomic,assign) NSInteger initialTimes;
@property (nonatomic,strong) UILabel *displayLab;
@end

@implementation TestFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfigs];
    [self initSubViews];
}
-(void)setConfigs{
    self.title = @"不信你看";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.initialTimes ++;
}
-(void)initSubViews{
    [self.view addSubview:self.displayLab];
    self.displayLab.text = [NSString stringWithFormat:@"第%zu次实例化",self.initialTimes];
    [self creatWarningBtn];
    [self createTransBtn];
}
-(UILabel *)displayLab{
    if (!_displayLab) {
        CGFloat labH = 40;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _displayLab = [[UILabel alloc]initWithFrame:CGRectMake(0,(screenSize.height - labH)/2.0,screenSize.width,labH)];
        _displayLab.textColor = [UIColor grayColor];
        [_displayLab setFont:[UIFont systemFontOfSize:14]];
        _displayLab.textAlignment = NSTextAlignmentCenter;
    }
    return _displayLab;
}
-(void)creatWarningBtn{
    CGSize btnSize = CGSizeMake(150,45);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((screenSize.width - btnSize.width)/2.0,CGRectGetMaxY(self.displayLab.frame),btnSize.width,btnSize.height)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"模拟内存警告" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont  systemFontOfSize:14]];
    [button addTarget:self  action:@selector(analogMemoryWarning) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)createTransBtn{
    CGSize btnSize = CGSizeMake(100,45);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((screenSize.width - btnSize.width)/2.0,CGRectGetMaxY(self.displayLab.frame) + 45 + 15,btnSize.width,btnSize.height)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"转场" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont  systemFontOfSize:14]];
    [button addTarget:self  action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)analogMemoryWarning{
    //方法一：让系统发出内存警告（此方法经验证无效）
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
    //方法二：通过调用私有api发出内存警告
    SEL memoryWarningSel = @selector(_performMemoryWarning);
    if ([[UIApplication sharedApplication] respondsToSelector:memoryWarningSel]) {
        [[UIApplication sharedApplication] performSelector:memoryWarningSel];
        
    }else {
        NSLog(@"%@",@"Whoops UIApplication no loger responds to -_performMemoryWarning");
    }
}
-(void)goNext{
    TestSecondViewController *secondVC = [[TestSecondViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}
/**
 * 收到系统内存警告的处理方法
 * 在收到内存警告时，已经加载的且不在当前windown上的页面可以释放一些耗费资源的视图、请求、缓存。
 */

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window) {
        for (UIView *v in self.view.subviews) {
            [v removeFromSuperview];
        }
        self.displayLab = nil;
        self.view = nil;
    }
}

@end
