//
//  CLTapViewController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "CLTapViewController.h"
#import "CLTapViewControllerProtocol.h"
#import "CLTapBarView.h"

@interface CLTapViewController () <UIScrollViewDelegate, CLTapBarViewDelegate>
@property (nonatomic, strong) CLTapBarView *tapBarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewcontrollers;

@end

@implementation CLTapViewController

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat originY = CGRectGetMaxY(self.tapBarView.frame);
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, originY, CLTapBarViewWidth, CLTapBarViewHeight - originY)];
        _scrollView.contentSize = CGSizeMake(CLTapBarViewWidth, CLTapBarViewHeight - originY);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (CLTapBarView *)tapBarView
{
    if (!_tapBarView) {
        _tapBarView = [[CLTapBarView alloc] initWithFrame:CGRectMake(0, 0, CLTapBarViewWidth, CLTapBarItemHeight)];
        _tapBarView.delegate = self;
    }
    return _tapBarView;
}

- (NSMutableArray *)viewcontrollers
{
    if (!_viewcontrollers) {
        _viewcontrollers = [NSMutableArray array];
    }
    return _viewcontrollers;
}

- (void)setBarItems:(NSMutableArray *)barItems
{
    _barItems = barItems;
    _tapBarView.barItems = barItems;
    
    for (UIViewController *vc in self.viewcontrollers) {
        [vc.view removeFromSuperview];
    }
    [self.viewcontrollers removeAllObjects];
    /// 重新布局
    CGFloat height = self.scrollView.frame.size.height;
    for (NSUInteger i = 0; i < barItems.count ; i ++) {
        CLTapBarItem *tapBarItem = barItems[i];
        UIViewController *viewcontroller = tapBarItem.controller;
        viewcontroller.view.frame = CGRectMake(CLTapBarViewWidth * i, 0, CLTapBarViewWidth, height);
        [self.scrollView addSubview:viewcontroller.view];
        [self.viewcontrollers addObject:viewcontroller];
        /// 更新 UI
        id <CLTapViewControllerProtocol> protocol = (id <CLTapViewControllerProtocol>)viewcontroller;
        [protocol didUpdateViewUI];
    }
    
    self.selectBarItem = 0;
    UIViewController *lastViewController = [self.viewcontrollers lastObject];
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(lastViewController.view.frame), height)];
}

- (void)setSelectBarItem:(NSUInteger)selectBarItem
{
    _selectBarItem = selectBarItem;
    _tapBarView.selectBarItem = selectBarItem;
    [self didSelectViewController];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.tapBarView];
        [self addSubview:self.scrollView];
        [self.tapBarView.showView addTarget:self action:@selector(onClickOtherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGFloat originY = CGRectGetMaxY(self.tapBarView.frame);
    UIViewController *lastViewController = [self.viewcontrollers lastObject];
    
    [_scrollView setFrame:CGRectMake(0, originY, CLTapBarViewWidth, CLTapBarViewHeight - originY)];
    [_scrollView setContentSize:CGSizeMake(CGRectGetMaxX(lastViewController.view.frame), CLTapBarViewHeight - originY)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds   = self.bounds;
    bounds.origin.y = 0;
    self.bounds     = bounds;
}

- (void)setOtherButtonHidden:(BOOL)hidden
{
    if (_tapBarView && _tapBarView.showView) {
        [_tapBarView.showView setHidden:hidden];
    }
}

- (void)setHandler:(onClickOtherButtonHandler)handler
{
    _handler = handler;
}

- (void)onClickOtherButtonAction:(UIButton *)button
{
    [button setSelected:!button.isSelected];
    if (_handler) {
        _handler(!button.selected);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - UIScroll Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / self.frame.size.width;
    self.selectBarItem = index;
}

#pragma mark - CLTapBarView Delegate
- (void)didClickBarItem:(id)barItem withIndex:(int)index
{
    _selectBarItem = index;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    CGFloat originY = CGRectGetMaxY(self.tapBarView.frame);
    [self.scrollView scrollRectToVisible:CGRectMake(width*index, originY, width, height) animated:YES];
    
    [self didSelectViewController];
}

#pragma mark - UIViewController method
- (void)didSelectViewController
{
    /// 点击选项卡或者滚动页面
    id <CLTapViewControllerProtocol> protocol = self.viewcontrollers[_selectBarItem];
    [protocol willCanLoadData:protocol.isLoading];
    protocol.isLoading = YES;
}

@end
