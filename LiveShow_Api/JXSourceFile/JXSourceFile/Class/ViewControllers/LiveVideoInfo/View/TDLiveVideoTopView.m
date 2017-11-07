//
//  TDLiveVideoTopView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/26.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoTopView.h"

@interface TDLiveVideoTopView ()
/// 顶部工具条容器视图
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIButton *liveMoreButton;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *playButton;
@end

@implementation TDLiveVideoTopView

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"td_back_icon"] forState:UIControlStateNormal];
        [_backButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    }
    return _backButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setText:@""];
        [_titleLabel setFont:TDFontSize(17)];
        [_titleLabel setTextColor:TDHexStringColor(@"#ffffff")];
    }
    return _titleLabel;
}

- (UIButton *)liveMoreButton
{
    if (!_liveMoreButton) {
        _liveMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_liveMoreButton setImage:[UIImage imageNamed:@"td_player_share"] forState:UIControlStateNormal];
    }
    return _liveMoreButton;
}

- (UIView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[UIView alloc] initWithFrame:CGRectZero];
        [_topBarView setBackgroundColor:[UIColor clearColor]];
        [_topBarView addSubview:self.backButton];
        [_topBarView addSubview:self.titleLabel];
//        [_topBarView addSubview:self.liveMoreButton];
    }
    return _topBarView;
}

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_bgImageView setBackgroundColor:TDHexStringColor(@"#000000")];
        [_bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_bgImageView setUserInteractionEnabled:YES];
    }
    return _bgImageView;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"td_play_icon"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"td_play_icon"] forState:UIControlStateSelected];
    }
    return _playButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.playButton];
        [self addSubview:self.topBarView];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@44);
    }];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topBarView).mas_offset(12);
        make.centerY.mas_equalTo(_topBarView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backButton.mas_right).offset(5);
        make.centerY.mas_equalTo(_backButton);
    }];
//    [_liveMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_topBarView).offset(-12);
//        make.centerY.mas_equalTo(_backButton);
//    }];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)setActivityViewmodel:(TDActivityInfoViewModel *)activityViewmodel
{
    _activityViewmodel = activityViewmodel;
    [_titleLabel setText:_activityViewmodel.model.title];
}

- (void)setModel:(TDLiveClipsViewModel *)model
{
    _model = model;
    NSURL *url;
    if (model.model.photo && (url = [NSURL URLWithString:model.model.photo])) {
        [_bgImageView sd_setImageWithURL:url];
    }
    else {
        NSLog(@"片段封面图片不存在哦！！！");
    }
}

@end
