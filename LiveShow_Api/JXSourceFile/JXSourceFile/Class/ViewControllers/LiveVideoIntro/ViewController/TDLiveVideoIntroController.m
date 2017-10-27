//
//  TDLiveVideoIntroController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/20.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDLiveVideoIntroController.h"
#import "TDLiveIntroView.h"

@interface TDLiveVideoIntroController ()
@property (nonatomic, strong) TDLiveIntroView *introView;
@end

@implementation TDLiveVideoIntroController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.introView];
    [self setupUI];
}

- (void)setupUI
{
    [_introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tapViewController delegate
- (void)didUpdateViewUI
{
    NSLog(@"");
}

- (void)willCanLoadData:(BOOL)isLoading
{
    if (!isLoading) {
    }
}

- (void)setViewmodel:(TDActivityInfoViewModel *)viewmodel
{
    _viewmodel = viewmodel;
    _introView.viewmodel = viewmodel;
}

- (TDLiveIntroView *)introView
{
    if (!_introView) {
        _introView = [[TDLiveIntroView alloc] initWithFrame:CGRectZero];
    }
    return _introView;
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
