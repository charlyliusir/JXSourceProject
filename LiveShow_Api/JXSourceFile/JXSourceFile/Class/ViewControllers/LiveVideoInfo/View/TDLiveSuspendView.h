//
//  TDLiveSuspendView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDLiveSuspendItemView.h"

@interface TDLiveSuspendView : UIView

@property (nonatomic, readonly, strong) NSMutableArray *itemLists;

+ (CGFloat)paddingY;

- (instancetype)initWithItems:(NSArray *)items;
+ (instancetype)liveSuspendWithItems:(NSArray *)items;

- (void)setItems:(NSArray *)items;
- (void)setItemView:(TDLiveSuspendItemView *)view;


@end
