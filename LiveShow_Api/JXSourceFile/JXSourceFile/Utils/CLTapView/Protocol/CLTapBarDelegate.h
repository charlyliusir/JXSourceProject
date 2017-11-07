//
//  CLTapBarDelegate.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/11/7.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLTapBarDelegate <NSObject>

- (void)tapBarController:(id)tapBar didShowChildController:(id)childController;

@end
