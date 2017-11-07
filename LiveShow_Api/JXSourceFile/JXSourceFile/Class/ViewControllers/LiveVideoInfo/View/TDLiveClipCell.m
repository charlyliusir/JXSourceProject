//
//  TDLiveClipCell.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/30.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveClipCell.h"

@interface TDLiveClipCell()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TDLiveClipCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setBackgroundColor:TDHexStringColor(@"#ffffff")];
    }
    return self;
}

- (void)setupUI
{
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [_titleLabel setTextColor:TDHexStringColor(@"#222222")];
        [_titleLabel setText:@"重庆火锅重庆火锅重庆火锅"];
        [_titleLabel setFont:TDFontSize(12)];
        [_titleLabel setTextAlignment:NSTextAlignmentLeft];
        [_titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [_titleLabel setNumberOfLines:2];
    }
    return _titleLabel;
}

- (void)setViewModel:(TDLiveClipsViewModel *)viewModel
{
    _viewModel = viewModel;
    _titleLabel.text = viewModel.model.title;
    if (viewModel.isSelected) {
        [self setBackgroundColor:TDHexStringColor(@"#1b9ed4")];
        [_titleLabel setTextColor:TDHexStringColor(@"#ffffff")];
    }
    else {
        [self setBackgroundColor:TDHexStringColor(@"#ffffff")];
        [_titleLabel setTextColor:TDHexStringColor(@"#222222")];
    }
}

@end
