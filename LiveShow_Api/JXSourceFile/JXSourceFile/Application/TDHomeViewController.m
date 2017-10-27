//
//  TDHomeViewController.m
//  JXSourceFile
//
//  Created by tidemedia on 2017/10/23.
//  Copyright © 2017年 liucharly. All rights reserved.
//

#import "TDHomeViewController.h"
#import "JXApiHeader.h"

@interface TDHomeViewController ()

@end

@implementation TDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goAction:(id)sender {
     [[JXApiHeader manager] loadLiveActivity:3412 sourceType:0 withBaseViewController:self];
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
