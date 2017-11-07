//
//  TDLiveControlView.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveControlView.h"
#import "UpdateVolumeAndBrightView.h"
#import <Masonry/Masonry.h>

@interface TDLiveControlView ()
/// 顶部工具条容器视图
@property (nonatomic, strong) UIView *topBarView;
/// 底部工具条容器视图
@property (nonatomic, strong) UIView *bottomBarView;
/// 中间图层
@property (nonatomic, strong) UIView *bodyBarView;

/// 返回按钮
@property (nonatomic, strong) UIButton *backButton;
/// 直播标题
@property (nonatomic, strong) UILabel  *titleLabel;
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
///
@property (nonatomic, strong) UpdateVolumeAndBrightView *volumeBrightControlView;
/// 缓冲
@property (nonatomic, readwrite, strong) UIActivityIndicatorView *activityView;

@end

@implementation TDLiveControlView

#pragma mark - top bar subviews
- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    }
    return _activityView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"td_back_icon"] forState:UIControlStateNormal];
        [_backButton setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
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

- (UIButton *)liveStateButton
{
    if (!_liveStateButton) {
        _liveStateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_liveStateButton setImage:[UIImage imageNamed:@"td_player_living"] forState:UIControlStateNormal];
        [_liveStateButton setImage:[UIImage imageNamed:@"td_player_back"] forState:UIControlStateSelected];
    }
    return _liveStateButton;
}

- (UIButton *)livePeopleButton
{
    if (!_livePeopleButton) {
        _livePeopleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_livePeopleButton setImage:[UIImage imageNamed:@"td_player_people"] forState:UIControlStateNormal];
         [_livePeopleButton setImage:[UIImage imageNamed:@"td_player_people"] forState:UIControlStateSelected];
        [_livePeopleButton setTitle:@"2683" forState:UIControlStateNormal];
        [_livePeopleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_livePeopleButton setContentEdgeInsets:UIEdgeInsetsMake(4, 5, 4, 5)];
        [_livePeopleButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
        [_livePeopleButton.titleLabel setFont:TDFontSize(10)];
        [_livePeopleButton.layer setMasksToBounds:YES];
        [_livePeopleButton.layer setBorderColor:TDHexStringColor(@"#ffffff").CGColor];
        [_livePeopleButton.layer setBorderWidth:1];
        [_livePeopleButton.layer setCornerRadius:4];
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
        [_livePlayButton setImage:[UIImage imageNamed:@"td_player_play"] forState:UIControlStateNormal];
        [_livePlayButton setImage:[UIImage imageNamed:@"td_player_pause"] forState:UIControlStateSelected];
        [_livePlayButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
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
        _liveSlider.minimumTrackTintColor = [UIColor whiteColor];
        _liveSlider.thumbTintColor = [UIColor whiteColor];
        [_liveSlider setThumbImage:[UIImage imageNamed:@"td_player_slider_point"] forState:UIControlStateNormal];
        [_liveSlider setThumbImage:[UIImage imageNamed:@"td_player_slider_point"] forState:UIControlStateSelected];
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
        [_fullScreenButton setImage:[UIImage imageNamed:@"td_player_fullscreen_normal"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"td_player_fullscreen_selected"] forState:UIControlStateSelected];
        [_fullScreenButton setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    }
    return _fullScreenButton;
}

- (UpdateVolumeAndBrightView *)volumeBrightControlView {
    if (!_volumeBrightControlView) {
        _volumeBrightControlView = [[UpdateVolumeAndBrightView alloc] init];
    }
    return _volumeBrightControlView;
}

#pragma mark - 容器视图
- (UIView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[UIView alloc] initWithFrame:CGRectZero];
        [_topBarView setBackgroundColor:[UIColor clearColor]];
        [_topBarView addSubview:self.titleLabel];
        [_topBarView addSubview:self.liveStateButton];
        [_topBarView addSubview:self.livePeopleButton];
//        [_topBarView addSubview:self.liveMoreButton];
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

- (UIView *)bodyBarView
{
    if (!_bodyBarView) {
        _bodyBarView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bodyBarView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topBarView];
        [self addSubview:self.bottomBarView];
        [self addSubview:self.bodyBarView];
        [self addSubview:self.backButton];
        [self.bodyBarView addSubview:self.activityView];
        [self.bodyBarView addSubview:self.volumeBrightControlView];
        [self setupUI];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aTapEv)];
        [self.bodyBarView addGestureRecognizer:tap];
//        UISwip
        [self.activityView startAnimating];
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
        make.left.mas_equalTo(_topBarView).mas_offset(2);
        make.centerY.mas_equalTo(_topBarView);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_backButton.mas_right).offset(5);
        make.centerY.mas_equalTo(_backButton);
    }];
    [_liveStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_livePeopleButton.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(_backButton);
    }];
    [_livePeopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_topBarView).offset(-12);
        make.centerY.mas_equalTo(_backButton);
    }];
//    [_liveMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_topBarView).offset(-12);
//        make.centerY.mas_equalTo(_backButton);
//    }];
}

- (void)setupBottomBarUI
{
    [_livePlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(2);
        make.centerY.mas_equalTo(_bottomBarView);
    }];
    [_livePlayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_livePlayButton.mas_right);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
    [_liveSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_livePlayTimeLabel.mas_right).mas_offset(10);
        make.right.mas_equalTo(_liveTotalTimeLabel.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
    [_liveTotalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_fullScreenButton.mas_left);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
    [_fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_bottomBarView).offset(-2);
        make.centerY.mas_equalTo(_livePlayButton);
    }];
}

- (void)setupUI
{
    [_topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@44);
    }];
    
    [_bodyBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_topBarView.mas_bottom);
        make.bottom.mas_equalTo(_bottomBarView.mas_top);
    }];
    
    [_bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(@33);
    }];
    [self.volumeBrightControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bodyBarView);
    }];
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bodyBarView);
    }];
    
    [self setupTopBarUI];
    [self setupBottomBarUI];
}

- (void)showControlUI:(BOOL)hidden
{
    [self.topBarView setHidden:!hidden];
    [self.bottomBarView setHidden:!hidden];
    [self.volumeBrightControlView setHidden:!hidden];
    [self.bodyBarView setUserInteractionEnabled:hidden];
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
