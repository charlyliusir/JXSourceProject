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

@interface TDLiveVideoChatRoomController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, readwrite, assign) NSUInteger sourceId;
@property (nonatomic, readwrite, assign) NSUInteger type;

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

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        [_tableView setDelegate: self];
        [_tableView setDataSource: self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (TDLiveChatRoomViewModel *)viewmodel
{
    if (!_viewmodel) {
        _viewmodel = [TDLiveChatRoomViewModel chatRoomWithSourceId:_sourceId type:_type];
    }
    return _viewmodel;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
            else {
                NSLog(@"请求失败");
            }
            
            [strongSelf.tableView.mj_header endRefreshing];
            
        }];
    }
    else {
        [self.tableView.mj_header endRefreshing];
    }
}

#pragma mark - tapViewController delegate
- (void)didUpdateViewUI
{
    CGRect rect = self.tableView.frame;
    rect.size   = self.view.frame.size;
    self.tableView.frame = rect;
}

- (void)willCanLoadData:(BOOL)isLoading
{
    if (!isLoading) {
        [self loadMoreData];
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
    [cell setStyle];
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@synthesize isLoading;

@end
