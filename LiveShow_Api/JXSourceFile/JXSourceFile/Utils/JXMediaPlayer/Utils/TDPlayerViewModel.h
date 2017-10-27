//
//  TDPlayerViewModel.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class TDLivePlayerViewController;

@interface TDPlayerViewModel : NSObject

@property (nonatomic, weak) UIViewController *owner;

- (void)fullScreenButtonClickedHandlerForVodPlayController:(TDLivePlayerViewController *)vodPlayController isFullScreen:(BOOL)isFullScreen;

@end
