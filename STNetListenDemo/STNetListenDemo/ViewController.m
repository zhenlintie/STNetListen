//
//  ViewController.m
//  STNetListenDemo
//
//  Created by zhenlintie on 15/6/10.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "ViewController.h"
#import "STNetListen.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[[STNetListen shareNetListen] description]);
}


@end
