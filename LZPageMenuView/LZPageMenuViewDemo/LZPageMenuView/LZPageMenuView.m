//
//  LZPageMenuView.m
//  LZPageMenuView
//
//  Created by 周济 on 16/6/27.
//  Copyright © 2016年 LeoZ. All rights reserved.
//

#import "LZPageMenuView.h"
#import "NSObject+LZSwipeCategory.h"


#define KLZPAGEMENUITEMMEMUDEFAULTHEIGHT  44
#define KSCROLLANIMATIONDURATIONONMENUITEM 0.25
#define KSELECTIONINDICATORHEIGHT 1



@interface LZPageMenuView()<UIScrollViewDelegate>
/** 选项卡视图  */
@property (nonatomic, strong) UIScrollView *itemMenu;
/** pageMenu视图  */
@property (nonatomic, strong) UIScrollView *pageMenu;
/** 子视图控制器合集  */
@property (nonatomic, strong) NSArray *ItemControllers;
/** 参数控制  */
@property (nonatomic, strong) NSDictionary *paragrams;
/** 显示模式  */
@property (nonatomic, assign) LZPageMenuViewStyle showStyle;

/** 标签数组  */
@property (nonatomic, strong) NSMutableArray *itemBtnArray;

/** menu视图数组  */
@property (nonatomic, strong) NSMutableArray *menuViewArray;

/** 指示器  */
@property (nonatomic, strong) UIView *indicator;

/** 分割线  */
@property (nonatomic, strong) UIView *divider;

/** 上个点击的按钮  */
@property (nonatomic, strong) UIButton *lastItemBtn;


@property (nonatomic, assign) CGFloat menuHeight;
@property (nonatomic, assign) CGFloat menuItemWidth;
@property (nonatomic, assign) CGFloat selectionIndicatorHeight;
@property (nonatomic, assign) CGFloat selectionIndicatorWidth;
@property (nonatomic, assign) CGFloat scrollAnimationDurationOnMenuItemTap;

@property (nonatomic, strong) UIColor *selectionIndicatorColor;
@property (nonatomic, strong) UIColor *selectedMenuItemLabelColor;
@property (nonatomic, strong) UIColor *unselectedMenuItemLabelColor;
@property (nonatomic, strong) UIColor *scrollMenuBackgroundColor;
@property (nonatomic, strong) UIColor *viewBackgroundColor;
@property (nonatomic, strong) UIColor *dividerColor;
@property (nonatomic, strong) UIFont  *menuItemFont;


@end


@implementation LZPageMenuView

NSString * const LZPageMenuOptionSelectionIndicatorHeight       = @"LZPageMenuOptionSelectionIndicatorHeight";
NSString * const LZPageMenuOptionSelectionIndicatorWidth        = @"LZPageMenuOptionSelectionIndicatorWidth";
NSString * const LZPageMenuOptionSelectionIndicatorColor        = @"LZPageMenuOptionSelectionIndicatorColor";
NSString * const LZPageMenuOptionScrollMenuBackgroundColor      = @"LZPageMenuOptionScrollMenuBackgroundColor";
NSString * const LZPageMenuOptionViewBackgroundColor            = @"LZPageMenuOptionViewBackgroundColor";
NSString * const LZPageMenuOptionMenuHeight                     = @"LZPageMenuOptionMenuHeight";
NSString * const LZPageMenuOptionSelectedMenuItemLabelColor     = @"LZPageMenuOptionSelectedMenuItemLabelColor";
NSString * const LZPageMenuOptionUnselectedMenuItemLabelColor   = @"LZPageMenuOptionUnselectedMenuItemLabelColor";
NSString * const LZPageMenuOptionMenuItemFont                   = @"LZPageMenuOptionMenuItemFont";
NSString * const LZPageMenuOptionMenuItemWidth                  = @"LZPageMenuOptionMenuItemWidth";
NSString * const LZPageMenuOptionScrollAnimationDuration        = @"LZPageMenuOptionScrollAnimationDuration";
NSString * const LZPageMenuOptionDividerBackgroundColor         = @"LZPageMenuOptionDividerBackgroundColor";

- (NSMutableArray *)itemBtnArray{
    if (!_itemBtnArray) {
        _itemBtnArray = [NSMutableArray array];
    }
    return _itemBtnArray;
}

- (NSMutableArray *)menuViewArray{
    if (!_menuViewArray) {
        _menuViewArray = [NSMutableArray array];
    }
    return _menuViewArray;
}

- (UIScrollView *)itemMenu{
    if (!_itemMenu) {
        _itemMenu = [[UIScrollView alloc] init];
        _itemMenu.showsVerticalScrollIndicator = NO;
        _itemMenu.showsHorizontalScrollIndicator = NO;
        _itemMenu.bounces = NO;
    }
    return _itemMenu;
}

- (UIScrollView *)pageMenu{
    if (!_pageMenu) {
        _pageMenu = [[UIScrollView alloc] init];
        _pageMenu.delegate = self;
        _pageMenu.showsVerticalScrollIndicator = NO;
        _pageMenu.showsHorizontalScrollIndicator = NO;
        _pageMenu.pagingEnabled = YES;
        _pageMenu.bounces = NO;
    }
    return _pageMenu;
}

- (instancetype)initWithFrame:(CGRect)frame ItemList:(NSArray *)itemControllers paragrams:(NSDictionary *)paragrams style:(LZPageMenuViewStyle)style{
    if (self  = [super initWithFrame:frame]) {
        self.ItemControllers = itemControllers;
        self.paragrams = paragrams;
        self.showStyle = style;
        self.paragrams = paragrams;
        
        if (paragrams) {
            for (NSString *key in paragrams) {
                if ([key isEqualToString:LZPageMenuOptionSelectionIndicatorHeight]) {
                    _selectionIndicatorHeight = [paragrams[key] floatValue];
                } else if ([key isEqualToString: LZPageMenuOptionSelectionIndicatorWidth]) {
                    _selectionIndicatorWidth = [paragrams[key] floatValue];
                }else if ([key isEqualToString:LZPageMenuOptionSelectionIndicatorColor]) {
                    _selectionIndicatorColor = (UIColor *)paragrams[key];
                }else if ([key isEqualToString:LZPageMenuOptionScrollMenuBackgroundColor]) {
                    _scrollMenuBackgroundColor = (UIColor *)paragrams[key];
                } else if ([key isEqualToString:LZPageMenuOptionViewBackgroundColor]) {
                    _viewBackgroundColor = paragrams[key];
                } else if ([key isEqualToString:LZPageMenuOptionMenuHeight]) {
                    _menuHeight = [paragrams[key] floatValue];
                } else if ([key isEqualToString:LZPageMenuOptionSelectedMenuItemLabelColor]) {
                    _selectedMenuItemLabelColor = paragrams[key];
                } else if ([key isEqualToString:LZPageMenuOptionUnselectedMenuItemLabelColor]) {
                    _unselectedMenuItemLabelColor = paragrams[key];
                } else if ([key isEqualToString:LZPageMenuOptionMenuItemFont]) {
                    _menuItemFont = paragrams[key];
                } else if ([key isEqualToString:LZPageMenuOptionMenuItemWidth]) {
                    _menuItemWidth = [paragrams[key] floatValue];
                } else if ([key isEqualToString:LZPageMenuOptionScrollAnimationDuration]) {
                    _scrollAnimationDurationOnMenuItemTap = [paragrams[key] integerValue];
                }else if ([key isEqualToString:LZPageMenuOptionDividerBackgroundColor]){
                    _dividerColor = (UIColor *)paragrams[key];
                }
            }
        }
            [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    switch (_showStyle) {
        case LZPageMenuViewTopItemOnlyStyle:
        {
            [self createItemView];
        }
            break;
        case LZPageMenuViewBottomPageOnlyStyle:
        {
            [self createPageMenuView];
        }
            break;
        case LZPageMenuViewNormalStyle:
        {
            [self createItemView];
            [self createPageMenuView];
        }
            break;
        default:
            break;
    }
}


- (void)createItemView{
    if (_scrollMenuBackgroundColor) {
        self.itemMenu.backgroundColor = _scrollMenuBackgroundColor;
    }else{
        self.itemMenu.backgroundColor = [UIColor whiteColor];
    }
    [self addSubview:self.itemMenu];
    for (int i = 0; i < self.ItemControllers.count; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        itemButton.tag = i;
        UIViewController *vc = (UIViewController *)self.ItemControllers[i];
        [itemButton setTitle:vc.title forState:UIControlStateNormal];
        itemButton.adjustsImageWhenHighlighted = NO;
        
        if(_menuItemFont){
            itemButton.titleLabel.font = _menuItemFont;
        }
        
        if (_unselectedMenuItemLabelColor) {
            [itemButton setTitleColor:_unselectedMenuItemLabelColor forState:UIControlStateNormal];
        }else{
            [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if (_selectedMenuItemLabelColor) {
            [itemButton setTitleColor:_selectedMenuItemLabelColor forState:UIControlStateDisabled];
        }else{
            [itemButton setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        }
        
        [itemButton addTarget:self action:@selector(changeToIndex:) forControlEvents:UIControlEventTouchDown];
        [self.itemBtnArray addObject:itemButton];
        [self.itemMenu addSubview:itemButton];
    }
    
    UIView *divider = [UIView new];
    if (_dividerColor) {
        divider.backgroundColor = _dividerColor;
    }else{
        divider.backgroundColor = [UIColor colorWithHex:0xebebeb];
    }
    self.divider = divider;
    [self.itemMenu addSubview:divider];
    
    UIView *indicator = [UIView new];
    if (_selectionIndicatorColor) {
        indicator.backgroundColor = _selectionIndicatorColor;
    }else{
        indicator.backgroundColor = [UIColor orangeColor];
    }
    self.indicator = indicator;
    [self.itemMenu addSubview:indicator];
    
    [self changeToIndex:[self.itemBtnArray firstObject]];
}



- (void)createPageMenuView{
    if (_viewBackgroundColor) {
        self.pageMenu.backgroundColor = _viewBackgroundColor;
    }else{
        self.pageMenu.backgroundColor = [UIColor whiteColor];
    }
    [self addSubview:self.pageMenu];
    if (self.ItemControllers.count > 0) {
        UIViewController *vc = (UIViewController *)[self.ItemControllers firstObject];
        [self.pageMenu addSubview:vc.view];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    switch (_showStyle) {
        case LZPageMenuViewTopItemOnlyStyle:
        {
            [self layoutItemView];
        }
            break;
        case LZPageMenuViewBottomPageOnlyStyle:
        {
            [self layoutPageMenuView];
        }
            break;
        case LZPageMenuViewNormalStyle:
        {
            [self layoutItemView];
            [self layoutPageMenuView];
        }
            break;
        default:
            break;
    }
}

- (void)layoutItemView{
    CGFloat menuHeight = 0;
    CGFloat menuWidth  = 0;
    if (_menuHeight) {
        menuHeight = _menuHeight;
    }else{
        menuHeight = KLZPAGEMENUITEMMEMUDEFAULTHEIGHT;
    }
    
    if (_menuItemWidth) {
        menuWidth = _menuItemWidth;
        if (menuWidth * self.ItemControllers.count <= self.width) {
            // 对于设置的Item宽度总长度比整个pageMenu的宽度还小时，自动设置宽度为pageMenu宽度的均等分
            menuWidth = self.width/self.ItemControllers.count;
        }
    }else{
        menuWidth = self.width/self.ItemControllers.count;
    }
    
    self.itemMenu.frame = CGRectMake(0, 0, self.bounds.size.width, menuHeight);
    self.itemMenu.contentSize = CGSizeMake(self.itemBtnArray.count * menuWidth, 0);
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = menuWidth;
    CGFloat btnH = self.itemMenu.bounds.size.height;
    for (int i = 0; i < self.itemBtnArray.count; i++) {
        UIButton *btn = self.itemBtnArray[i];
        btnX = btnW * i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    self.divider.frame = CGRectMake(0, CGRectGetMaxY(self.itemMenu.frame) - 0.5, CGRectGetWidth(self.itemMenu.frame), 0.5);
    
    CGFloat indicatorWidth = 0;
    CGFloat indicatorHeight = 0;
    if (_selectionIndicatorWidth) {
        indicatorWidth = _selectionIndicatorWidth;
    }else{
        indicatorWidth = menuWidth;
    }
    
    if (_selectionIndicatorHeight) {
        indicatorHeight = _selectionIndicatorHeight;
    }else{
        indicatorHeight = KSELECTIONINDICATORHEIGHT;
    }
    self.indicator.frame = CGRectMake(0, CGRectGetMaxY(self.itemMenu.frame) - indicatorHeight, indicatorWidth, indicatorHeight);
}


- (void)layoutPageMenuView{
    self.pageMenu.frame = CGRectMake(0, CGRectGetMaxY(self.itemMenu.frame), self.frame.size.width, self.frame.size.height - CGRectGetHeight(self.itemMenu.bounds));
    self.pageMenu.contentSize = CGSizeMake(self.frame.size.width * self.ItemControllers.count, 0);
}


- (void)changeToIndex:(UIButton *)itemBtn{
    if (!itemBtn.enabled) return;
    self.lastItemBtn.enabled = YES;
    itemBtn.enabled  = NO;
    self.lastItemBtn = itemBtn;
    CGFloat duration = 0;
    if (_scrollAnimationDurationOnMenuItemTap) {
        duration = _scrollAnimationDurationOnMenuItemTap;
    }else{
        duration = KSCROLLANIMATIONDURATIONONMENUITEM;
    }
    
    [UIView animateWithDuration:duration animations:^{
        self.indicator.x = itemBtn.x;
    }];
    
    if (itemBtn.tag == 0) {
        [self.itemMenu setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if(itemBtn.tag == self.itemBtnArray.count - 1){
        [self.itemMenu setContentOffset:CGPointMake(self.itemMenu.contentSize.width - self.itemMenu.width, 0) animated:YES];
    }else{
        if (self.itemMenu.contentSize.width - itemBtn.centerX >= self.itemMenu.width/2 && itemBtn.centerX >= self.itemMenu.width/2) {
            [self.itemMenu setContentOffset:CGPointMake(itemBtn.centerX - self.itemMenu.width/2, 0) animated:YES];
        }
    }
    [self moveToIndex:itemBtn.tag];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.pageMenu) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        [self changeToIndex:self.itemBtnArray[index]];
    }
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == self.pageMenu) {
        // 当前的索引
        NSInteger index = scrollView.contentOffset.x / scrollView.width;
        // 取出子控制器
        UIViewController *vc = self.ItemControllers[index];
        vc.view.x = scrollView.contentOffset.x;
        // 默认会把y设为20
        vc.view.y = 0;
        // 设置高度
        vc.view.height = scrollView.height;
        // 添加到scrollView
        [scrollView addSubview:vc.view];
    }
}



- (void)moveToIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(pageMenuView:didMoveToIndex:)]) {
        [self.delegate pageMenuView:self didMoveToIndex:index];
    }
    [self.pageMenu setContentOffset:CGPointMake(self.width * index, 0) animated:YES];
}


@end
