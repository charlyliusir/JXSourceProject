//
//  ViewController.m
//  JXMediaPlayer
//
//  Created by tidemedia on 2017/10/25.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "ViewController.h"
#import "TDLivePlayerViewController.h"
#import "TDPlayerViewModel.h"

@interface ViewController ()

@property (nonatomic, strong) TDPlayerViewModel *viewmodel;
@property (nonatomic, strong) TDLivePlayerViewController *playerController;

@end

@implementation ViewController

- (TDPlayerViewModel *)viewmodel
{
    if (!_viewmodel) {
        _viewmodel = [[TDPlayerViewModel alloc] init];
        _viewmodel.owner = self;
    }
    return _viewmodel;
}

- (TDLivePlayerViewController *)playerController
{
    if (!_playerController) {
        _playerController = [[TDLivePlayerViewController alloc] initWithVideoUrl:[NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"]];
        _playerController.viewmodel = self.viewmodel;
    }
    return _playerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addChildViewController:self.playerController];
    [self.view addSubview:self.playerController.view];
    [self.playerController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@200);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
