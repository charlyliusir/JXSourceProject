//
//  TDActivityResponse.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDActivityInfoModel.h"

@interface TDActivityResponse : NSObject<TDHttpResponseType>

@property (nonatomic, strong) TDActivityInfoModel *infoModel;

@end
