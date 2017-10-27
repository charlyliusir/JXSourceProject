//
//  TDActivityInfoModel.m
//  JXSourceFile
//
//  Created by 刘朝龙 on 2017/10/21.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDActivityInfoModel.h"

@implementation TDActivityInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _sourceid = value;
    }
    else if ([key isEqualToString:@"narr"]) {
        if (value && [value isKindOfClass:[NSDictionary class]]) {
            TDActivityNarrModel *narrModel = [[TDActivityNarrModel alloc] init];
            [narrModel setValuesForKeysWithDictionary:value];
            _narrModel = narrModel;
        }
    }
    else if ([key isEqualToString:@"list"]) {
        if (value && [value isKindOfClass:[NSDictionary class]]) {
            TDActivityInterModel *interModel = [[TDActivityInterModel alloc] init];
            [interModel setValuesForKeysWithDictionary:value];
            _interModel = interModel;
        }
    }
}

@end
