//
//  TDLiveVideoDynamicController.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseViewController.h"
#import "CLTapViewControllerProtocol.h"

@interface TDLiveVideoDynamicController : TDBaseViewController<CLTapViewControllerProtocol>

@property (nonatomic, readonly, assign) NSUInteger sourceId;
@property (nonatomic, readonly, assign) NSUInteger type;

+ (instancetype)liveVideoDynamicControllerWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;

@end
