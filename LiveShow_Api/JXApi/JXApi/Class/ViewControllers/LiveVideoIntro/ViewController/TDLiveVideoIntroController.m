//
//  TDLiveVideoIntroController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoIntroController.h"

@interface TDLiveVideoIntroController ()
@property (nonatomic, readwrite, assign) NSUInteger sourceId;
@property (nonatomic, readwrite, assign) NSUInteger type;
@end

@implementation TDLiveVideoIntroController

+ (instancetype)liveVideoIntroControllerWithSourceId:(NSUInteger)sourceId type:(NSUInteger)type
{
    TDLiveVideoIntroController *controller = [[TDLiveVideoIntroController alloc] init];
    controller.sourceId = sourceId;
    controller.type     = type;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tapViewController delegate
- (void)didUpdateViewUI
{
}

- (void)willCanLoadData:(BOOL)isLoading
{
    if (!isLoading) {
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@synthesize isLoading;

@end
