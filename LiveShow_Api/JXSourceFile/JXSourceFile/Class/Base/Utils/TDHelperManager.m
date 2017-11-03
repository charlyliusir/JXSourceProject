//
//  TDHelperManager.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDHelperManager.h"

@implementation TDHelperManager

+ (instancetype)helperManager
{
    static TDHelperManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TDHelperManager alloc] init];
    });
    return manager;
}

@end
