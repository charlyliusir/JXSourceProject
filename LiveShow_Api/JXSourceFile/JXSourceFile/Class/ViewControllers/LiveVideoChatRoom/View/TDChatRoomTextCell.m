//
//  TDChatRoomTextCell.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDChatRoomTextCell.h"

#define TD_ChatRoom_Margin_Y 10
#define TD_ChatRoom_Avatar_Size 24
#define TD_ChatRoom_UserName_Margin_X 8
#define TD_ChatRoom_ChatContent_Margin_X -5
#define TD_ChatRoom_ChatContent_Max_Margin_X 69
#define TD_ChatRoom_ChatContent_Min_Height 34

@interface TDChatRoomTextCell()
/// 头像
@property (nonatomic, strong)UIImageView *avatarImageView;
/// 用户名称
@property (nonatomic, strong)UILabel *userNameLabel;
/// 发表时间
@property (nonatomic, strong)UILabel *chatTimeLabel;
/// 一级内容容器视图
@property (nonatomic, strong)UIImageView *chatContentView;
/// 发表内容
@property (nonatomic, strong)UILabel *chatContentLabel;
/// 二级内容容器视图
@property (nonatomic, strong)UIImageView *nextLevelContentView;
/// 二级内容
@property (nonatomic, strong)UILabel *nextLevelChatContentLabel;

@end

@implementation TDChatRoomTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.chatTimeLabel];
        [self.contentView addSubview:self.chatContentView];
        [self.chatContentView addSubview:self.chatContentLabel];
        [self.chatContentView addSubview:self.nextLevelContentView];
        [self.nextLevelContentView addSubview:self.nextLevelChatContentLabel];
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setup UI
- (void)setupUI
{
    
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TD_ChatRoom_Margin_Y);
        make.left.mas_equalTo(TD_UI_Margin_X);
        make.height.width.mas_equalTo(TD_ChatRoom_Avatar_Size);
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_avatarImageView);
        make.left.mas_equalTo(_avatarImageView.mas_right).mas_offset(TD_ChatRoom_UserName_Margin_X);
    }];
    
    [_chatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_userNameLabel);
        make.left.mas_equalTo(_userNameLabel.mas_right).mas_offset(TD_ChatRoom_UserName_Margin_X);
    }];
    
    [_chatContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameLabel.mas_bottom).mas_offset(TD_ChatRoom_Margin_Y);
        make.left.mas_equalTo(_userNameLabel).mas_offset(TD_ChatRoom_ChatContent_Margin_X);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-TD_ChatRoom_ChatContent_Max_Margin_X);
        make.right.mas_greaterThanOrEqualTo(_chatContentLabel).mas_offset(TD_ChatRoom_Margin_Y);
        make.right.mas_greaterThanOrEqualTo(_nextLevelContentView).mas_offset(TD_ChatRoom_Margin_Y);
//        make.bottom.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(_chatContentLabel).mas_offset(TD_ChatRoom_Margin_Y);
    }];
    
    [_chatContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(TD_ChatRoom_Margin_Y-TD_ChatRoom_ChatContent_Margin_X);
        make.top.mas_offset(TD_ChatRoom_Margin_Y);
    }];
    
    [_nextLevelContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_chatContentLabel);
        make.top.mas_equalTo(_chatContentLabel.mas_bottom).mas_offset(-TD_ChatRoom_ChatContent_Margin_X);
        make.right.mas_equalTo(_nextLevelChatContentLabel).mas_offset(-TD_ChatRoom_ChatContent_Margin_X);
        make.bottom.mas_equalTo(_nextLevelChatContentLabel).mas_offset(-TD_ChatRoom_ChatContent_Margin_X);
    }];

    [_nextLevelChatContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(-TD_ChatRoom_ChatContent_Margin_X);
    }];
}

- (void)setStyle
{
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.user_logo] placeholderImage:[UIImage imageNamed:@""]];
    [_userNameLabel setText:_model.user_name];
    [_chatTimeLabel setText:_model.date];
    [_chatContentLabel setText:_model.msg_content];
    
    [_nextLevelContentView setHidden:YES];
}

- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_avatarImageView setBackgroundColor:[UIColor orangeColor]];
        [_avatarImageView.layer setCornerRadius:12];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView setContentMode:UIViewContentModeScaleToFill];
    }
    return _avatarImageView;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_userNameLabel setText:@""];
        [_userNameLabel setTextColor:TDHexStringColor(@"#808080")];
        [_userNameLabel setFont:TDFontSize(12)];
    }
    return _userNameLabel;
}

- (UILabel *)chatTimeLabel
{
    if (!_chatTimeLabel) {
        _chatTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_chatTimeLabel setText:@""];
        [_chatTimeLabel setTextColor:TDHexStringColor(@"#bcbcbc")];
        [_chatTimeLabel setFont:TDFontSize(11)];
    }
    return _chatTimeLabel;
}

- (UIImageView *)chatContentView
{
    if (!_chatContentView) {
        
        _chatContentView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"td_chat_bubble"] stretchableImageWithLeftCapWidth:5 topCapHeight:20]];
        [_chatContentView setContentMode:UIViewContentModeScaleToFill];
//        [_chatContentView setBackgroundColor:TDHexStringColor(@"#f4f5f6")];
    }
    return _chatContentView;
}

- (UILabel *)chatContentLabel
{
    if (!_chatContentLabel) {
        _chatContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_chatContentLabel setText:@""];
        [_chatContentLabel setTextColor:TDHexStringColor(@"#222222")];
        [_chatContentLabel setFont:TDFontSize(15)];
        [_chatContentLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_chatContentLabel setNumberOfLines:0];
    }
    return _chatContentLabel;
}

- (UIImageView *)nextLevelContentView
{
    if (!_nextLevelContentView) {
        _nextLevelContentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_nextLevelContentView setBackgroundColor:TDHexStringColor(@"#ffffff")];
    }
    return _nextLevelContentView;
}

- (UILabel *)nextLevelChatContentLabel
{
    if (!_nextLevelChatContentLabel) {
        _nextLevelChatContentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_nextLevelChatContentLabel setText:@""];
        [_nextLevelChatContentLabel setTextColor:TDHexStringColor(@"#222222")];
        [_nextLevelChatContentLabel setFont:TDFontSize(11)];
        [_nextLevelChatContentLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [_nextLevelChatContentLabel setNumberOfLines:0];
    }
    return _nextLevelChatContentLabel;
}

@end
