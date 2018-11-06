//
//  ViewController.m
//  TraitDemon
//
//  Created by 吴桐 on 2018/8/20.
//  Copyright © 2018年 cowlevel. All rights reserved.
//

#import "ViewController.h"
#import "ZPMTraitView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZPMTraitView *tv = [[ZPMTraitView alloc]initWithFrame:CGRectMake(16, 50, [UIScreen mainScreen].bounds.size.width - 32, [UIScreen mainScreen].bounds.size.height / 2)];
    //一级菜单数组
    tv.fatherArray = @[@"菜单1 +",@"菜单2 +",@"菜单3 +",@"菜单4 +",@"菜单5 +"];
    //二级菜单数组
    tv.sonArray = @[@[@"1.1",@"1.2",@"1.3",@"1.4",@"1.5",@"1.6"],
                            @[@"2.1",@"2.2",@"2.3",@"2.4",@"2.5",@"2.6",@"2.7",@"2.8"],
                            @[@"3.1",@"3.2"],
                            @[@"4.1",@"4.2",@"4.3",@"4.4"],
                            @[@"5.1"]];
    [tv setUI];
    tv.chooseTraitWord = ^(id sender) {
        NSLog(@"选中二级菜单");
    };
    
    tv.removeTraitWord = ^(id sender) {
        NSLog(@"取消选择二级菜单");
    };
    [self.view addSubview:tv];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
