//
//  TDLiveClipsViewModel.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveClipsViewModel.h"

@implementation TDLiveClipsViewModel

- (instancetype)initWithModel:(TDLiveClipsModel *)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

+ (instancetype)liveClipsWithModel:(TDLiveClipsModel *)model
{
    return [[self alloc] initWithModel:model];
}

- (CGFloat)titleWidth
{
    if (_model && ![_model.title isEqualToString:@""]) {
        CGFloat width = 30;
        NSString *titleStr = _model.title;
        UIFont *sizeFont   = TDFontSize(12);
        CGFloat labelSize  = sizeFont.lineHeight;
        CGFloat titlewidth = [titleStr boundingRectWithSize:CGSizeMake((labelSize * 6), 30) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: sizeFont} context:nil].size.width;
        return titlewidth > width ? titlewidth : width;
    }
    else {
        return 0;
    }
}

- (CGFloat)cellWidth
{
    CGFloat width = 5 + 5;
    return width + [self titleWidth];
}

@end
