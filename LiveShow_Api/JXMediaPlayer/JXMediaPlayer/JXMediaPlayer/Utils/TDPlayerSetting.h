//
//  TDPlayerSetting.h
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KSYMediaPlayer/KSYMoviePlayerDefines.h>

@interface TDPlayerSetting : NSObject

@property (nonatomic, assign) MPMovieVideoDecoderMode videoDecoderMode;

@property (nonatomic, assign) NSInteger bufferTimeMax;

@property (nonatomic, assign) NSInteger bufferSizeMax;

@property (nonatomic, assign) NSInteger preparetimeOut;

@property (nonatomic, assign) NSInteger readtimeOut;

@property (nonatomic, assign) BOOL  shouldLoop;

@property (nonatomic, assign) BOOL  shouldAutoplay;

@property (nonatomic, assign) BOOL  recording;

@property (nonatomic, assign) BOOL  showDebugLog;

+ (instancetype)defaultSetting;

@end
