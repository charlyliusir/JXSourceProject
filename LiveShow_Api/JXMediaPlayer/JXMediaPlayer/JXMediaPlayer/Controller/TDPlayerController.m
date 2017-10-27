//
//  TDPlayerController.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDPlayerController.h"
#import "TDPlayerSetting.h"

@interface TDPlayerController ()
/// 重新播放地址
@property (nonatomic, strong) NSURL                     *reloadUrl;
/// 金山云网络监听
@property (nonatomic, strong) KSYReachability           *reach;
/// 金山云网络监听状态
@property (nonatomic, assign) KSYNetworkStatus           preStatue;
/// 当前时间 毫秒
@property (nonatomic, assign) int64_t   prepared_time;
/// 第一帧视频花费时间
@property (nonatomic, assign) int                        fvr_costtime;
/// 第一帧音频花费时间
@property (nonatomic, assign) int                        far_costtime;
/// 重播状态
@property (nonatomic, assign) BOOL                       reloading;

@end

@implementation TDPlayerController

- (instancetype)initWithVideoUrl: (NSURL *)videoUrl
{
    if (self = [super init]) {
        _reloadUrl = videoUrl;
    }
    return self;
}

+ (instancetype)playerWithVideoUrl: (NSURL *)videoUrl
{
    return [[self alloc] initWithVideoUrl:videoUrl];
}

- (instancetype)initWithVideoUrlString: (NSString *)videoUrlString
{
    return [self initWithVideoUrl:[NSURL URLWithString:videoUrlString]];
}

+ (instancetype)playerWithVideoUrlString: (NSString *)videoUrlString
{
    return [self playerWithVideoUrl:[NSURL URLWithString:videoUrlString]];
}

- (void)dealloc {
    /// 停止播放
    [self.player stop];
    /// 移除观察者
    [self.player removeObserver:self forKeyPath:@"currentPlaybackTime"];
    [self removeObserver:self forKeyPath:@"player"];
    /// 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addObservers];
    [self addNotification];
    [self registeOtherConfig];
    [self setupPlayer];
}

#pragma mark - 注册观察者
- (void)addObservers
{
    // statistics update every seconds
    [self addObserver:self forKeyPath:@"player" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - 注册通知
- (void)addNotification
{
    /// 添加网络改变监听
    [[NSNotificationCenter defaultCenter] addObserver:self
           selector:@selector(netWorkChange)
               name:kKSYReachabilityChangedNotification
             object:nil];
}

#pragma mark - 其他配置
- (void)registeOtherConfig
{
    /// 开启网络监听
    _reach = [KSYReachability reachabilityWithHostName:@"http://www.kingsoft.com"];
    [_reach startNotifier];
}

#pragma mark - 初始化播放器
- (void)setupPlayer {
    //初始化播放器并设置播放地址
    self.player = [[KSYMoviePlayerController alloc] initWithContentURL: _reloadUrl fileList:nil sharegroup:nil];
    [self setupObservers:_player];
    _player.controlStyle = MPMovieControlStyleNone;
    [self.view addSubview:_player.view];
    [_player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    /// 配置基本信息
    TDPlayerSetting *settingModel = [TDPlayerSetting defaultSetting];
    _player.videoDecoderMode = settingModel.videoDecoderMode;
    _player.shouldLoop = settingModel.shouldLoop;
    _player.bufferTimeMax = settingModel.bufferTimeMax;
    _player.bufferSizeMax = settingModel.bufferSizeMax;
    _player.shouldAutoplay = settingModel.shouldAutoplay;
    [_player setTimeout:(int)settingModel.preparetimeOut readTimeout:(int)settingModel.readtimeOut];
    
    /// 监听播放时间
    NSKeyValueObservingOptions opts = NSKeyValueObservingOptionNew;
    [_player addObserver:self forKeyPath:@"currentPlaybackTime" options:opts context:nil];
    self.prepared_time = (long long int)([[NSDate date] timeIntervalSince1970] * 1000);
    [_player prepareToPlay];
}

- (void)registerObserver:(NSString *)notification player:(KSYMoviePlayerController*)player {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handlePlayerNotify:)
                                                 name:(notification)
                                               object:player];
}

- (void)setupObservers:(KSYMoviePlayerController*)player {
    [self registerObserver:MPMediaPlaybackIsPreparedToPlayDidChangeNotification player:player];
    [self registerObserver:MPMoviePlayerPlaybackStateDidChangeNotification player:player];
    [self registerObserver:MPMoviePlayerPlaybackDidFinishNotification player:player];
    [self registerObserver:MPMoviePlayerLoadStateDidChangeNotification player:player];
    [self registerObserver:MPMovieNaturalSizeAvailableNotification player:player];
    [self registerObserver:MPMoviePlayerFirstVideoFrameRenderedNotification player:player];
    [self registerObserver:MPMoviePlayerFirstAudioFrameRenderedNotification player:player];
    [self registerObserver:MPMoviePlayerSuggestReloadNotification player:player];
    [self registerObserver:MPMoviePlayerPlaybackStatusNotification player:player];
    [self registerObserver:MPMoviePlayerNetworkStatusChangeNotification player:player];
    [self registerObserver:MPMoviePlayerSeekCompleteNotification player:player];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
}

#pragma mark -
#pragma mark - public method

- (void)reload:(NSURL *)aUrl {
    [_player reset:NO];
    [_player setUrl:aUrl];
    [_player prepareToPlay];
}

#pragma mark - 通知方法实现
///
// 网络状态改变
///
- (void)netWorkChange
{
    KSYNetworkStatus currentStatus = [_reach currentReachabilityStatus];
    if (currentStatus == _preStatue) {
        return;
    }
    _preStatue = currentStatus;
    switch (currentStatus) {
        case KSYNotReachable:
            _networkStatus = @"无网络";
            break;
        case KSYReachableViaWWAN:
            _networkStatus = @"移动网络";
            break;
        case KSYReachableViaWiFi:
            _networkStatus = @"WIFI";
            break;
        default:
            return;
    }
    if( _onNetworkChange ){
        _onNetworkChange(_networkStatus);
    }
}

- (void)notifyHandler:(NSNotification*)notify {
    if (!_player) {
        return;
    }
    if (MPMediaPlaybackIsPreparedToPlayDidChangeNotification ==  notify.name) {
        if(_player.shouldAutoplay == NO)
            [_player play];
        NSLog(@"KSYPlayerVC: %@ -- ip:%@", [[_player contentURL] absoluteString], [_player serverAddress]);
        self.reloading = NO;
    }
    if (MPMoviePlayerPlaybackStateDidChangeNotification ==  notify.name) {
        NSLog(@"------------------------");
        NSLog(@"player playback state: %ld", (long)_player.playbackState);
        NSLog(@"------------------------");
    }
    if (MPMoviePlayerLoadStateDidChangeNotification ==  notify.name) {
        NSLog(@"player load state: %ld", (long)_player.loadState);
        if (MPMovieLoadStateStalled & _player.loadState) {
            NSLog(@"player start caching");
        }
        
        if (_player.bufferEmptyCount &&
            (MPMovieLoadStatePlayable & _player.loadState ||
             MPMovieLoadStatePlaythroughOK & _player.loadState)){
                //                NSLog(@"player finish caching");
                //                NSString *message = [[NSString alloc]initWithFormat:@"loading occurs, %d - %0.3fs",
                //                                     (int)_player.bufferEmptyCount,
                //                                     _player.bufferEmptyDuration];
                //                [self toast:message];
            }
    }
    if (MPMoviePlayerPlaybackDidFinishNotification ==  notify.name) {
        NSLog(@"player finish state: %ld", (long)_player.playbackState);
        NSLog(@"player download flow size: %f MB", _player.readSize);
        NSLog(@"buffer monitor  result: \n   empty count: %d, lasting: %f seconds",
              (int)_player.bufferEmptyCount,
              _player.bufferEmptyDuration);
        //结束播放的原因
        int reason = [[[notify userInfo] valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
        if (reason ==  MPMovieFinishReasonPlaybackEnded) {
            NSLog(@"player finish");
        }else if (reason == MPMovieFinishReasonPlaybackError){
            NSLog(@"%@", [NSString stringWithFormat:@"player Error : %@", [[notify userInfo] valueForKey:@"error"]]);
        }else if (reason == MPMovieFinishReasonUserExited){
            NSLog(@"%@", [NSString stringWithFormat:@"player userExited"]);
            
        }
    }
    if (MPMovieNaturalSizeAvailableNotification ==  notify.name) {
        NSLog(@"video size %.0f-%.0f, rotate:%ld\n", _player.naturalSize.width, _player.naturalSize.height, (long)_player.naturalRotate);
        if(((_player.naturalRotate / 90) % 2  == 0 && _player.naturalSize.width > _player.naturalSize.height) ||
           ((_player.naturalRotate / 90) % 2 != 0 && _player.naturalSize.width < _player.naturalSize.height))
        {
            //如果想要在宽大于高的时候横屏播放，你可以在这里旋转
        }
    }
    if (MPMoviePlayerFirstVideoFrameRenderedNotification == notify.name)
    {
        self.fvr_costtime = (int)((long long int)([self getCurrentTime] * 1000) - _prepared_time);
        NSLog(@"first video frame show, cost time : %dms!\n", _fvr_costtime);
    }
    
    if (MPMoviePlayerFirstAudioFrameRenderedNotification == notify.name)
    {
        self.far_costtime = (int)((long long int)([self getCurrentTime] * 1000) - _prepared_time);
        NSLog(@"first audio frame render, cost time : %dms!\n", _far_costtime);
    }
    
    if (MPMoviePlayerSuggestReloadNotification == notify.name)
    {
        NSLog(@"suggest using reload function!\n");
        if(!_reloading)
        {
            self.reloading = YES;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(){
                if (_player) {
                    NSLog(@"reload stream");
                    [_player reload:_reloadUrl flush:YES mode:MPMovieReloadMode_Accurate];
                }
            });
        }
    }
    
    if(MPMoviePlayerPlaybackStatusNotification == notify.name)
    {
        int status = [[[notify userInfo] valueForKey:MPMoviePlayerPlaybackStatusUserInfoKey] intValue];
        if(MPMovieStatusVideoDecodeWrong == status)
            NSLog(@"Video Decode Wrong!\n");
        else if(MPMovieStatusAudioDecodeWrong == status)
            NSLog(@"Audio Decode Wrong!\n");
        else if (MPMovieStatusHWCodecUsed == status )
            NSLog(@"Hardware Codec used\n");
        else if (MPMovieStatusSWCodecUsed == status )
            NSLog(@"Software Codec used\n");
        else if(MPMovieStatusDLCodecUsed == status)
            NSLog(@"AVSampleBufferDisplayLayer  Codec used");
    }
    if(MPMoviePlayerNetworkStatusChangeNotification == notify.name)
    {
        int currStatus = [[[notify userInfo] valueForKey:MPMoviePlayerCurrNetworkStatusUserInfoKey] intValue];
        int lastStatus = [[[notify userInfo] valueForKey:MPMoviePlayerLastNetworkStatusUserInfoKey] intValue];
        NSLog(@"network reachable change from %@ to %@\n", [self netStatus2Str:lastStatus], [self netStatus2Str:currStatus]);
    }
    if(MPMoviePlayerSeekCompleteNotification == notify.name)
    {
        NSLog(@"Seek complete");
    }
}

-(void)handlePlayerNotify:(NSNotification*)notify {}

- (void) toast:(NSString*)message{
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    double duration = 0.5; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}

/// 获取当前时间
- (NSTimeInterval) getCurrentTime
{
    return [[NSDate date] timeIntervalSince1970];
}

/// 获取当前网络状态
- (NSString *) netStatus2Str:(KSYNetworkStatus)networkStatus{
    NSString *netString = nil;
    if(networkStatus == KSYNotReachable)
        netString = @"NO INTERNET";
    else if(networkStatus == KSYReachableViaWiFi)
        netString = @"WIFI";
    else if(networkStatus == KSYReachableViaWWAN)
        netString = @"WWAN";
    else
        netString = @"Unknown";
    return netString;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
