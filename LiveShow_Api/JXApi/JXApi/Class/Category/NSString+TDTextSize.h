//
//  NSString+TDTextSize.h
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TDTextSize)
+ (CGFloat)stringGetHegith:(NSString *)string WithWidth:(CGFloat)width attributes:(NSDictionary *)attribute;

@end
