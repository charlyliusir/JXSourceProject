//
//  CLTapBarItem.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "CLTapBarItem.h"

@implementation CLTapBarItem
    
- (instancetype)initWithTitle:(NSString *)title controller:(UIViewController *)controller
{
    if (self = [super init]) {
        _title = title;
        _controller = controller;
    }
    return self;
}

+ (instancetype)tapBarItemWithTitle: (NSString *)title controller: (UIViewController *)controller
{
    return [[self alloc] initWithTitle:title controller:controller];
}

@end
