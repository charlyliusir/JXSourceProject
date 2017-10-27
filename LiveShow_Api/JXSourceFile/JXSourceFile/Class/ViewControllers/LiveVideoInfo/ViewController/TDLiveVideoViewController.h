//
//  TDLiveVideoViewController.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseViewController.h"

@interface TDLiveVideoViewController : TDBaseViewController

@property (nonatomic, assign) NSUInteger sourceId;
@property (nonatomic, assign) NSUInteger sourceType;

- (instancetype)initWithSourceId:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType;
+ (instancetype)liveVideoWithSourceId:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType;

@end
