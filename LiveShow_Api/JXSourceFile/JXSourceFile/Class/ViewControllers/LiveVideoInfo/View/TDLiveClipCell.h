//
//  TDLiveClipCell.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/30.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDLiveClipsViewModel.h"

@interface TDLiveClipCell : UICollectionViewCell

@property (nonatomic, strong) TDLiveClipsViewModel *viewModel;

@property (nonatomic, readonly, strong) UILabel *titleLabel;
@end
