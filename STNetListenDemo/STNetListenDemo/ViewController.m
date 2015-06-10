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
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    STNetListen *nl = [STNetListen shareNetListen];
    _statusLabel.text = [NSString stringWithFormat:@"%@\n%@",[nl carrierName],[nl statusDescripetion]];
}


@end
