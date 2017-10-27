//
//  TDLiveIntroView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveIntroView.h"
@interface TDLiveIntroView()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introLabel;
@end

@implementation TDLiveIntroView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.lineView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.introLabel];
        [self setupUI];
    }
    return self;
}

- (void)setViewmodel:(TDActivityInfoViewModel *)viewmodel
{
    _viewmodel = viewmodel;
    [_introLabel setAttributedText:[_viewmodel summaryAttributedString]];
    [_nameLabel setText:_viewmodel.model.name];}

- (void)setupUI
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.introLabel);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(15);
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(8);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_nameLabel);
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.width.mas_equalTo(2);
        make.height.mas_equalTo(_nameLabel);
    }];
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(15);
        make.width.mas_equalTo(TD_SCREEN_WIDTH-68-15);
    }];
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [_contentView setBackgroundColor:[UIColor clearColor]];
    }
    return _contentView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        [_lineView setBackgroundColor:TDHexStringColor(@"#1b9ed4")];
    }
    return _lineView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_nameLabel setFont:TDFontSize(18)];
        [_nameLabel setTextColor:TDHexStringColor(@"#222222")];
    }
    return _nameLabel;
}

- (UILabel *)introLabel
{
    if (!_introLabel) {
        _introLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_introLabel setFont:TDFontSize(18)];
        [_introLabel setTextColor:TDHexStringColor(@"#707070")];
        [_introLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_introLabel setNumberOfLines:0];
    }
    return _introLabel;
}

@end
