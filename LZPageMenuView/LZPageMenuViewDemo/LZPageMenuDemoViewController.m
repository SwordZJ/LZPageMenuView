//
//  LZPageMenuDemoViewController.m
//  LZPageMenuView
//
//  Created by 周济 on 16/6/27.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "LZPageMenuDemoViewController.h"
#import "LZPageMenuView.h"
#import "ViewController.h"

@interface LZPageMenuDemoViewController ()

@end

@implementation LZPageMenuDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    ViewController *test1 = [[ViewController alloc] init];
    test1.title = @"test1";
    ViewController *test2 = [[ViewController alloc] init];
    test2.title = @"test2";
    ViewController *test3 = [[ViewController alloc] init];
    test3.title = @"test3";
    
    ViewController *test4 = [[ViewController alloc] init];
    test4.title = @"test4";
    ViewController *test5 = [[ViewController alloc] init];
    test5.title = @"test5";
    ViewController *test6 = [[ViewController alloc] init];
    test6.title = @"test6";
    
    NSDictionary *param = @{
//                                LZPageMenuOptionViewBackgroundColor      : [UIColor blueColor],
//                                LZPageMenuOptionSelectionIndicatorHeight : @(1),
//                                LZPageMenuOptionSelectionIndicatorWidth  : @(150),
//                                LZPageMenuOptionSelectionIndicatorColor  : [UIColor greenColor],
//                                LZPageMenuOptionScrollMenuBackgroundColor: [UIColor cyanColor],
//                                LZPageMenuOptionMenuHeight               : @(64),
//                                LZPageMenuOptionSelectedMenuItemLabelColor: [UIColor whiteColor],
//                                LZPageMenuOptionUnselectedMenuItemLabelColor : [UIColor greenColor],
//                                LZPageMenuOptionMenuItemFont                 : [UIFont systemFontOfSize:32],
//                                LZPageMenuOptionMenuItemWidth                : @(200),
//                                LZPageMenuOptionScrollAnimationDuration      : @(1),
//                                LZPageMenuOptionDividerBackgroundColor       : [UIColor redColor],
                            };
    
    NSArray *vcs = @[test1,test2,test3,test4,test5,test6];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    LZPageMenuView *pageMenu = [[LZPageMenuView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) ItemList:vcs paragrams:param style:LZPageMenuViewNormalStyle];
    [self.view addSubview:pageMenu];
}


@end
