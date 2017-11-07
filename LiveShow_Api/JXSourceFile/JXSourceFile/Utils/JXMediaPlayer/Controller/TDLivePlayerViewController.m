//
//  TDLivePlayerViewController.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLivePlayerViewController.h"
#import "TDLiveControlView.h"
#import "TDLiveClipsViewModel.h"


@interface TDLivePlayerViewController ()
@property (nonatomic, strong) TDLiveControlView *controlView;
/// 返回按钮
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) NSTimeInterval     playedTime;

@property (nonatomic, assign) BOOL isClickBackButton;

@end

@implementation TDLivePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.controlView];
    [self.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
    [self setupUI];
}

- (void)setupUI
{
    [_controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)reload:(NSURL *)aUrl
{
    [super reload:aUrl];
    [_controlView showControlUI:NO];
    [self.controlView.activityView startAnimating];
}

#pragma mark - 通知
-(void)handlePlayerNotify:(NSNotification*)notify
{
    if (!self.player) {
        return;
    }
    if (MPMediaPlaybackIsPreparedToPlayDidChangeNotification ==  notify.name) {
        [self.controlView updateTotalPlayTime:self.player.duration];
        if(self.player.shouldAutoplay == NO) {
            [self.player play];
            [_controlView showControlUI:YES];
        }
        [self.controlView.activityView stopAnimating];
    }
    else if (MPMoviePlayerPlaybackStateDidChangeNotification == notify.name) {
        [self.controlView.livePlayButton setSelected:self.player.playbackState == MPMoviePlaybackStatePlaying];
    }
    else if (MPMoviePlayerLoadStateDidChangeNotification == notify.name) {
        if (self.player.loadState == MPMovieLoadStateStalled) {
            [self.controlView.activityView startAnimating];
        }
        else if (self.player.loadState == MPMovieLoadStatePlayable) {
            [self.controlView.activityView stopAnimating];
        }
        else if (self.player.loadState == MPMovieLoadStatePlaythroughOK) {
            [self.controlView.activityView stopAnimating];
        }
        else {
            [self.controlView.activityView stopAnimating];
        }
    }
    [self notifyHandler:notify];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if([keyPath isEqual:@"currentPlaybackTime"]) {
        self.playedTime = self.player.currentPlaybackTime;
        [self.controlView updatePlayedTime:_playedTime];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 点击返回按钮
 
 @param backButton 返回按钮
 */
- (void)onClickLiveBackAction:(UIButton *)backButton
{
    if (self.comeBackHandler) {
        self.comeBackHandler(self.viewmodel, self, self.fullScreen);
    }
    [self setIsClickBackButton:YES];
    [self onClickFullScreenAction:_controlView.fullScreenButton];
}

/**
 点击播放按钮
 
 @param playButton 播放按钮
 */
- (void)onClickLivePlayAction:(UIButton *)playButton
{
    if ((self.player.playbackState == MPMoviePlaybackStateStopped) || (self.player.playbackState == MPMoviePlaybackStatePaused)) {
        [self.player play];
    }
    else {
        [self.player pause];
    }
}

- (void)onClickFullScreenAction:(UIButton *)fullButton
{
    [fullButton setSelected:!fullButton.isSelected];
    /// 这里需要价格判断
    if (!_isClickBackButton) {
        [self.viewmodel fullScreenButtonClickedHandlerForVodPlayController:self isFullScreen:fullButton.isSelected];
    }
    /// 将标志初始化
    [self setIsClickBackButton:NO];
}

/**
 播放器时间滑条发生变化
 
 @param playSlider 播放器滑条
 */
- (void)playSliderUpdateValue:(UISlider *)playSlider
{
    /// 视频为直播视频不能拖拽
    if (self.controlView.totalPlayTime > 0 && self.player.isPlaying) {
        double seekPos = playSlider.value * self.player.duration;
        [self.player seekTo:seekPos accurate:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (TDLiveControlView *)controlView
{
    if (!_controlView) {
        _controlView = [[TDLiveControlView alloc] initWithFrame:CGRectZero];
        [_controlView.backButton addTarget:self action:@selector(onClickLiveBackAction:) forControlEvents:UIControlEventTouchUpInside];
        [_controlView.livePlayButton addTarget:self action:@selector(onClickLivePlayAction:) forControlEvents:UIControlEventTouchUpInside];
        [_controlView.fullScreenButton addTarget:self action:@selector(onClickFullScreenAction:) forControlEvents:UIControlEventTouchUpInside];
        [_controlView.liveSlider addTarget:self action:@selector(playSliderUpdateValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _controlView;
}

- (void)setInfoVM:(TDLiveInfoViewModel *)infoVM
{
    _infoVM = infoVM;
    [self.controlView.livePeopleButton setTitle:_infoVM.onLinePeople forState:UIControlStateNormal];
    [self.controlView.liveStateButton setSelected:!_infoVM.isLiving];
}

- (void)setViewmodel:(TDActivityInfoViewModel *)viewmodel
{
    _viewmodel = viewmodel;
    [self.controlView.titleLabel setText:_viewmodel.model.title];
}

- (void)setVideoVM:(TDLiveClipsViewModel *)videoVM
{
    _videoVM = videoVM;
    NSURL *url;
    if (videoVM.model.url && (url = [NSURL URLWithString:videoVM.model.url])) {
        [self reload:url];
    }
    else {
        NSLog(@"--------------视频地址错位！！！");
    }
}

@end
