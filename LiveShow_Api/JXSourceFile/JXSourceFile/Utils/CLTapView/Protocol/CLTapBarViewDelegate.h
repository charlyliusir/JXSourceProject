//
//  CLTapBarViewDelegate.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLTapBarViewDelegate <NSObject>

- (void)didClickBarItem:(id)barItem withIndex:(int)index;

@end
