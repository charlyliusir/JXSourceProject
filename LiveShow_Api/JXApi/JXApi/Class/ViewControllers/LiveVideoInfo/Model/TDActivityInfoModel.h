//
//  TDActivityInfoModel.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDActivityInterModel.h"
#import "TDActivityNarrModel.h"

@interface TDActivityInfoModel : NSObject

/// 活动id
@property (nonatomic, strong) NSNumber * sourceid;
/// 活动标题
@property (nonatomic, strong) NSString * title;
/// 活动介绍
@property (nonatomic, strong) NSString * summary;
/// 封面图
@property (nonatomic, strong) NSString * coverpicture;
/// 是否显示片段
@property (nonatomic, strong) NSString * display;
/// 打赏笔数
@property (nonatomic, strong) NSNumber * reward_number;
/// 在线人数
@property (nonatomic, strong) NSNumber * online;
/// 投票数量
@property (nonatomic, strong) NSNumber * vote;
/// 消息数量
@property (nonatomic, strong) NSString * message;
/// 是否预约
@property (nonatomic, strong) NSNumber * bespeak;
/// 广告图
@property (nonatomic, strong) NSString * ad_pic;
/// 广告地址
@property (nonatomic, strong) NSNumber * ad_url;
/// 直播人姓名（个人姓名或者企业名称）
@property (nonatomic, strong) NSString * name;
/// 直播人头像（个人头像或者企业logo）
@property (nonatomic, strong) NSString * photo;
/// 活动组件, 判断是否开启
@property (nonatomic, strong)TDActivityNarrModel * narrModel;
/// 互动组件
@property (nonatomic, strong)TDActivityInterModel * interModel;


@end
