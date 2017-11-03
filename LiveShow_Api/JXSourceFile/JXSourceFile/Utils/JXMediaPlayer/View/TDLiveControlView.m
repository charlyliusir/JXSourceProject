//
//  TDLiveControlView.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveControlView.h"
#import <Masonry/Masonry.h>

@interface TDLiveControlView ()
/// 顶部工具条容器视图
@property (nonatomic, strong) UIView *topBarView;
/// 底部工具条容器视图
@property (nonatomic, strong) UIView *bottomBarView;

/// 返回按钮
@property (nonatomic, strong) UIButton *backButton;
/// 直播状态按钮
@property (nonatomic, strong) UIButton *liveStateButton;
/// 观看人数按钮
@property (nonatomic, strong) UIButton *livePeopleButton;
/// 更多按钮
@property (nonatomic, strong) UIButton *liveMoreButton;

/// 播放按钮
@property (nonatomic, strong) UIButton *livePlayButton;
/// 播放时间按钮
@property (nonatomic, strong) UILabel *livePlayTimeLabel;
/// 视频总时间按钮
@property (nonatomic, strong) UILabel *liveTotalTimeLabel;
/// 时间滑条控件
@property (nonatomic, strong) UISlider *liveSlider;
/// 全屏按钮
@property (nonatomic, strong) UIButton *fullScreenButton;

@end

@implementation TDLiveControlView

#pragma mark - top bar subviews

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setTitle:@"< " forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIButton *)liveStateButton
{
    if (!_liveStateButton) {
        _liveStateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_liveStateButton setTitle:@"直播" forState:UIControlStateNormal];
        [_liveStateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _liveStateButton;
}

- (UIButton *)livePeopleButton
{
    if (!_livePeopleButton) {
        _livePeopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_livePeopleButton setTitle:@"People:2683" forState:UIControlStateNormal];
        [_livePeopleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _livePeopleButton;
}

- (UIButton *)liveMoreButton
{
    if (!_liveMoreButton) {
        _liveMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_liveMoreButton setImage:[UIImage imageNamed:@"td_player_share"] forState:UIControlStateNormal];
    }
    return _liveMoreButton;
}

#pragma mark - bottom bar subviews
- (UIButton *)livePlayButton
{
    if (!_livePlayButton) {
        _livePlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_livePlayButton setTitle:@"播放" forState:UIControlStateNormal];
        [_livePlayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _livePlayButton;
}

- (UILabel *)livePlayTimeLabel
{
    if (!_livePlayTimeLabel) {
        _livePlayTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_livePlayTimeLabel setText:@"00:00"];
        [_livePlayTimeLabel setTextColor:[UIColor whiteColor]];
        [_livePlayTimeLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _livePlayTimeLabel;
}

- (UISlider *)liveSlider
{
    if (!_liveSlider) {
        _liveSlider = [[UISlider alloc] initWithFrame:CGRectZero];
        _liveSlider.minimumTrackTintColor = [UIColor greenColor];
        _liveSlider.thumbTintColor = [UIColor orangeColor];
        _liveSlider.minimumValue   = 0;
        _liveSlider.maximumValue   = 1;
        _liveSlider.value          = 0;
    }
    return _liveSlider;
}

- (UILabel *)liveTotalTimeLabel
{
    if (!_liveTotalTimeLabel) {
        _liveTotalTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_liveTotalTimeLabel setText:@"00:00"];
        [_liveTotalTimeLabel setTextColor:[UIColor whiteColor]];
        [_liveTotalTimeLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _liveTotalTimeLabel;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setTitle:@"全屏" forState:UIControlStateNormal];
        [_fullScreenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _fullScreenButton;
}

#pragma mark - 容器视图
- (UIView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[UIView alloc] initWithFrame:CGRectZero];
        [_topBarView setBackgroundColor:[UIColor clearColor]];
        [_topBarView addSubview:self.backButton];
        [_topBarView addSubview:self.liveStateButton];
        [_topBarView addSubview:self.livePeopleButton];
        [_topBarView addSubview:self.liveMoreButton];
    }
    return _topBarView;
}

- (UIView *)bottomBarView
{
    if (!_bottomBarView) {
        _bottomBarView = [[UIView alloc] initWithFrame:CGRectZero];
        [_bottomBarView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.8]];
        [_bottomBarView addSubview:self.livePlayButton];
        [_bottomBarView addSubview:self.livePlayTimeLabel];
        [_bottomBarView addSubview:self.liveSlider];
        [_bottomBarView addSubview:self.liveTotalTimeLabel];
        [_bottomBarView addSubview:self.fullScreenButton];
    }
    return _bottomBarView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topBarView];
        [self addSubview:self.bottomBarView];
        [self setupUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapEv)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)aTapEv {
    self.userInteractionEnabled = NO;
    [self.topBarView setHidden:!self.topBarView.isHidden];
    [self.bottomBarView setHidden:!self.bottomBarView.isHidden];
    self.userInteractionEnabled = YES;
}

- (void)setupTopBarUI
{
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_topBarView).mas_offset(12);
        make.centerY.mas_equalTo(_topBarView);
    }];
    [_liveStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_livePeopleButton.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(_backButton);
    }];
    [_livePeopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_liveMoreButton.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(_backButton);
    }];
    [_liveMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_topBarView).offset(-12);
        make.centerY.mas_equalTo(_backButton);
    }];
}

- (void)setupBottomBarUI
{
    [_livePlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.centerY.mas_equalTo(_bottomBarView);
    }];
    [_livePlayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_livePlayButton.mas_right).mas_offset(12);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
    [_liveSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_livePlayTimeLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(_liveTotalTimeLabel.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
    [_liveTotalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_fullScreenButton.mas_left).offset(-10);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
    [_fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_bottomBarView).offset(-12);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
}

- (void)setupUI
{
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@44);
    }];
    
    [_bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(@33);
    }];
    
    [self setupTopBarUI];
    [self setupBottomBarUI];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)updatePlayedTime:(NSTimeInterval)playedTime {
    float sliderValue = 0;
    if (self.totalPlayTime > 0) {
        sliderValue = playedTime / self.totalPlayTime;
        self.livePlayTimeLabel.text = [self convertToMinutes:playedTime];
    }
    else {
        self.livePlayTimeLabel.text = [self convertToMinutes:0];
    }
    
    [self.liveSlider setValue:sliderValue];
}

- (void)updateTotalPlayTime:(NSTimeInterval)totalPlayTime {
    self.totalPlayTime = totalPlayTime;
    self.liveTotalTimeLabel.text = [self convertToMinutes:totalPlayTime];
}

- (NSString *)convertToMinutes:(NSTimeInterval)seconds {
    NSString *timeStr = [NSString stringWithFormat:@"%02d:%02d", (int)seconds / 60, (int)seconds % 60];
    return timeStr;
}

@end
