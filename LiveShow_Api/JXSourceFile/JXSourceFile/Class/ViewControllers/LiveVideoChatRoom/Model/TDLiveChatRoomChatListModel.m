//
//  TDLiveChatRoomChatListModel.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveChatRoomChatListModel.h"

#define TDChatNormalHeight 32
#define TDChatNormalContnetHeight 34
#define TDChatContentWidth [UIScreen mainScreen].bounds.size.width - 138
#define TDChatContentNormalHeight 20
#define TDNextChatContentNormalHeight 10

@implementation TDLiveChatRoomChatListModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _user_id = value;
    }
}

- (CGFloat)contentHeight
{
    NSString *message = [self getMessageWithChatMessage];
    if ([message isEqualToString:@""]) {
        return 34;
    }
    
    return [NSString stringGetHegith:message WithWidth:TDChatContentWidth attributes:@{NSFontAttributeName: TDFontSize(15)}] + 20;
}

/// 二级文字高度
- (CGFloat)nextContentHeight
{
    if (![self isReplyMessage]) {
        return 0;
    }
    
    NSString *message = [self getReplyMessageWithChatMessage];
    if ([message isEqualToString:@""]) {
        return 34;
    }

    return [NSString stringGetHegith:message WithWidth:TDChatContentWidth attributes:@{NSFontAttributeName: TDFontSize(15)}] + 20;
}

- (CGFloat)chatCellHeight
{
    return TDChatNormalHeight + [self contentHeight] + [self nextContentHeight];
}

- (BOOL)isReplyMessage
{
    BOOL isReply = NO;
    if (self.is_reply) {
        return (isReply = [self.is_reply boolValue]);
    }
    return isReply;
}

- (NSString *)getUserNameWithChatMessage
{
    NSString *userName = @"";
    if ([self isReplyMessage]) {
        return (userName = self.reply_user_name ? self.reply_user_name : @"");
    }
    else if (![self isReplyMessage]) {
        return (userName = self.user_name ? self.user_name : @"");
    }
    else {
        return userName;
    }
}

- (NSString *)getMessageWithChatMessage
{
    NSString *message = @"";
    if ([self isReplyMessage]) {
        return (message = self.reply_msg ? self.reply_msg : @"");
    }
    else if (![self isReplyMessage]) {
        return (message = self.msg_content ? self.msg_content : @"");
    }
    else {
        return message;
    }
}

- (NSString *)getReplyUserNameWithChatMessage
{
    NSString *reply_userName = @"";
    if (![self isReplyMessage]) {
        return (reply_userName = self.reply_user_name ? self.reply_user_name : @"");
    }
    else if ([self isReplyMessage]) {
        return (reply_userName = self.user_name ? self.user_name : @"");
    }
    else {
        return reply_userName;
    }
}

- (NSString *)getReplyMessageWithChatMessage
{
    NSString *reply_msg = @"";
    if (![self isReplyMessage]) {
        return (reply_msg = self.reply_msg ? self.reply_msg : @"");
    }
    else if ([self isReplyMessage]) {
        return (reply_msg = self.msg_content ? self.msg_content : @"");
    }
    else {
        return reply_msg;
    }
}

@end
