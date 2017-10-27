//
//  TDActivityInterModel.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDActivityInterModel : NSObject
/// 宽度百分比
@property (nonatomic, strong) NSNumber * number;
/// 动态
@property (nonatomic, strong) NSString * title_dynamic;
/// 聊天
@property (nonatomic, strong) NSString * title_chat;
/// 介绍
@property (nonatomic, strong) NSString * title_introduce;
/// 自定义菜单
@property (nonatomic, strong) NSString * title_custom1;
/// 自定义内容
@property (nonatomic, strong) NSString * content_custom1;

@end
