//
//  TDPlayerController.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KSYMediaPlayer/KSYMoviePlayerController.h>
#import <Masonry/Masonry.h>

@interface TDPlayerController : UIViewController
/// 金山云播放器
@property (nonatomic, strong) KSYMoviePlayerController *player;
/// 网络状态
@property (nonatomic, copy) NSString* networkStatus;
/// 网络状态发生改变的回调
@property (nonatomic, copy) void(^onNetworkChange)(NSString* msg);

- (instancetype)initWithVideoUrl: (NSURL *)videoUrl;
+ (instancetype)playerWithVideoUrl: (NSURL *)videoUrl;
- (instancetype)initWithVideoUrlString: (NSString *)videoUrlString;
+ (instancetype)playerWithVideoUrlString: (NSString *)videoUrlString;

/// 重播视频
- (void)reload:(NSURL *)aUrl;
/// 监听通知
- (void)notifyHandler:(NSNotification*)notify;

@end
