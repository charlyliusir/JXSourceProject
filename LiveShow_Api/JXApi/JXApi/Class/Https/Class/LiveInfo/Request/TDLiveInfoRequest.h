//
//  TDLiveInfoRequest.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLiveInfoRequest : NSObject <TDHttpRequestType>

/**
 直播资源id
 */
@property (nonatomic, assign) NSUInteger sourceId;

- (instancetype)initWithSourceId:(NSUInteger)sourceId;
+ (instancetype)liveInfoWithSourceId:(NSUInteger)sourceId;

@end
