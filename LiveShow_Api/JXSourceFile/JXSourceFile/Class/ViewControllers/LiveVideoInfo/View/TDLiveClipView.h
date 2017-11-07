//
//  TDLiveClipView.h
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/27.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDLiveClipsViewModel.h"

@interface TDLiveClipView : UIView

@property (nonatomic, readonly, strong)NSArray *sources;
@property (nonatomic, weak) id <UICollectionViewDelegate> delegate;

- (instancetype)initWithDelegate:(id <UICollectionViewDelegateFlowLayout>) delegate;

- (void)setSourcess:(NSArray *)sources;
- (void)reloadCollectionCellWithIndexPaths:(NSArray *)indexPaths;

@end
