//
//  TDLiveSuspendView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveSuspendView.h"

@interface TDLiveSuspendView()
@property (nonatomic, strong) NSMutableArray *itemLists;
@end

@implementation TDLiveSuspendView

- (NSMutableArray *)itemLists
{
    if (!_itemLists) {
        _itemLists = [NSMutableArray array];
    }
    return _itemLists;
}

+ (CGFloat)paddingY
{
    return 10;
}

- (instancetype)initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        [self setItems:items];
    }
    return self;
}

+ (instancetype)liveSuspendWithItems:(NSArray *)items
{
    return [[self alloc] initWithItems:items];
}

- (void)setItems:(NSArray *)items
{
    /// 移除所有视图
    for (TDLiveSuspendItemView *itemView in self.itemLists) {
        [itemView removeFromSuperview];
    }
    /// 移除所有对象
    [self.itemLists removeAllObjects];
    /// 设置视图
    for (TDLiveSuspendItemView *itemView in items) {
        [self setItemView:itemView];
    }
}

- (void)setItemView:(TDLiveSuspendItemView *)view
{
    [self addSubview:view];
    /// 从下网上布局
    if (self.itemLists.count <= 0) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(self);
            make.width.height.mas_equalTo(@44);
        }];
    }
    else {
        TDLiveSuspendItemView *lastItemView = self.itemLists.lastObject;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self);
            make.bottom.mas_equalTo(lastItemView.mas_top).mas_offset(-TDLiveSuspendView.paddingY);
            make.width.height.mas_equalTo(@44);
        }];
    }
    
    [self.itemLists addObject:view];
}

@end
