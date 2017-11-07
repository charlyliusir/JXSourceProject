//
//  TDLiveVideoChatRoomController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoChatRoomController.h"
#import "TDChatRoomTextCell.h"
#import "TDLiveChatRoomViewModel.h"
#import "TDSendMessageRequest.h"

@interface TDLiveVideoChatRoomController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>{
    
    dispatch_source_t _timer;
    
}
@property (nonatomic, readwrite, assign) NSUInteger sourceId;
@property (nonatomic, readwrite, assign) NSUInteger type;
@property (nonatomic, readwrite, assign) BOOL needReadNewMessage;

@property (nonatomic,   weak)   id draggingTarget;
@property (nonatomic, assign)   SEL draggingAction;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TDLiveChatRoomViewModel *viewmodel;

@end

@implementation TDLiveVideoChatRoomController

+ (instancetype)liveVideoChatRoomControllerWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type
{
    TDLiveVideoChatRoomController *controller = [[TDLiveVideoChatRoomController alloc] init];
    controller.sourceId = sourceId;
    controller.type     = type;
    return controller;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_timer) {
        dispatch_suspend(_timer);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TDChatRoomTextCell class] forCellReuseIdentifier:NSStringFromClass([TDChatRoomTextCell class])];
    
    __weak typeof(self)weakSelf = self;
    [_tableView setMj_header:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /// 加载更多
        __strong typeof(self)strongSelf = weakSelf;
        [strongSelf loadMoreData];
    }]];
    
    [self setupUI];
}

- (void)setupUI
{
    /// 给底边留 10 px 高度， 看起来好看
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)]];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

- (void)startGetNewChatTimer
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 15.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        [self.viewmodel getNewChatList:^(BOOL success, NSString *message) {
            if (success) {
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.viewmodel.listModels.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        }];
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 发送消息

 @param button 发送按钮
 */
- (void)sendMessage:(UIButton *)button
{
    NSString *text = self.sendMessageTextview.textView.text;
    if (![text isEqualToString:@""]) {
        NSNumber *parent = nil;
        TDLiveChatRoomChatListModel *chatModel;
        if ((chatModel = self.sendMessageTextview.chatModel)) {
            parent = chatModel.user_id;
        }
        /// 发送评论
        TDSendMessageRequest *req = [TDSendMessageRequest sendMessageWithSourceId:_sourceId sendType:_type message:_sendMessageTextview.textView.text parent:parent];
        [[[TDCommonClient alloc] init] sendReq:req onSuccess:^(TDHttpStatusCode statusCode, id<TDHttpResponseType> response, NSString *message, id json) {
            if (statusCode == TDHttpStatusSuccess) {
                [self sendNewChatMessage];
                /// 取消响应
                [self hideKeyBoard];
            }
            else {
                NSLog(@"%@", message);
#warning 发送失败
            }
        } onFailure:^(NSError *error) {
            NSLog(@"发送失败");
#warning 发送失败
        }];
    }
    else {

#warning 消息不能为空
    }
    
}

/// 发送最新消息
- (void)sendNewChatMessage
{
    /// 暂停定时器
    dispatch_suspend(_timer);
    __weak typeof(self)weakSelf = self;
    [self.viewmodel getNewChatList:^(BOOL success, NSString *message) {
        __strong typeof(self)strongSelf = weakSelf;
        if (success) {
            /// 刷新列表
            [strongSelf.tableView reloadData];
            /// 滚动到底
            [strongSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:strongSelf.viewmodel.listModels.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            /// 更新消息数量
            if (strongSelf.chatItemView.number != [strongSelf.viewmodel messageNumber]) {
                [strongSelf.chatItemView setNumber:[strongSelf.viewmodel messageNumber]];
            }
        }
        /// 开启定时器
        dispatch_resume(_timer);
    }];
}

/**
 添加响应事件

 @param target 目标
 @param action 事件
 */
- (void)addDraggingTarget:(id _Nullable )target action:(nonnull SEL)action
{
    _draggingTarget   = target;
    _draggingAction   = action;
}

/**
 加载更多数据
 */
- (void)loadMoreData
{
    if (self.viewmodel.hasMoreData) {
        __weak typeof(self)weakSelf = self;
        [self.viewmodel getChatList:^(BOOL success, NSString *message) {
            /// 加载更多
            __strong typeof(self)strongSelf = weakSelf;
            if (success) {
                [strongSelf.tableView reloadData];
            }
            /// 更新消息数量
            if (strongSelf.chatItemView.number != [strongSelf.viewmodel messageNumber]) {
                [strongSelf.chatItemView setNumber:[strongSelf.viewmodel messageNumber]];
            }
            [strongSelf.tableView.mj_header endRefreshing];
            /// 判断是否初始化加载最新消息定时器, 如果没有, 则开启创建并开启定时器
            if (strongSelf.needReadNewMessage == NO) {
                [strongSelf startGetNewChatTimer];
                strongSelf.needReadNewMessage = YES;
            }
            
        }];
    }
    else {
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark - tapViewController delegate
/// 用来更新 UI 界面
- (void)didUpdateViewUI
{
    NSLog(@"%@", self.view);
    NSLog(@"%@", self.tableView);
}

/// 滚动并将要显示界面, 可进行操作
- (void)willCanLoadData:(BOOL)isLoading
{
    if (!isLoading) {
        [self.tableView.mj_header beginRefreshing];
    }
}

#pragma mark - table delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ((TDLiveChatRoomChatListModel *)_viewmodel.topListModels[indexPath.row]).chatCellHeight;
    }
    else if (indexPath.section == 1) {
        return ((TDLiveChatRoomChatListModel *)_viewmodel.listModels[indexPath.row]).chatCellHeight;
    }
    return 62;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.sendMessageTextview) {
        TDLiveChatRoomChatListModel *chatModel;
        if (indexPath.section == 0) {
            chatModel = _viewmodel.topListModels[indexPath.row];
        }
        else if (indexPath.section == 1) {
            chatModel = _viewmodel.listModels[indexPath.row];
        }
        self.sendMessageTextview.chatModel = chatModel;
        
        /// 准备输入
        if (_draggingTarget && _draggingAction && [[_draggingTarget class] instancesRespondToSelector:NSSelectorFromString(@"onClickChatItemAction:")]) {
            [_draggingTarget performSelector:NSSelectorFromString(@"onClickChatItemAction:") withObject:self.chatItemView];
        }
        
    }
}

#pragma mark - table datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _viewmodel.topListModels.count;
    }
    else if (section == 1) {
        return _viewmodel.listModels.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDChatRoomTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TDChatRoomTextCell class]) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.model = _viewmodel.topListModels[indexPath.row];
    }
    else {
        cell.model = _viewmodel.listModels[indexPath.row];
    }
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideKeyBoard];
}

- (void)hideKeyBoard
{
    /// 取消响应
    if (_draggingTarget && _draggingAction && [[_draggingTarget class] instancesRespondToSelector:_draggingAction]) {
        [_draggingTarget performSelector:_draggingAction withObject:self];
    }
}

#pragma mark - textview delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        /// 发送信息
        [self sendMessage:nil];
        return NO;
    }
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (TDLiveChatRoomViewModel *)viewmodel
{
    if (!_viewmodel) {
        _viewmodel = [TDLiveChatRoomViewModel chatRoomWithSourceId:_sourceId type:_type];
    }
    return _viewmodel;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setDelegate: self];
        [_tableView setDataSource: self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (void)setSendMessageTextview:(TDChatRoomSendMessageTextView *)sendMessageTextview
{
    _sendMessageTextview = sendMessageTextview;
    [_sendMessageTextview.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    [_sendMessageTextview.textView setDelegate: self];
}

@synthesize isLoading;

@end
