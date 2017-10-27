//
//  UITextView+TDInputView.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/24.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "UITextView+TDInputView.h"

#define TD_INPUTVIEW_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation UITextView (TDInputView)

- (void)setTextFieldInputAccessoryView
{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, TD_INPUTVIEW_WIDTH, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * spaceBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(2, 5, 40, 25);
    [doneBtn addTarget:self action:@selector(dealKeyboardHide) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc]initWithCustomView:doneBtn];
    NSArray * buttonsArray = [NSArray arrayWithObjects:spaceBtn,doneBtnItem,nil];
    [topView setItems:buttonsArray];
    [self setInputAccessoryView:topView];
    [self setAutocorrectionType:UITextAutocorrectionTypeNo];
    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
}

- (void)dealKeyboardHide
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

@end
