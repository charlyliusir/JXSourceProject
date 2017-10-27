//
//  TDLiveVideoIntroController.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseViewController.h"
#import "CLTapViewControllerProtocol.h"
#import "TDActivityInfoViewModel.h"

@interface TDLiveVideoIntroController : TDBaseViewController<CLTapViewControllerProtocol>

@property (nonatomic, strong)TDActivityInfoViewModel *viewmodel;

@end
