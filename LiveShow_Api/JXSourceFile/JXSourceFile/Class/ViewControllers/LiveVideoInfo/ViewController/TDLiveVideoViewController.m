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
#import "TDLiveVideoViewModel.h"
#import "TDSendMessageRequest.h"

#import "TDLiveSuspendView.h"
#import "TDLiveVideoTopView.h"
#import "TDLiveClipView.h"
#import "TDChatRoomSendMessageTextView.h"

#import "TDLiveVideoDynamicController.h"
#import "TDLiveVideoChatRoomController.h"
#import "TDLiveVideoIntroController.h"
#import "TDLivePlayerViewController.h"

static NSUInteger const kTDSendMessageHeight = 56;

@interface TDLiveVideoViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) TDLiveVideoTopView *topView;
@property (nonatomic, strong) TDLiveClipView *clipView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) CLTapBarItem *dynamicItem;
@property (nonatomic, strong) CLTapBarItem *chatItem;
@property (nonatomic, strong) CLTapBarItem *introItem;
@property (nonatomic, strong) CLTapViewController * tapViewController;
@property (nonatomic, strong) TDLiveSuspendView *liveSuspendView;
@property (nonatomic, strong) TDLiveSuspendItemView *chatItemView;
@property (nonatomic, strong) TDLiveSuspendItemView *praiseItemView;
@property (nonatomic, strong) TDLiveSuspendItemView *voteItemView;
@property (nonatomic, strong) TDLiveSuspendItemView *darwItemView;
@property (nonatomic, strong) TDChatRoomSendMessageTextView *sendMessageTextview;
@property (nonatomic, strong) TDActivityInfoViewModel *viewmodel;
@property (nonatomic, strong) TDLiveVideoViewModel *videoViewModel;

@property (nonatomic, strong) NSMutableArray *itemLists;
@property (nonatomic, strong) NSMutableArray *suspendItemLists;

@property (nonatomic, strong) UITapGestureRecognizer *tap;

@property (nonatomic, strong) TDLivePlayerViewController *livePlayerController;

@property (nonatomic, strong) NSLayoutConstraint *containerHCons;
@property (nonatomic, strong) NSLayoutConstraint *containerBCons;

@end

@implementation TDLiveVideoViewController

/**
 构造函数

 @param sourceId 活动id
 @param sourceType 活动类型
 @return 类本身
 */
- (instancetype)initWithSourceId:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType
{
    if (self = [super init]) {
        _sourceId   = sourceId;
        _sourceType = sourceType;
    }
    return self;
}

/**
 类构造函数
 
 @param sourceId 活动id
 @param sourceType 活动类型
 @return 类本身
 */
+ (instancetype)liveVideoWithSourceId:(NSUInteger)sourceId sourceType:(NSUInteger)sourceType
{
    return [[self alloc] initWithSourceId:sourceId sourceType:sourceType];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    /// 设置背景颜色为白色
    [self.view setBackgroundColor:TDHexStringColor(@"#ffffff")];
    
    /// 添加试图
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.clipView];
    [self.contentView addSubview:self.tapViewController];
    
    /// 网络请求
    [self loadData];
    
    /// 个别界面布局
    [self setupUI];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - private method
- (void)loadData
{
    /// 请求组件相关信息
    [self.viewmodel getActivityInfo:^(BOOL success, NSString *message) {
        if (success) {
            /// 网络请求成功, 根据详情信息布局
            [self initUI];
        }
        else {
            /// 错误提示
            NSLog(@"请求失败---%@", message);
        }
    } withSourceId:_sourceId];
    
    /// 请求视频相关信息
    [self.videoViewModel getVideoInfo:^(BOOL success, NSString *message) {
        if (success) {
            /// 网络请求成功, 根据详情信息布局
            [self initVideoUI];
        }
        else {
            /// 错误提示
            NSLog(@"请求失败---%@", message);
        }
    } withSourceId:_sourceId];
}

- (void)initUI
{
    [self.itemLists removeAllObjects];
    if (_viewmodel.showDynamic) {
        [self.itemLists addObject:self.dynamicItem];
    }
    if (_viewmodel.showChat) {
        [self.chatItemView setNumber:[_viewmodel messageNumber]];
        [self.itemLists addObject:self.chatItem];
        [self.suspendItemLists addObject:self.chatItemView];
        [self.contentView addSubview:self.sendMessageTextview];
    }    
    if (_viewmodel.showReward) {
        [self.praiseItemView setNumber:[_viewmodel rewardNumber]];
        [self.suspendItemLists addObject:self.praiseItemView];
    }
    if (_viewmodel.showVote) {
        [self.voteItemView setNumber:[_viewmodel voteNumber]];
        [self.suspendItemLists addObject:self.voteItemView];
    }
    if (_viewmodel.showLuck) {
        [self.suspendItemLists addObject:self.darwItemView];
    }
    /// 如果需要展示片段, 添加时间监听回调
    if (_viewmodel.showDispaly) {
        __weak typeof(self)weakSelf = self;
        [self.tapViewController setHandler:^(BOOL hidden) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            /// 展示或者隐藏片段
            [strongSelf showClipViewUI:!hidden];
        }];
    }
    [self.topView setActivityViewmodel:_viewmodel];
    [self showClipViewUI:[_viewmodel showDispaly]];
    /// 动态布局互动组件模块
    [self.itemLists addObject:self.introItem];
    [self.tapViewController setBarItems:self.itemLists];
    [self.tapViewController setOtherButtonHidden:![_viewmodel showDispaly]];
    [self.liveSuspendView setItems:self.suspendItemLists];
    [self.contentView addSubview:self.liveSuspendView];
    
    /// 布局介绍界面
    TDLiveVideoIntroController *introController = (TDLiveVideoIntroController *)self.introItem.controller;
    introController.viewmodel = _viewmodel;
    
    /// 视图布局
    [self initsetupUI];
    
    /// 注册通知
    [self setupNotify];
    
    /// 添加手势
    [self setupGestureRecognizer];
}

- (void)initVideoUI
{
    [self.clipView setSourcess:self.videoViewModel.videoClips.copy];
}

- (void)setupUI
{
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(211);
    }];
    [_tapViewController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(_clipView.mas_bottom);
    }];
    [_clipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(_topView.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    
    [self.itemLists addObject:self.introItem];
    [self.tapViewController setBarItems:self.itemLists];
    
    [_topView.playButton addTarget:self action:@selector(onClickPlayAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topView.backButton addTarget:self action:@selector(onBackAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)initsetupUI
{
    CGFloat paddingY = [TDLiveSuspendView paddingY];
    NSArray *constraints = [_sendMessageTextview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(kTDSendMessageHeight));
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(@(kTDSendMessageHeight));
    }];
    
    MASConstraint *consH = [constraints firstObject];
    MASConstraint *consB = [constraints lastObject];
    
    self.containerHCons = [consH valueForKey:@"layoutConstraint"];
    self.containerBCons = [consB valueForKey:@"layoutConstraint"];
    
    __weak typeof(self) weakSelf = self;
    self.sendMessageTextview.textView.textHeightChangedBlock = ^(NSString *text, CGFloat textHeight) {
        weakSelf.containerHCons.constant = textHeight + 20.0;
    };
    
    [_liveSuspendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
        make.bottom.mas_equalTo(_sendMessageTextview.mas_top).offset(-12);
        make.width.mas_equalTo(@44);
        make.height.mas_equalTo(@(44*_liveSuspendView.itemLists.count + (_liveSuspendView.itemLists.count - 1) * paddingY));
    }];
}

- (void)showClipViewUI:(BOOL)isShow
{
    CGFloat height = isShow ? 56: 0;
    [_clipView setHidden:!isShow];
    [_clipView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.tapViewController setFrame:CGRectMake(0, 211+height, self.view.frame.size.width, self.view.frame.size.height-211-height)];
}

- (void)setupNotify
{
    /// 注册键盘弹出和回收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateKeyBoardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupGestureRecognizer
{
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickTapAction:)];
}

#pragma mark - notify
- (void)updateKeyBoardFrame:(NSNotification *)notification
{
    NSDictionary *object = notification.userInfo;
    /// 动画加载时间
    CGFloat duration = [object[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    /// 键盘最终停留的坐标
    CGRect endFrame  = [object[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    // 修改约束
//    self.containerBCons.constant = endFrame.origin.y != screenH ? -endFrame.size.height : 0;
    
    [UIView animateWithDuration:duration animations:^{
        CGRect rect = self.view.frame;
        rect.origin.y = endFrame.origin.y != screenH ? -endFrame.size.height : 0;
        self.view.frame = rect;
    }completion:^(BOOL finished) {
        if (!_chatItemView.isSelected) {
            /// 键盘时间结束, 如果聊天按钮非选择状态, 回收聊天输入框
            [self hideSendMessage];
        }
    }];
}

- (void)onClickTapAction:(id)sender
{
    [_chatItemView setSelected:NO];
    if (self.sendMessageTextview.textView.isFirstResponder) {
        /// 如果当前输入框为第一响应者, 则结束编辑状态
        [self.view endEditing:YES];
    }
    else {
        [self hideSendMessage];
    }
}

#pragma mark - button action

/// 点击播放大按钮, 进入播放器模式
- (void)onClickPlayAction:(UIButton *)button
{
    if (self.videoViewModel.videoClips.count > 0) {
        /// 将播放器添加到视图中
        [self addChildViewController:self.livePlayerController];
        [self.view addSubview:self.livePlayerController.view];
        [self.livePlayerController setViewmodel:self.viewmodel];
        [self.livePlayerController setVideoViewmodel:self.videoViewModel];
        [self.livePlayerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.topView);
        }];
    }
}

/// 点击返回按钮
- (void)onBackAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

/// 点击聊天按钮
- (void)onClickChatItemAction:(TDLiveSuspendItemView *)itemView
{
    NSLog(@"onClickChatItemAction:");
    /// 改变选中状态
    [itemView setSelected:!itemView.isSelected];
    /// 如果是选中状态, 改变UI
    if (itemView.isSelected) {
        [_contentView addGestureRecognizer:self.tap];
        /// 模块选项注焦到聊天室模块
        [_tapViewController setSelectBarItem:[self.itemLists indexOfObject:self.chatItem]];
        /// 弹出聊天输入框
        self.containerBCons.constant = 0;
        [UIView animateWithDuration:0.25 animations:^{
            /// 强制绘制, 执行动画
            [self.view.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            /// 弹出键盘
            [_sendMessageTextview.textView becomeFirstResponder];
        }];
    }
    else {
        if (self.sendMessageTextview.textView.isFirstResponder) {
            /// 如果当前输入框为第一响应者, 则结束编辑状态
            [self.view endEditing:YES];
        }
        else {
            /// 隐藏发送消息输入框
            [self hideSendMessage];
        }
    }
}

/// 隐藏发送消息输入框
- (void)hideSendMessage
{
    /// 移除点击手势
    [_contentView removeGestureRecognizer:self.tap];
    /// 将聊天内容置空
    [self.sendMessageTextview.textView setText:@""];
    [self.sendMessageTextview.textView textDidChange];
    /// 如果当前输入框不是第一响应者, 回收输入框
    self.containerBCons.constant = kTDSendMessageHeight;
    [UIView animateWithDuration:0.25 animations:^{
        /// 强制绘制, 执行动画
        [self.view.superview layoutIfNeeded];
    } completion:nil];
}

/**
 点击打赏按钮
 
 @param itemView 打赏按钮
 */
- (void)onClickPraiseItemAction:(TDLiveSuspendItemView *)itemView
{
    NSLog(@"onClickPraiseItemAction:");
}

/**
 点击投票按钮
 
 @param itemView 投票按钮
 */
- (void)onClickVoteItemAction:(TDLiveSuspendItemView *)itemView
{
    NSLog(@"onClickVoteItemAction:");
}

/**
 点击抽奖按钮
 
 @param itemView 抽奖按钮
 */
- (void)onClickDarwItemAction:(TDLiveSuspendItemView *)itemView
{
    NSLog(@"onClickDarwItemAction:");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - collection delegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDLiveClipsViewModel *viewmodel = self.clipView.sources[indexPath.row];
    return CGSizeMake([viewmodel cellWidth], 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/**
 活动详情业务视图模型
 
 @return 视图模型
 */
- (TDActivityInfoViewModel *)viewmodel
{
    if (!_viewmodel) {
        _viewmodel = [[TDActivityInfoViewModel alloc] init];
        _viewmodel.owner = self;
    }
    return _viewmodel;
}

- (TDLiveVideoViewModel *)videoViewModel
{
    if (!_videoViewModel) {
        _videoViewModel = [[TDLiveVideoViewModel alloc] init];
    }
    return _videoViewModel;
}

- (TDLivePlayerViewController *)livePlayerController
{
    if (!_livePlayerController) {
//        _livePlayerController = [[TDLivePlayerViewController alloc] initWithVideoUrlString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
        _livePlayerController = [[TDLivePlayerViewController alloc] init];
    }
    return _livePlayerController;
}

/**
 顶部播放器视图

 @return 视图
 */
- (TDLiveVideoTopView *)topView
{
    if (!_topView) {
        _topView = [[TDLiveVideoTopView alloc] initWithFrame:CGRectZero];
    }
    return _topView;
}


/**
 显示片段的视图

 @return 视图
 */
- (TDLiveClipView *)clipView
{
    if (!_clipView) {
        _clipView = [[TDLiveClipView alloc] initWithDelegate:self];
    }
    return _clipView;
}

/**
 容器视图, 用来做位移
 
 @return 容器视图
 */
- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        [_contentView setBackgroundColor:TDHexStringColor(@"#ffffff")];
    }
    return _contentView;
}

/**
 模块视图数组
 
 @return 数组
 */
- (NSMutableArray *)itemLists
{
    if (!_itemLists) {
        _itemLists = [NSMutableArray array];
    }
    return _itemLists;
}

/**
 悬浮框视图数组
 
 @return 数组
 */
- (NSMutableArray *)suspendItemLists
{
    if (!_suspendItemLists) {
        _suspendItemLists = [NSMutableArray array];
    }
    return _suspendItemLists;
}

/**
 动态模块
 
 @return 视图
 */
- (CLTapBarItem *)dynamicItem
{
    if (!_dynamicItem) {
        _dynamicItem = [[CLTapBarItem alloc] initWithTitle:@"动态" controller:[TDLiveVideoDynamicController liveVideoDynamicControllerWithSourceId:_sourceId type:_sourceType]];
    }
    return _dynamicItem;
}

/**
 聊天室模块
 
 @return 视图
 */
- (CLTapBarItem *)chatItem
{
    if (!_chatItem) {
        TDLiveVideoChatRoomController *chatRoomVC = [TDLiveVideoChatRoomController liveVideoChatRoomControllerWithSourceId:_sourceId type:_sourceType];
        [chatRoomVC addDraggingTarget:self action:@selector(onClickTapAction:)];
        [chatRoomVC setChatItemView:self.chatItemView];
        [chatRoomVC setSendMessageTextview:self.sendMessageTextview];
        _chatItem = [[CLTapBarItem alloc] initWithTitle:@"聊天室" controller:chatRoomVC];
    }
    return _chatItem;
}

/**
 介绍模块
 
 @return 视图
 */
- (CLTapBarItem *)introItem
{
    if (!_introItem) {
        _introItem = [[CLTapBarItem alloc] initWithTitle:@"介绍" controller:[[TDLiveVideoIntroController alloc] init]];
    }
    return _introItem;
}

/**
 模块视图控制器
 
 @return 视图控制器
 */
- (CLTapViewController *)tapViewController
{
    if (!_tapViewController) {
        _tapViewController = [[CLTapViewController alloc] initWithFrame:CGRectMake(0, 211, self.view.frame.size.width, self.view.frame.size.height-211)];
    }
    return _tapViewController;
}

/**
 悬浮框聊天视图
 
 @return 视图
 */
- (TDLiveSuspendItemView *)chatItemView
{
    if (!_chatItemView) {
        _chatItemView = [TDLiveSuspendItemView liveSuspendItemWithImageName:@"td_items_chat" titleColor:@"#00AAE4" itemType:TDSuspentItemChat];
        [_chatItemView addTarget:self action:@selector(onClickChatItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatItemView;
}

/**
 悬浮框打赏视图
 
 @return 视图
 */
- (TDLiveSuspendItemView *)praiseItemView
{
    if (!_praiseItemView) {
        _praiseItemView = [TDLiveSuspendItemView liveSuspendItemWithImageName:@"td_items_praise" titleColor:@"#FC4764" itemType:TDSuspentItemPraise];
        [_praiseItemView addTarget:self action:@selector(onClickPraiseItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseItemView;
}

/**
 悬浮框投票视图
 
 @return 视图
 */
- (TDLiveSuspendItemView *)voteItemView
{
    if (!_voteItemView) {
        _voteItemView = [TDLiveSuspendItemView liveSuspendItemWithImageName:@"td_items_vote" titleColor:@"#00D1B6" itemType:TDSuspentItemVote];
        [_voteItemView addTarget:self action:@selector(onClickVoteItemAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voteItemView;
}

/**
 悬浮框抽奖视图
 
 @return 视图
 */
- (TDLiveSuspendItemView *)darwItemView
{
    if (!_darwItemView) {
        _darwItemView = [TDLiveSuspendItemView liveSuspendItemWithImageName:@"td_items_draw" titleColor:@"#FFC33A" itemType:TDSuspentItemDraw];
        [_darwItemView addTarget:self action:@selector(onClickDarwItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_darwItemView setLabelHidden:YES];
    }
    return _darwItemView;
}

/**
 悬浮框视图
 
 @return 视图
 */
- (TDLiveSuspendView *)liveSuspendView
{
    if (!_liveSuspendView) {
        _liveSuspendView = [[TDLiveSuspendView alloc] init];
    }
    return _liveSuspendView;
}

/**
 发送消息视图
 
 @return 视图
 */
- (TDChatRoomSendMessageTextView *)sendMessageTextview
{
    if (!_sendMessageTextview) {
        _sendMessageTextview = [[TDChatRoomSendMessageTextView alloc] initWithFrame:CGRectZero];
    }
    return _sendMessageTextview;
}

@end
