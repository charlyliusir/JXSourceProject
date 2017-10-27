//
//  TDLiveInfoResponse.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDLiveInfoModel.h"

@interface TDLiveInfoResponse : NSObject<TDHttpResponseType>

@property (nonatomic, strong) TDLiveInfoModel *infoModel;

@end
