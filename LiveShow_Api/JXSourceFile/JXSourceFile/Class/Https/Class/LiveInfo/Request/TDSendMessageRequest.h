//
//  TDSendMessageRequest.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSendMessageRequest : NSObject<TDHttpRequestType>
/**
 活动id
 */
@property (nonatomic, assign) NSUInteger sourceId;
/**
 默认0（活动），1（视频），2（图文）
 */
@property (nonatomic, assign) NSUInteger send_type;
/**
 评论内容
 */
@property (nonatomic,   copy) NSString *message;
/**
 父评论id, 用作二级评论
 */
@property (nonatomic, strong) NSNumber *parent;

- (instancetype)initWithSourceId:(NSUInteger)sourceId sendType:(NSUInteger)sendType message:(NSString *)message parent:(NSNumber *)parent;
+ (instancetype)sendMessageWithSourceId:(NSUInteger)sourceId sendType:(NSUInteger)sendType message:(NSString *)message parent:(NSNumber *)parent;

@end
