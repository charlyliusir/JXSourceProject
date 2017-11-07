//
//  TDChatRoomSendMessageTextFiled.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/24.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDBaseTextView.h"
#import "TDLiveChatRoomChatListModel.h"
@protocol TCContainerTextViewDelegate;

typedef NS_ENUM(NSUInteger, TDSendMessageLevel) {
    TDSendMessageLevelNotSupport,
    TDSendMessageLevelSupport
};

@interface TDChatRoomSendMessageTextView : UIView
@property (nonatomic, weak) id<TCContainerTextViewDelegate> delegate;
/**
 聊天框
 */
@property (nonatomic, readonly, strong) TDBaseTextView *textView;

/**
 发送按钮
 */
@property (nonatomic, readonly, strong) UIButton *sendButton;

/**
 是否允许聊天
 */
@property (nonatomic, assign)TDSendMessageLevel *sendLeve;

/**
 用以二级回复的聊天消息
 */
@property (nonatomic, strong)TDLiveChatRoomChatListModel *chatModel;

@end


@protocol TDContainerTextViewDelegate <NSObject>

@optional

/**
 *  发送content代理
 *
 *  @param containerTextView TCContainerTextView
 *  @param btn               UIButton
 *  @param content           要发送的内容
 */
- (void)containerTextView:(TDChatRoomSendMessageTextView *)containerTextView clickSendButton:(UIButton *)btn content:(NSString *)content;

@end
