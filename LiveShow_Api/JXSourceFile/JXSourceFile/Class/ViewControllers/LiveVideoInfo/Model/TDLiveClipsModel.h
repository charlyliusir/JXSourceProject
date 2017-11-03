//
//  TDLiveClipsModel.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLiveClipsModel : NSObject
/// 分段名称
@property (nonatomic, copy) NSString *title;
/// 分段视频地址
@property (nonatomic, copy) NSString *url;
/// 分段视频第一帧图片
@property (nonatomic, copy) NSString *photo;
@end
