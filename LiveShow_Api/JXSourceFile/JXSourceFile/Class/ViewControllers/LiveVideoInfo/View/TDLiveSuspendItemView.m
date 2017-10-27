//
//  TDLiveSuspendItemView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveSuspendItemView.h"

@interface TDLiveSuspendItemView()
@property (nonatomic, strong) UIImageView *iconImageView;
/// 数字 label
@property (nonatomic, strong) UIButton *numberLabel;

@end

@implementation TDLiveSuspendItemView

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView setContentMode:UIViewContentModeScaleToFill];
    }
    return _iconImageView;
}

- (UIButton *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_numberLabel setBackgroundColor:TDHexStringColor(@"#ffffff")];
        [_numberLabel setTitle:@"0" forState:UIControlStateNormal];
        [_numberLabel.layer setCornerRadius:14/2];
        [_numberLabel.layer setMasksToBounds:YES];
        [_numberLabel.titleLabel setFont:TDFontSize(10)];
        [_numberLabel setContentEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 2)];
    }
    return _numberLabel;
}

- (instancetype)initWithImageName:(NSString *)imageName titleColor:(NSString *)colorHex itemType:(TDSuspentItem)type
{
    if (self = [super init]) {
        _itemType = type;
        [self addSubview:self.iconImageView];
        [self addSubview:self.numberLabel];
        [self.iconImageView setImage:[UIImage imageNamed:imageName]];
        [self.numberLabel setTitleColor:TDHexStringColor(colorHex) forState:UIControlStateNormal];
        [self setupUI];
    }
    return self;
}

+ (instancetype)liveSuspendItemWithImageName:(NSString *)imageName titleColor:(NSString *)colorHex itemType:(TDSuspentItem)type
{
    return [[self alloc] initWithImageName:imageName titleColor:colorHex itemType:type];
}

- (void)setNumber:(NSUInteger)number
{
    _number = number;
    [_numberLabel setTitle:[NSString stringWithFormat:@"%lu", (unsigned long)number] forState:UIControlStateNormal];
}

- (void)setLabelHidden:(BOOL)isHidden
{
    [_numberLabel setHidden:isHidden];
}

- (void)setupUI
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.height.mas_equalTo(@14);
        make.width.mas_greaterThanOrEqualTo(@14);
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
