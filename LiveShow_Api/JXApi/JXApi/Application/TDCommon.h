//
//  TDCommon.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/18.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#ifndef TDCommon_h
#define TDCommon_h

#define TD_JXVersion  @"1.0"
#define TD_JX_BASEURL @"http://juxian2.juyun.tv/api"
//#define TD_JX_BASEURL [NSString stringWithFormat:@"http://api.juyun.tv/api/v%@", TD_JXVersion]

#pragma mark - Common Block
#define TD_Request_Handler void(^)(BOOL success, NSString *message)

#pragma mark - UI
#define TD_UI_Margin_X 12
#define TD_UI_DATA_LOADING_NUMBER 10

#endif /* TDCommon_h */
