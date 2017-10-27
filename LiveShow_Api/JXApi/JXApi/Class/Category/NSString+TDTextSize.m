//
//  NSString+TDTextSize.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "NSString+TDTextSize.h"

@implementation NSString (TDTextSize)
+ (CGFloat)stringGetHegith:(NSString *)string WithWidth:(CGFloat)width attributes:(NSDictionary *)attribute
{
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size.height;
}
@end
