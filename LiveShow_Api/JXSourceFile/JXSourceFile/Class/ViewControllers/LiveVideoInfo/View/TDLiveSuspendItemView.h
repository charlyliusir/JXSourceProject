//
//  TDLiveSuspendItemView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TDSuspentItem) {
    TDSuspentItemChat,      /** 聊天*/
    TDSuspentItemPraise,    /** 打赏*/
    TDSuspentItemVote,      /** 投票*/
    TDSuspentItemDraw       /** 抽奖*/
};

@interface TDLiveSuspendItemView : UIButton

@property (nonatomic, readonly, assign)NSUInteger number;
@property (nonatomic, readonly, assign)TDSuspentItem itemType;

- (instancetype)initWithImageName:(NSString *)imageName titleColor:(NSString *)colorHex itemType:(TDSuspentItem)type;
+ (instancetype)liveSuspendItemWithImageName:(NSString *)imageName titleColor:(NSString *)colorHex itemType:(TDSuspentItem)type;

- (void)setNumber:(NSUInteger)number;
- (void)setLabelHidden:(BOOL)isHidden;

@end

