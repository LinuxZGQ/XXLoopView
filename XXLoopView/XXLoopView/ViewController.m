//
//  ViewController.m
//  XXLoopView
//
//  Created by mac on 2018/2/11.
//  Copyright © 2018年 zhangguoqing@vip.163.com. All rights reserved.
//
#import "ViewController.h"
#import "XXLoopView.h"
@interface ViewController ()<XXLoopViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XXLoopView *loopView = [[XXLoopView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) ResourceType:XXImageResourceTypeLocal];
    
    loopView.imageNames = @[@"1",@"2",@"3"];
    loopView.delegate = self;
    [self.view addSubview:loopView];
    XXLoopView *loopView2 = [[XXLoopView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200) ResourceType:XXImageResourceTypeURL];
    
    loopView2.imageNames = @[@"https://raw.githubusercontent.com/LinuxZGQ/linuxzgq.github.io/master/1.png",@"https://raw.githubusercontent.com/LinuxZGQ/linuxzgq.github.io/master/2.png",@"https://raw.githubusercontent.com/LinuxZGQ/linuxzgq.github.io/master/3.png"];
    /*
     展示 url的图片未做缓存优化
     */
    loopView2.delegate = self;
    [self.view addSubview:loopView2];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)didSelectItemAtIndex:(NSUInteger)index{
    NSLog(@"%lu",index);
}


@end
