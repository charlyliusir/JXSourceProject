//
//  TDLiveVideoChatRoomController.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseViewController.h"
#import "CLTapViewControllerProtocol.h"
#import "TDLiveSuspendItemView.h"
#import "TDChatRoomSendMessageTextView.h"

@interface TDLiveVideoChatRoomController : TDBaseViewController <CLTapViewControllerProtocol>
/// 聊天悬浮按钮
@property (nonatomic, readwrite, strong) TDLiveSuspendItemView * chatItemView;
/// 聊天输入框
@property (nonatomic, readwrite, strong) TDChatRoomSendMessageTextView *sendMessageTextview;
/// 资源id
@property (nonatomic, readonly, assign) NSUInteger sourceId;
/// 资源类型
@property (nonatomic, readonly, assign) NSUInteger type;

+ (instancetype _Nullable )liveVideoChatRoomControllerWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type;
- (void)addDraggingTarget:(id _Nullable )target action:(nonnull SEL)action;
- (void)sendNewChatMessage;

@end
