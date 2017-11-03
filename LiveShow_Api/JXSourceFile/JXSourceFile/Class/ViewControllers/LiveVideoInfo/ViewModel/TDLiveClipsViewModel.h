//
//  TDLiveClipsViewModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDLiveClipsModel.h"

@interface TDLiveClipsViewModel : NSObject

@property (nonatomic, readonly, strong) TDLiveClipsModel *model;

- (instancetype)initWithModel:(TDLiveClipsModel *)model;
+ (instancetype)liveClipsWithModel:(TDLiveClipsModel *)model;

- (CGFloat)cellWidth;

@end
