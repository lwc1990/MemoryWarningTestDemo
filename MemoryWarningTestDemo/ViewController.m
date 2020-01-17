//
//  ViewController.m
//  MemoryWarningTestDemo
//
//  Created by cheyipai on 2020/1/14.
//  Copyright © 2020 cheyipai. All rights reserved.
//

#import "ViewController.h"
#import "TestFirstViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setConfigs];
    [self initSubViews];
}
-(void)setConfigs{
    self.view.backgroundColor = [UIColor whiteColor];
}
-(void)initSubViews{
    CGSize size = CGSizeMake(150, 45);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake((screenSize.width - size.width)/2.0,(screenSize.height - size.height)/2.0,size.width,size.height)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"开始测试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont  systemFontOfSize:14]];
    [button addTarget:self  action:@selector(goTestModule) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)goTestModule{
    TestFirstViewController *firstVC = [[TestFirstViewController alloc]init];
    [self.navigationController pushViewController:firstVC animated:YES];
}
@end
