//
//  CLTapViewControllerProtocol.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLTapViewControllerProtocol <NSObject>

@property (nonatomic, assign) BOOL isLoading;

- (void)didUpdateViewUI;
- (void)willCanLoadData:(BOOL)isLoading;

@end
