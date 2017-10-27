//
//  TDBaseNavigationController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDBaseNavigationController.h"

@interface TDBaseNavigationController ()

@end

@implementation TDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
