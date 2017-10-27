//
//  CLTapBarView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "CLTapBarView.h"
#import <Masonry/Masonry.h>
#import "CLTabBarButtonItem.h"

@interface CLTapBarView ()
@property (nonatomic, strong) NSMutableArray * tapBarItems;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIButton * showView;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *scrollLineView;

@end

@implementation CLTapBarView

- (void)setSelectBarItem:(NSUInteger)selectBarItem
{
    /// 将之前选中选项设置成未选中状态
    CLTabBarButtonItem * selectBarButtonItem = _tapBarItems[_selectBarItem];
    [selectBarButtonItem setIsSelected:NO];
    
    _selectBarItem = selectBarItem;
    /// 将之前选中选项设置成未选中状态
    selectBarButtonItem = _tapBarItems[_selectBarItem];
    [selectBarButtonItem setIsSelected:YES];
    [self setupUIBarItems];
    
    /// 通知点击事件
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBarItem:withIndex:)]) {
        [_delegate didClickBarItem:self withIndex:(int)self.selectBarItem];
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CLTapBarViewWidth, CLTapBarItemHeight)];
        _scrollView.contentSize = CGSizeMake(CLTapBarViewWidth, CLTapBarItemHeight);
    }
    return _scrollView;
}

- (UIButton *)showView
{
    if (!_showView) {
        _showView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_showView setBackgroundImage:[UIImage imageNamed:@"td_select_arrow"] forState:UIControlStateNormal];
    }
}

- (UIView *)scrollLineView
{
    if (!_scrollLineView) {
        _scrollLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CLTapBarItemHeight  -CLTapBarItemScrollLineHeight, CLTapBarViewWidth, CLTapBarItemScrollLineHeight)];
    }
    return _scrollLineView;
}

- (UIView *)bottomLineView
{
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, CLTapBarItemHeight  -CLTapBarItemLineHeight, CLTapBarViewWidth, CLTapBarItemLineHeight)];
        [_bottomLineView setBackgroundColor:[UIColor colorWithHexString:CLTapBarLineViewColor]];
    }
    return _bottomLineView;
}

- (NSMutableArray *)tapBarItems
{
    if (!_tapBarItems) {
        _tapBarItems = [NSMutableArray array];
    }
    return _tapBarItems;
}

- (void)setBarItems:(NSMutableArray *)barItems
{
    
    if (barItems.count <= 0) {
        return;
    }
    
    _barItems = barItems;
    
    for (UIView *subView in self.tapBarItems) {
        [subView removeFromSuperview];
    }
    
    [self.tapBarItems removeAllObjects];
    /// 添加视图
    for (CLTapBarItem *barItem in barItems) {
        CLTabBarButtonItem *tabBarButtonItem = [[CLTabBarButtonItem alloc] init];
        [tabBarButtonItem setTitleLabelText:barItem.title withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelText:barItem.title withBarState:CLTabBarButtonItemStateSelected];
        [tabBarButtonItem setTitleLabelFont:_barTitleFont withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelFont:_barTitleTintFont withBarState:CLTabBarButtonItemStateSelected];
        [tabBarButtonItem setTitleLabelTextColor:_barTitleColor withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelTextColor:_barTitleTintColor withBarState:CLTabBarButtonItemStateSelected];
        if (self.tapBarItems.count == 0) {
            tabBarButtonItem.isSelected = true;
        }
        else {
            tabBarButtonItem.isSelected = false;
        }
        
        [tabBarButtonItem addTarget:self action:@selector(onClickTapBarItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:tabBarButtonItem];
        [self.tapBarItems addObject:tabBarButtonItem];
    }
    
    [self setupUIBarItems];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupTapBarViewConfigure];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.scrollLineView];
        [self addSubview:self.bottomLineView];
    }
    return self;
}

- (void)setupTapBarViewConfigure
{
    self.barTintColor  = [UIColor colorWithHexString:CLTapBarTintColor];
    self.barTitleColor = [UIColor colorWithHexString:CLTapBarTitleColor_Normal];
    self.barTitleTintColor = [UIColor colorWithHexString:CLTapBarTitleColor_Selected];
    self.barTitleFont      = [UIFont systemFontOfSize:CLTapBarTitleFont_Normal];
    self.barTitleTintFont = [UIFont systemFontOfSize:CLTapBarTitleFont_Selected];
    [self setBackgroundColor:self.barTintColor];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setBarItem:(CLTapBarItem *)barItem
{
    if (!self.barItems) {
        self.barItems = [NSMutableArray array];
    }
    
    if ([self.barItems containsObject:barItem]) {
        NSUInteger index = [self.barItems indexOfObject:barItem];
        CLTabBarButtonItem *tabBarButtonItem = [_tapBarItems objectAtIndex:index];
        [tabBarButtonItem setTitleLabelText:barItem.title withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelText:barItem.title withBarState:CLTabBarButtonItemStateSelected];
    }
    else {
        [self.barItems addObject:barItem];
        CLTabBarButtonItem *tabBarButtonItem = [[CLTabBarButtonItem alloc] init];
        [tabBarButtonItem setTitleLabelText:barItem.title withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelText:barItem.title withBarState:CLTabBarButtonItemStateSelected];
        [tabBarButtonItem setTitleLabelFont:_barTitleFont withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelFont:_barTitleTintFont withBarState:CLTabBarButtonItemStateSelected];
        [tabBarButtonItem setTitleLabelTextColor:_barTitleColor withBarState:CLTabBarButtonItemStateNormal];
        [tabBarButtonItem setTitleLabelTextColor:_barTitleTintColor withBarState:CLTabBarButtonItemStateSelected];
        if (self.tapBarItems.count == 0) {
            tabBarButtonItem.isSelected = true;
        }
        else {
            tabBarButtonItem.isSelected = false;
        }
        
        [tabBarButtonItem addTarget:self action:@selector(onClickTapBarItem:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:tabBarButtonItem];
        [self.tapBarItems addObject:tabBarButtonItem];
    }
    
    [self setupUIBarItems];
}

- (CGFloat)textSizeWidth: (NSString *)text withFontSize: (UIFont *)font
{
    return [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CLTapBarItemHeight) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size.width + 2;
}

- (void)setupUIBarItems
{
    if (self.tapBarItems.count == 0) {
        NSLog(@"Error : 没有更多的");
        return;
    }
    
    CLTabBarButtonItem *lastTabBarButtonItem = nil;
    
    for (CLTabBarButtonItem *tapBarButtonItem in self.tapBarItems) {
        
        CGFloat width = [self textSizeWidth:tapBarButtonItem.titleLabel.text withFontSize:tapBarButtonItem.titleLabel.font];
        
        if (lastTabBarButtonItem) {
            [tapBarButtonItem setFrame:CGRectMake(CGRectGetMaxX(lastTabBarButtonItem.frame) + CLTapBarItemMarginMaxX, 0, width, CLTapBarItemHeight)];
        }
        else {
            [tapBarButtonItem setFrame:CGRectMake(CLTapBarItemMarginX, 0, width, CLTapBarItemHeight)];
        }
        [tapBarButtonItem updateUILayout];
        lastTabBarButtonItem = tapBarButtonItem;
    }
    /// 获取当前选中项
    CLTabBarButtonItem * selectBarButtonItem = _tapBarItems[_selectBarItem];
    CGRect rect = _scrollLineView.frame;
    rect.origin.x = selectBarButtonItem.frame.origin.x;
    rect.size.width = selectBarButtonItem.frame.size.width;
    _scrollLineView.frame = rect;
    _scrollLineView.backgroundColor = selectBarButtonItem.titleLabel.textColor;
    /// 设置滚动视图滚动的范围
    [_scrollView setContentSize:CGSizeMake(CGRectGetMaxX(lastTabBarButtonItem.frame) + CLTapBarItemMarginX, CLTapBarItemHeight)];
}

- (void)onClickTapBarItem:(CLTabBarButtonItem *)tapBarButtonItem
{
    /// 如果当前选项处于被选中状态, 则跳过这次操作
    if (tapBarButtonItem.isSelected) {
        return;
    }
    /// 重新更新选中项
    self.selectBarItem = [_tapBarItems indexOfObject:tapBarButtonItem];
}

@end
