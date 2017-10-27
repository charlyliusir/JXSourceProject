//
//  JXApiHeader.m
//  JXApi
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 tidemedia. All rights reserved.
//

#import "JXApiHeader.h"
#import "TDLiveVideoViewController.h"

@implementation JXApiHeader

+ (instancetype)manager
{
    static JXApiHeader *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JXApiHeader alloc] init];
    });
    return manager;
}

- (void)loadLiveActivityWithBaseViewController:(UIViewController *)viewController
{
    [self loadLiveActivity:_sourceId sourceType:_sourceType withBaseViewController:viewController];
}

- (void)loadLiveActivity:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType withBaseViewController:(UIViewController *)viewController
{
    TDLiveVideoViewController *liveVideoViewController = [TDLiveVideoViewController liveVideoWithSourceId:sourceId sourceType:sourceType];
    [viewController.navigationController pushViewController:liveVideoViewController animated:YES];
}

@end
