//
//  TDLiveVideoIntroController.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseViewController.h"
#import "CLTapViewControllerProtocol.h"

@interface TDLiveVideoIntroController : TDBaseViewController<CLTapViewControllerProtocol>

@property (nonatomic, readonly, assign) NSUInteger sourceId;
@property (nonatomic, readonly, assign) NSUInteger type;

+ (instancetype)liveVideoIntroControllerWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;

@end
