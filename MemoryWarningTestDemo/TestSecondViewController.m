//
//  TestSecondViewController.m
//  MemoryWarningTestDemo
//
//  Created by cheyipai on 2020/1/16.
//  Copyright © 2020 cheyipai. All rights reserved.
//

#import "TestSecondViewController.h"

@interface TestSecondViewController ()

@end

@implementation TestSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfigs];
    [self creatBtn];
}
-(void)setConfigs{
    self.title = @"页面二";
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)creatBtn{
    CGSize btnSize = CGSizeMake(150,45);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((screenSize.width - btnSize.width)/2.0,(screenSize.height - btnSize.height)/2.0,btnSize.width,btnSize.height)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"模拟内存警告" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont  systemFontOfSize:14]];
    [button addTarget:self  action:@selector(analogMemoryWarning) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)analogMemoryWarning{
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
    
    SEL memoryWarningSel = @selector(_performMemoryWarning);
    if ([[UIApplication sharedApplication] respondsToSelector:memoryWarningSel]) {
        [[UIApplication sharedApplication] performSelector:memoryWarningSel];
        
    }else {
        NSLog(@"%@",@"Whoops UIApplication no loger responds to -_performMemoryWarning");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
