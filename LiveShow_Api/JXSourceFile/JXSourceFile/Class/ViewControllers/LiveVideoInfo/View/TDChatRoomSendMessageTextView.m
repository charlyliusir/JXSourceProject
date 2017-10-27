//
//  TDChatRoomSendMessageTextFiled.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/24.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDChatRoomSendMessageTextView.h"

#define TD_SEND_MESSAGE_TEXTVIEW_NORMAL @"该活动不允许聊天"
#define TD_SEND_MESSAGE_TEXTVIEW_FONT_NORMAL 16
#define TD_SEND_MESSAGE_TEXTVIEW_HEIGHT_NORMAL 44
#define TD_SEND_MESSAGE_TEXTVIEW_WIDTH_NORMAL 200

@interface TDChatRoomSendMessageTextView()<UITextViewDelegate>
/// 聊天框
@property (nonatomic, readwrite, strong) TDBaseTextView *textView;
/// 发送按钮
@property (nonatomic, readwrite, strong) UIButton *sendButton;
@end

@implementation TDChatRoomSendMessageTextView

- (NSAttributedString *)attributedTextFieldPlaceholderText:(NSString *)text
{
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: TDFontSize(TD_SEND_MESSAGE_TEXTVIEW_FONT_NORMAL), NSForegroundColorAttributeName: TDHexStringColor(@"#bcbcbc")}];
    return attributedString;
}

- (TDBaseTextView *)textView
{
    if (!_textView) {
        _textView = [[TDBaseTextView alloc] initWithFrame:CGRectZero];
        [_textView setTextAlignment:NSTextAlignmentLeft];
        [_textView setFont:TDFontSize(TD_SEND_MESSAGE_TEXTVIEW_FONT_NORMAL)];
        [_textView.layer setCornerRadius:5];
        [_textView.layer setMasksToBounds: YES];
        [_textView.layer setBorderWidth:1];
        [_textView.layer setBorderColor:TDHexStringColor(@"#ebebec").CGColor];
        [_textView setDelegate:self];
    }
    return _textView;
}

- (UIButton *)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:TDHexStringColor(@"#ffffff") forState:UIControlStateNormal];
        [_sendButton setBackgroundColor:TDHexStringColor(@"#1b9ed4")];
        [_sendButton setContentEdgeInsets:UIEdgeInsetsMake(10, 2, 10, 2)];
        [_sendButton.layer setCornerRadius:14];
        [_sendButton.layer setMasksToBounds: YES];
    }
    return _sendButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:TDHexStringColor(@"#ffffff")];
        [self addSubview:self.textView];
        [self addSubview:self.sendButton];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    [topLineView setBackgroundColor:TDHexStringColor(@"#ebebec")];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    [bottomLineView setBackgroundColor:TDHexStringColor(@"#ebebec")];
    
    [self addSubview:topLineView];
    [self addSubview:bottomLineView];
    
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@(1));
    }];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(@(1));
    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(_sendButton.mas_left).mas_offset(-10);
    }];
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self).offset(-10);
        make.height.mas_equalTo(@(36));
        make.width.mas_equalTo(@(50));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
