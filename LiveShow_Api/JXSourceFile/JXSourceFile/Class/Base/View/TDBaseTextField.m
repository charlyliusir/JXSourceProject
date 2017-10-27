//
//  TDBaseTextField.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/26.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseTextField.h"

@implementation TDBaseTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        [self addObserver:self forKeyPath:@"UITextFieldLabel.frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    if ([keyPath isEqualToString:@"UITextFieldLabel.frame"]) {
        /// 操作
        NSLog(@"");
    }
}

////控制显示文本的位置
//- (CGRect)textRectForBounds:(CGRect)bounds{
//
//    CGRect inset = CGRectMake(bounds.origin.x + 15, bounds.origin.y, bounds.size.width - 25, bounds.size.height);
//
//    return inset;
//
//}
//
////控制编辑文本的位置
//- (CGRect)editingRectForBounds:(CGRect)bounds{
//
//    CGRect inset = CGRectMake(bounds.origin.x + 15, bounds.origin.y, bounds.size.width - 25, bounds.size.height);
//
//    return inset;
//
//}
//
//// 控制placeHolder的位置，往右缩 56 （这是左视图和距离左边边距的和）
//- (CGRect)placeholderRectForBounds:(CGRect)bounds{
//    //或者这样写简单些
//    return CGRectInset(bounds, 15, 0);
//
//}

@end
