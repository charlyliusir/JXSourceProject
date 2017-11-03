//
//  TDActivityInfoViewModel.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDActivityInfoViewModel.h"
#import "TDActivityInfoRequest.h"
#import "TDLivePlayerViewController.h"

@implementation TDActivityInfoViewModel

- (instancetype)initWithModel:(TDActivityInfoModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

+ (instancetype)liveInfoWithModel:(TDActivityInfoModel *)model
{
    return [[self alloc] initWithModel:model];
}

/// 是否开启片段
- (BOOL)showDispaly
{
    return [_model.display isEqualToString:@"1"];
}
/// 是否展示动态组件
- (BOOL)showDynamic
{
    return [_model.narrModel.pic isEqualToNumber:@(1)];
}
/// 动态组件的名字
- (NSString *)dynamicTitle
{
    return _model.interModel.title_dynamic;
}
/// 是否展示聊天组件
- (BOOL)showChat
{
    return [_model.narrModel.chat isEqualToNumber:@(1)];
}
/// 聊天组件的名字
- (NSString *)chatTitle
{
    return _model.interModel.title_chat;
}
/// 聊天信息数量
- (NSUInteger)messageNumber
{
    return _model.message.unsignedIntegerValue;
}
/// 介绍组件的名字
- (NSString *)introduceTitle
{
    return _model.interModel.title_introduce;
}
/// 介绍信息
- (NSString *)introduceSummary
{
    return _model.summary;
}
/// 是否展示打赏组件
- (BOOL)showReward
{
    return [_model.narrModel.reward isEqualToNumber:@(1)];
}
/// 打赏数量
- (NSUInteger)rewardNumber
{
    return _model.reward_number.unsignedIntegerValue;
}
/// 是否展示抽奖组件
- (BOOL)showLuck
{
    return [_model.narrModel.luck isEqualToNumber:@(1)];
}
/// 是否展示投票组件
- (BOOL)showVote
{
    return [_model.narrModel.vote isEqualToNumber:@(1)];
}
/// 投票数量
- (NSUInteger)voteNumber
{
    return _model.vote.unsignedIntegerValue;
}
/// 介绍内容的高度
- (CGFloat)summaryHeight
{
    CGFloat height = 15 + 18 + 15;

    if (_model && _model.summary && ![_model.summary isEqualToString:@""]) {
        height += [[self summaryAttributedString] size].height;
    }
    
    return height;
}

/// 介绍内容富文本文字
- (NSAttributedString *)summaryAttributedString
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:TDFontSize(16) forKey:NSFontAttributeName];
    [dict setValue:@(2) forKey:NSKernAttributeName];
    [dict setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    return [[NSAttributedString alloc] initWithString:@"10月25日，记者获悉，麦当劳(中国)有限公司已于2017年10月12日正式更名为金拱门(中国)有限公司。此前8月24日，投资者名称也由麦当劳中国管理有限公司变更为金拱门中国管理有限公司。目前，麦当劳各地分公司也在陆续更名。" attributes:dict];
}


- (void)getActivityInfo:(TD_Request_Handler)handler withSourceId:(NSUInteger)sourceId
{
    TDActivityInfoRequest *req = [TDActivityInfoRequest activityInfoWithSourceId:sourceId];
    
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        if (statusCode == TDHttpStatusSuccess && response.model) {
            if ([response.model isKindOfClass:[TDActivityInfoModel class]]) {
                _model = response.model;
                handler(YES, @"");
            }
            else {
                handler(NO, message);
            }
        }
    } onFailure:^(NSError *error) {
        handler(NO, TDLocalizedStringWithComment(@"td_http_net_error", @"网络请求失败!"));
    }];
}

- (void)fullScreenButtonClickedHandlerForVodPlayController:(TDLivePlayerViewController *)vodPlayController isFullScreen:(BOOL)isFullScreen
{
    [vodPlayController.view removeFromSuperview];
    [vodPlayController removeFromParentViewController];
    
    UIInterfaceOrientation orientation = UIInterfaceOrientationLandscapeRight;
    if (!isFullScreen) {
        orientation = UIInterfaceOrientationPortrait;
    }
    
    if (isFullScreen) {
        UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
        [keywindow addSubview:vodPlayController.view];
        [_owner addChildViewController:vodPlayController];
        [vodPlayController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(keywindow);
        }];
    } else {
        [_owner.view addSubview:vodPlayController.view];
        [_owner addChildViewController:vodPlayController];
        [vodPlayController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(_owner.view);
            make.height.mas_equalTo(211);
        }];
    }
    
    [[UIDevice currentDevice] setValue:@(orientation) forKey:@"orientation"];
    if ([vodPlayController isKindOfClass:[TDLivePlayerViewController class]]) {
        TDLivePlayerViewController *vpc = (TDLivePlayerViewController *)vodPlayController;
        vpc.fullScreen = isFullScreen;
    }
}

@end
