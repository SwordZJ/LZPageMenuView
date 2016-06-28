//
//  ViewController.m
//  LZPageMenuView
//
//  Created by 周济 on 16/6/23.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "ViewController.h"
#import "LZPageMenuDemoViewController.h"
#import "NSObject+LZSwipeCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor randomColor];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextPage {
    LZPageMenuDemoViewController *testVc = [LZPageMenuDemoViewController new];
    testVc.title = @"测试demo";
    [self.navigationController pushViewController:testVc animated:YES];
}

@end
