//
//  UIColor+TDHex.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TDHex)

+ (UIColor *)colorWithHexString: (NSString *)hexString;
+ (UIColor *)colorWithHexString: (NSString *)hexString alpha: (float)alpha;;
+ (UIColor *)colorWithHex: (long)hex;
+ (UIColor *)colorWithHex: (long)hex alpha: (float)alpha;

@end
