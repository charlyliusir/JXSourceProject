//
//  CLTabBarButtonItem.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "CLTabBarButtonItem.h"
#import <Masonry/Masonry.h>
#import "CLTapBarButtonItemModel.h"

@interface CLTabBarButtonItem ()

@property (nonatomic, readwrite, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSMutableDictionary *barModel;

@end

@implementation CLTabBarButtonItem

- (NSMutableDictionary *)barModel
{
    if (!_barModel) {
        _barModel = @{
                      @(CLTabBarButtonItemStateNormal) : [[CLTapBarButtonItemModel alloc] init],
                      @(CLTabBarButtonItemStateSelected) : [[CLTapBarButtonItemModel alloc] init]
                      }.mutableCopy;
    }
    return _barModel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self setupUILayout];
    }
    
    return self;
}

- (void)setTitleLabelText: (NSString *)text withBarState: (CLTabBarButtonItemState)barState
{
    CLTapBarButtonItemModel * model = self.barModel[@(barState)];
    model.title = text;
}

- (void)setTitleLabelFont: (UIFont *)font withBarState: (CLTabBarButtonItemState)barState
{
    CLTapBarButtonItemModel * model = self.barModel[@(barState)];
    model.font = font;
}

- (void)setTitleLabelTextColor: (UIColor *)color withBarState: (CLTabBarButtonItemState)barState
{
    CLTapBarButtonItemModel * model = self.barModel[@(barState)];
    model.color = color;
}

- (void)setIsSelected:(BOOL)isSelected
{
    CLTapBarButtonItemModel * model = self.barModel[@(isSelected)];
    _titleLabel.text = model.title;
    _titleLabel.font = model.font;
    _titleLabel.textColor = model.color;
}

- (void)setupUILayout
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)updateUILayout
{
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
