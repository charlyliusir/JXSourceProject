//
//  ViewController.m
//  JXTestDemo
//
//  Created by tidemedia on 2017/10/13.
//  Copyright © 2017年 tidemedia. All rights reserved.
//

#import "ViewController.h"
#import <JXApi/JXApi.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[JXApiHeader manager] loadLiveActivity:3412 sourceType:0 withBaseViewController:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
