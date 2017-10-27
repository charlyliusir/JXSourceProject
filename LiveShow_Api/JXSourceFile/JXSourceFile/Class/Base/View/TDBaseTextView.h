//
//  TDBaseTextView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/24.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TDTextHeightChangedBlock)(NSString *text, CGFloat textHeight);

@interface TDBaseTextView : UITextView

@property (nonatomic, copy) TDTextHeightChangedBlock textHeightChangedBlock;
@property (nonatomic, assign) NSInteger maxNumberOfLines;
@property (nonatomic, assign) NSUInteger cornerRadius;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

// 当文字改变时应该调用该方法
- (void)textDidChange;

@end
