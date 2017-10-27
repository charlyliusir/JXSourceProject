//
//  JXApiHeader.h
//  JXApi
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 tidemedia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXApiHeader : NSObject
/// 直播活动资源 id
@property (nonatomic, assign) NSUInteger sourceId;
/// 直播活动类型 0 - 活动 1 - 直播 2 - 图文
@property (nonatomic, assign) NSUInteger sourceType;

+ (instancetype)manager;

/**
 加载直播活动

 @param viewController 当前控制器
 */
- (void)loadLiveActivityWithBaseViewController:(UIViewController *)viewController;

/**
 根据资源id和活动类型加载直播活动

 @param sourceId 直播活动资源 id
 @param sourceType 直播活动类型 0 - 活动 1 - 直播 2 - 图文
 @param viewController 当前控制器
 */
- (void)loadLiveActivity:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType withBaseViewController:(UIViewController *)viewController;

@end
