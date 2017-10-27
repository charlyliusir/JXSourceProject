//
//  TDLivePlayerViewController.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDPlayerController.h"
#import "TDPlayerViewModel.h"

@interface TDLivePlayerViewController : TDPlayerController

@property (nonatomic, strong) TDPlayerViewModel *viewmodel;
@property (nonatomic, assign) BOOL fullScreen;

@end
