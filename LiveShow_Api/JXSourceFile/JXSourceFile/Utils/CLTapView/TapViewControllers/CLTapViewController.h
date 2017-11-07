//
//  CLTapViewController.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLTapBarDelegate.h"

typedef void(^onClickOtherButtonHandler)(BOOL hidden);

@interface CLTapViewController : UIScrollView

@property (nonatomic,   weak) id <CLTapBarDelegate> tapBarDelegate;

@property (nonatomic,   copy) onClickOtherButtonHandler handler;

@property (nonatomic, strong) NSMutableArray * barItems;

@property (nonatomic, assign) NSUInteger selectBarItem;

- (void)setOtherButtonHidden:(BOOL)hidden;

@end
