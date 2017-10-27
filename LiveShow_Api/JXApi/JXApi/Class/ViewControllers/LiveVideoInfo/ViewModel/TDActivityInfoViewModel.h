//
//  TDActivityInfoViewModel.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDActivityInfoModel.h"

@interface TDActivityInfoViewModel : NSObject


@property (nonatomic, readonly, strong) TDActivityInfoModel *model;

- (instancetype)initWithModel:(TDActivityInfoModel *)model;
+ (instancetype)liveInfoWithModel:(TDActivityInfoModel *)model;

- (void)getActivityInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId;

@end
