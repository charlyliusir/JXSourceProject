//
//  TDLiveVideoTopView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/26.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoTopView.h"

@interface TDLiveVideoTopView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *playButton;
@end

@implementation TDLiveVideoTopView

- (UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_bgImageView setBackgroundColor:TDHexStringColor(@"#ff00ff")];
        [_bgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_bgImageView setUserInteractionEnabled:YES];
    }
    return _bgImageView;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitleColor:TDHexStringColor(@"#ffffff") forState:UIControlStateNormal];
    }
    return _playButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgImageView];
        [self addSubview:self.playButton];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
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

@end
