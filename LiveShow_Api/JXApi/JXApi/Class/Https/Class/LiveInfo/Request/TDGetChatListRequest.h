//
//  TDGetChatListRequest.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDGetChatListRequest : NSObject <TDHttpRequestType>
/// 活动 id
@property (nonatomic, assign) NSUInteger sourceId;
/// 活动类型 0 - 活动 1 - 视频 2 - 图文
@property (nonatomic, assign) NSUInteger sourceType;
/// 最小 id 用于获取下一页数据
@property (nonatomic, strong) NSNumber *minId;
/// 最后 id 用于获取最新数据
@property (nonatomic, strong) NSNumber *lastId;

- (instancetype)initWithSourceId:(NSUInteger)sourceId withSourceType:(NSUInteger)sourceType
                   getNewMessage:(NSNumber *)lastId
              getNextPageMessage:(NSNumber *)minId;
+ (instancetype)chatListWithSourceId:(NSUInteger)sourceId withSourceType:(NSUInteger)sourceType
                       getNewMessage:(NSNumber *)lastId;
+ (instancetype)chatListWithSourceId:(NSUInteger)sourceId withSourceType:(NSUInteger)sourceType
                  getNextPageMessage:(NSNumber *)minId;

@end
