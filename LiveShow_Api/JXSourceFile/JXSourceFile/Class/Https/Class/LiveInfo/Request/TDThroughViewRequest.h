//
//  TDThroughViewRequest.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDThroughViewRequest : NSObject<TDHttpRequestType>
/**
 活动id
 */
@property (nonatomic, assign) NSUInteger sourceId;
/**
 默认0（活动），1（视频），2（图文）
 */
@property (nonatomic, assign) NSUInteger type;

- (instancetype)initWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;
+ (instancetype)throughViewWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;



@end
