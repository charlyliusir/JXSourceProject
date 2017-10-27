//
//  TDLiveVideoViewController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/17.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoViewController.h"
#import "CLTapViewController.h"
#import "CLTapBarItem.h"

#import "TDActivityInfoViewModel.h"
#import "TDSendMessageRequest.h"

#import "TDLiveVideoDynamicController.h"
#import "TDLiveVideoChatRoomController.h"
#import "TDLiveVideoIntroController.h"

@interface TDLiveVideoViewController ()
@property (nonatomic, strong) CLTapViewController * tapViewController;
@property (nonatomic, strong) UIButton *sendMessageButton;
@property (nonatomic, strong) TDActivityInfoViewModel *viewmodel;
@end

@implementation TDLiveVideoViewController

- (instancetype)initWithSourceId:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType
{
    if (self = [super init]) {
        _sourceId   = sourceId;
        _sourceType = sourceType;
    }
    return self;
}

+ (instancetype)liveVideoWithSourceId:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType
{
    return [[self alloc] initWithSourceId:sourceId sourceType:sourceType];
}

- (CLTapViewController *)tapViewController
{
    if (!_tapViewController) {
        _tapViewController = [[CLTapViewController alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150)];
    }
    return _tapViewController;
}

- (UIButton *)sendMessageButton  {
    if (!_sendMessageButton) {
        _sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendMessageButton setFrame:CGRectMake(self.view.frame.size.width-40, self.view.frame.size.height-40, 40, 40)];
        [_sendMessageButton setBackgroundColor:[UIColor orangeColor]];
        [_sendMessageButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendMessageButton;
}

- (TDActivityInfoViewModel *)viewmodel
{
    if (!_viewmodel) {
        _viewmodel = [[TDActivityInfoViewModel alloc] init];
    }
    return _viewmodel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sourceId = 3412;
    _sourceType = 0;
    
    CLTapBarItem *oneItem = [[CLTapBarItem alloc] initWithTitle:TDLocalizedStringWithComment(@"live_info_tapbar_item_dynamic", @"动态") controller:[TDLiveVideoDynamicController liveVideoDynamicControllerWithSourceId:_sourceId type:_sourceType]];
    CLTapBarItem *twoItem = [[CLTapBarItem alloc] initWithTitle:TDLocalizedStringWithComment(@"live_info_tapbar_item_chat", @"聊天室") controller:[TDLiveVideoChatRoomController liveVideoChatRoomControllerWithSourceId:_sourceId type:_sourceType]];
    CLTapBarItem *threeItem = [[CLTapBarItem alloc] initWithTitle:TDLocalizedStringWithComment(@"live_info_tapbar_item_intro", @"介绍") controller:[TDLiveVideoIntroController liveVideoIntroControllerWithSourceId:_sourceId type:_sourceType]];
    
    [self.tapViewController setBarItems:@[oneItem, twoItem, threeItem].mutableCopy];
    
    [self.view addSubview:self.tapViewController];
    [self.view addSubview:self.sendMessageButton];
    
    [self.view setBackgroundColor:TDHexStringColor(@"#ffffff")];
    
    [self.viewmodel getActivityInfo:^(BOOL success, NSString *message) {
        if (success) {
            NSLog(@"请求成功");
        }
        else {
            NSLog(@"请求失败---%@", message);
        }
    } withSourceId:_sourceId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendMessage:(id)sender
{
    TDSendMessageRequest *req = [TDSendMessageRequest sendMessageWithSourceId:_sourceId sendType:_sourceType message:@"这是一条测试消息" parent:nil];
    [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
        
    } onFailure:^(NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
