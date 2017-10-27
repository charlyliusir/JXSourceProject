//
//  TDChatRoomTextCell.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDLiveChatRoomChatListModel.h"

@interface TDChatRoomTextCell : UITableViewCell

@property (nonatomic, strong) TDLiveChatRoomChatListModel * model;

- (void)setStyle;

@end
