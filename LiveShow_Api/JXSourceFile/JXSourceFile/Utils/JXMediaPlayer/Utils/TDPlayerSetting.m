//
//  TDPlayerSetting.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDPlayerSetting.h"

@implementation TDPlayerSetting

+ (instancetype)defaultSetting
{
    TDPlayerSetting *settingModel = [[self alloc] init];
    settingModel.videoDecoderMode = MPMovieVideoDecoderMode_Hardware;
    settingModel.bufferTimeMax = 2;
    settingModel.bufferSizeMax = 15;
    settingModel.preparetimeOut = 10;
    settingModel.readtimeOut = 30;
    settingModel.shouldLoop = NO;
    settingModel.shouldAutoplay = NO;
    settingModel.recording = NO;
    settingModel.showDebugLog = NO;
    return settingModel;
}

@end
