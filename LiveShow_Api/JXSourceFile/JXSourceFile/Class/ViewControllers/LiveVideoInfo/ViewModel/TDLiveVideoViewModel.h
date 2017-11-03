//
//  TDLiveVideoViewModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TDLiveClipsViewModel.h"
#import "TDLiveInfoViewModel.h"

@interface TDLiveVideoViewModel : NSObject

@property (nonatomic, strong) TDLiveInfoViewModel *videoInfoViewModel;
@property (nonatomic, strong) NSMutableArray *videoClips;

- (void)getVideoInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId;

@end
