//
//  CLTapBarItem.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/19.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CLTapBarItem : NSObject
    
@property (nonatomic,   copy) NSString *title;
@property (nonatomic, strong) UIViewController *controller;

- (instancetype)initWithTitle: (NSString *)title controller: (UIViewController *)controller;
+ (instancetype)tapBarItemWithTitle: (NSString *)title controller: (UIViewController *)controller;
    
@end
