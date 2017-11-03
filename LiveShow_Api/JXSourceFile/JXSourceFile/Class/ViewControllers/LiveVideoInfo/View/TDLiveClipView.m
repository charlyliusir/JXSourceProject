//
//  TDLiveClipView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveClipView.h"
#import "TDLiveClipCell.h"
#define kTDLiveClipCellIdentifier @"TDLiveClipCellIdentifier"

@interface TDLiveClipView () <UICollectionViewDataSource>
@property (nonatomic, readwrite, strong)NSArray *sources;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation TDLiveClipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (instancetype)initWithDelegate:(id <UICollectionViewDelegate>) delegate
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupUI];
        [self setBackgroundColor:TDHexStringColor(@"#f4f5f6")];
        [self setHidden:YES];
        _delegate = delegate;
        _collection.delegate = delegate;
    }
    return self;
}   

- (void)setupUI
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [contentView setBackgroundColor:[UIColor clearColor]];
    
    UIButton *liveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [liveButton setBackgroundColor:TDHexStringColor(@"#1b9ed4")];
    [liveButton setTitle:@"正在直播" forState:UIControlStateNormal];
    [liveButton setTitleColor:TDHexStringColor(@"#ffffff") forState:UIControlStateNormal];
    [liveButton.titleLabel setFont:TDFontSize(12)];
    [liveButton.titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [liveButton.titleLabel setNumberOfLines:2];
    [liveButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UILabel *clipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [clipLabel setText:@"选集"];
    [clipLabel setTextColor:TDHexStringColor(@"#222222")];
    [clipLabel setFont:TDFontSize(15)];
    [clipLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [clipLabel setNumberOfLines:2];
    
    [contentView addSubview:liveButton];
    [contentView addSubview:clipLabel];
    
    [self addSubview:contentView];
    [self addSubview:self.collection];
    
    [self.collection registerClass:[TDLiveClipCell class] forCellWithReuseIdentifier:kTDLiveClipCellIdentifier];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(clipLabel).mas_offset(7.5);
    }];
    [liveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView);
        make.left.mas_equalTo(contentView).mas_offset(12);
        make.width.height.mas_offset(40);
    }];
    [clipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView);
        make.width.mas_offset(15);
        make.left.mas_equalTo(liveButton.mas_right).offset(7.5);
    }];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.mas_right);
        make.top.bottom.right.mas_equalTo(self);
    }];
    
}

#pragma mark - collection datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDLiveClipsViewModel *viewmodel = self.sources[indexPath.row];
    TDLiveClipCell *cell = (TDLiveClipCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kTDLiveClipCellIdentifier forIndexPath:indexPath];
    [cell.titleLabel setText:viewmodel.model.title];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSArray *)sources
{
    if (!_sources) {
        _sources = [NSArray array];
    }
    return _sources;
}

- (void)setSourcess:(NSArray *)sources
{
    _sources = sources;
    
    if (sources.count > 0) {
        [_collection reloadData];
    }
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//        [_layout setMinimumLineSpacing:7.5];
    }
    return _layout;
}

- (UICollectionView *)collection
{
    if (!_collection) {
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        [_collection setBackgroundColor:[UIColor clearColor]];
        _collection.dataSource = self;
    }
    return _collection;
}

@end
