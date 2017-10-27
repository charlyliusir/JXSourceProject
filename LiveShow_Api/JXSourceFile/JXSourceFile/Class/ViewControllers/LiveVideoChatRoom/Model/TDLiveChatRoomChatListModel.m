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
    if (!self.msg_content || [self.msg_content isEqualToString:@""]) {
        return 34;
    }
    
    return [NSString stringGetHegith:self.msg_content WithWidth:TDChatContentWidth attributes:@{NSFontAttributeName: TDFontSize(15)}] + 20;
}

///// 二级文字高度
//- (CGFloat)nextContentHeight
//{
//    if (!self.msg_content || [self.msg_content isEqualToString:@""]) {
//        return 34;
//    }
//
//    return [NSString stringGetHegith:self.msg_content WithWidth:TDChatContentWidth attributes:@{NSFontAttributeName: TDFontSize(15)}] + 20;
//}

- (CGFloat)chatCellHeight
{
    return TDChatNormalHeight + [self contentHeight];
}

@end
