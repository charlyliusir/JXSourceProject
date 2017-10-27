//
//  TDLiveInfoModeView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDLiveInfoModel.h"

@interface TDLiveInfoViewModel : NSObject

@property (nonatomic, readonly, strong) TDLiveInfoModel *model;

- (instancetype)initWithModel:(TDLiveInfoModel *)model;
+ (instancetype)liveInfoWithModel:(TDLiveInfoModel *)model;

- (void)getLiveInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId;

@end
