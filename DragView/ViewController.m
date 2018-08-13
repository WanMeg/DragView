//
//  ViewController.m
//  DragView
//
//  Created by fromai on 2017/6/19.
//  Copyright © 2017年 Wang. All rights reserved.
//

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height

#import "ViewController.h"
#import "MDragView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*  项目需求 留出tabbar 和 状态栏的距离 */

    UIView *status = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    status.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:status];
    
    UIView *tabbar = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49)];
    tabbar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:tabbar];
    
    [self configDragView];
}

- (void)configDragView {
    // 拖动圆圈view
    MDragView *dragView = [[MDragView alloc]initWithFrame:CGRectMake(ScreenWidth - 10 - 50, ScreenHeight - 49 - 50 - 15, 50, 50)];
    dragView.fatherView = self.view;
    dragView.startRightWidth = 10.0f;
    dragView.dragViewButtonAction = ^(){
        NSLog(@"click...");
    };
    [self.view addSubview:dragView];
}



@end
