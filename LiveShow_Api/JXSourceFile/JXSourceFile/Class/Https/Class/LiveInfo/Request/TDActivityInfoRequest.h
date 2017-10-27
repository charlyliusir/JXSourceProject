//
//  TDActivityInfoRequest.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDActivityInfoRequest : NSObject<TDHttpRequestType>

/**
 直播资源id
 */
@property (nonatomic, assign) NSUInteger sourceId;

- (instancetype)initWithSourceId:(NSUInteger)sourceId;
+ (instancetype)activityInfoWithSourceId:(NSUInteger)sourceId;

@end
