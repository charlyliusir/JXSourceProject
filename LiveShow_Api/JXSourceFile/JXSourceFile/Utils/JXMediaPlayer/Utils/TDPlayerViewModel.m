//
//  TDPlayerViewModel.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDPlayerViewModel.h"
#import "TDLivePlayerViewController.h"
#import <Masonry/Masonry.h>

@implementation TDPlayerViewModel

- (void)fullScreenButtonClickedHandlerForVodPlayController:(TDLivePlayerViewController *)vodPlayController isFullScreen:(BOOL)isFullScreen
{
    [vodPlayController.view removeFromSuperview];
    [vodPlayController removeFromParentViewController];
    
    UIInterfaceOrientation orientation = UIInterfaceOrientationLandscapeRight;
    if (!isFullScreen) {
        orientation = UIInterfaceOrientationPortrait;
    }
    
    if (isFullScreen) {
        UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
        [keywindow addSubview:vodPlayController.view];
        [_owner addChildViewController:vodPlayController];
        [vodPlayController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keywindow);
        }];
    } else {
        [_owner.view addSubview:vodPlayController.view];
        [_owner addChildViewController:vodPlayController];
        [vodPlayController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(_owner.view);
            make.height.mas_equalTo(211);
        }];
    }
    
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
    if ([vodPlayController isKindOfClass:[TDLivePlayerViewController class]]) {
        TDLivePlayerViewController *vpc = (TDLivePlayerViewController *)vodPlayController;
        vpc.fullScreen = isFullScreen;
    }
}

@end
