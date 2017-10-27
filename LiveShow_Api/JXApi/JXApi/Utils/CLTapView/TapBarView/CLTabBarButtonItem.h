//
//  CLTabBarButtonItem.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CLTabBarButtonItemState) {
    CLTabBarButtonItemStateNormal,
    CLTabBarButtonItemStateSelected
};

@interface CLTabBarButtonItem : UIControl
@property (nonatomic, readonly, strong) UILabel *titleLabel;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) CLTabBarButtonItemState barState;

- (void)setTitleLabelText: (NSString *)text withBarState: (CLTabBarButtonItemState)barState;
- (void)setTitleLabelFont: (UIFont *)font withBarState: (CLTabBarButtonItemState)barState;
- (void)setTitleLabelTextColor: (UIColor *)color withBarState: (CLTabBarButtonItemState)barState;

- (void)setupUILayout;
- (void)updateUILayout;

@end
