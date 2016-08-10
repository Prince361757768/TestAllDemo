//
//  ViewController.m
//  TestAllDemo
//
//  Created by Y杨定甲 on 16/7/12.
//  Copyright © 2016年 damai. All rights reserved.
//

#import "ViewController.h"
#import "LineView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LineView *lineview = [[LineView alloc]initWithFrame:CGRectMake(0, 100, 300, 300)];
    [self.view addSubview:lineview];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
