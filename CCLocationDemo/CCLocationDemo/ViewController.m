//
//  ViewController.m
//  CCLocationDemo
//
//  Created by Rachal Zhou.
//  Copyright © 2018年 RachalPersonal. All rights reserved.
//

#import "ViewController.h"
#import "CCLocationFetcher.h"

#define kScreenW CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenH CGRectGetHeight([UIScreen mainScreen].bounds)

@interface ViewController ()

@property (nonatomic, readwrite, strong) UILabel *label1;
@property (nonatomic, readwrite, strong) UILabel *label2;

@property (nonatomic, readwrite, strong) CCLocationFetcher *fetcher2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //测试Label和Button
    _label1 = [[UILabel alloc] init];
    _label1.bounds = CGRectMake(0, 0, kScreenW - 30, 30);
    _label1.center = CGPointMake(kScreenW / 2, 100);
    _label1.textAlignment = NSTextAlignmentCenter;
    _label1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_label1];
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.bounds = CGRectMake(0, 0, 150, 30);
    btn1.center = CGPointMake(kScreenW / 2, 140);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"定位按钮1" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    _label2 = [[UILabel alloc] init];
    _label2.bounds = CGRectMake(0, 0, kScreenW - 30, 30);
    _label2.center = CGPointMake(kScreenW / 2, 180);
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_label2];
    
    UIButton *btn2 = [[UIButton alloc] init];
    btn2.bounds = CGRectMake(0, 0, 150, 30);
    btn2.center = CGPointMake(kScreenW / 2, 220);
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"定位按钮2" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)click1 {
    
    __weak typeof(self) weakSelf = self;
    
    //使用方法一（推荐）
    [[CCLocationFetcher sharedInstance] startWithCompletionHandler:^(LocationModel *location) {
        
        NSLog(@"经度:%@--纬度:%@--地址:%@",location.longitude,location.latitude,location.address);
        weakSelf.label1.text = location.address;
    }];
}

- (void)click2 {
    
    __weak typeof(self) weakSelf = self;
    
    //使用方法二
    _fetcher2 = [[CCLocationFetcher alloc] init];
    [_fetcher2 startWithCompletionHandler:^(LocationModel *location) {
        
        NSLog(@"经度:%@--纬度:%@--地址:%@",location.longitude,location.latitude,location.address);
        weakSelf.label2.text = [NSString stringWithFormat:@"经度:%@ 纬度:%@",location.longitude,location.latitude];
    }];
}

@end
