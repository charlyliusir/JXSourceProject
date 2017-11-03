//
//  TDLivePlayerViewController.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDPlayerController.h"
#import "TDActivityInfoViewModel.h"
#import "TDLiveVideoViewModel.h"

@interface TDLivePlayerViewController : TDPlayerController

@property (nonatomic, strong) TDActivityInfoViewModel *viewmodel;
@property (nonatomic, strong) TDLiveVideoViewModel *videoViewmodel;
@property (nonatomic, assign) BOOL fullScreen;

@end
