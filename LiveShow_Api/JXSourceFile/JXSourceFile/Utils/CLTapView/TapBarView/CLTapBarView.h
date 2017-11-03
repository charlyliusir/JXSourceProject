//
//  CLTapBarView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTapBarItem.h"
#import "CLTapBarViewDelegate.h"
#import "CLTapBarCommons.h"

@interface CLTapBarView : UIView

@property (nonatomic, weak) id <CLTapBarViewDelegate> delegate;
/// 展开按钮
@property (nonatomic, readonly, strong) UIButton * showView;

@property (nonatomic, strong) NSMutableArray * barItems;
@property (nonatomic, assign) NSUInteger selectBarItem;
    
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, strong) UIColor *barTitleColor;
@property (nonatomic, strong) UIColor *barTitleTintColor;
    
@property (nonatomic, strong) UIFont *barTitleFont;
@property (nonatomic, strong) UIFont *barTitleTintFont;

- (void)setBarItem: (CLTapBarItem *)barItem;
@end
