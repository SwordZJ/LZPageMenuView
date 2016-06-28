//
//  LZPageMenuView.h
//  LZPageMenuView
//
//  Created by 周济 on 16/6/27.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    LZPageMenuViewTopItemOnlyStyle = 0,
    LZPageMenuViewBottomPageOnlyStyle,
    LZPageMenuViewNormalStyle,
} LZPageMenuViewStyle;

@class LZPageMenuView;
@protocol LZPageMenuViewDelegate <NSObject>
@optional
- (void)pageMenuView:(LZPageMenuView *)pageMenuView didMoveToIndex:(NSInteger)index;

@end

@interface LZPageMenuView : UIView
- (instancetype)initWithFrame:(CGRect)frame ItemList:(NSArray *)itemControllers paragrams:(NSDictionary *)paragrams style:(LZPageMenuViewStyle)style;

@property (nonatomic, weak) id<LZPageMenuViewDelegate> delegate;


// 内容视图背景颜色
extern NSString * const LZPageMenuOptionViewBackgroundColor;
// 指示器高度
extern NSString * const LZPageMenuOptionSelectionIndicatorHeight;
// 指示器宽度
extern NSString * const LZPageMenuOptionSelectionIndicatorWidth;
// 设置选中标签指示器颜色
extern NSString * const LZPageMenuOptionSelectionIndicatorColor;
// 标签栏背景颜色
extern NSString * const LZPageMenuOptionScrollMenuBackgroundColor;
// 设置标签栏高度
extern NSString * const LZPageMenuOptionMenuHeight;
// 设置标签选中状态文字颜色
extern NSString * const LZPageMenuOptionSelectedMenuItemLabelColor;
// 设置标签未选中状态文字
extern NSString * const LZPageMenuOptionUnselectedMenuItemLabelColor;
// 设置标签字体
extern NSString * const LZPageMenuOptionMenuItemFont;
// 设置标签宽度
extern NSString * const LZPageMenuOptionMenuItemWidth;
// 设置标签滚动动画时间
extern NSString * const LZPageMenuOptionScrollAnimationDuration;
// 设置分割线颜色
extern NSString * const LZPageMenuOptionDividerBackgroundColor;


@end


