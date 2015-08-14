//
//  STNetListen.h
//  STNetListenDemo
//
//  Created by zhenlintie on 15/6/10.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import <Foundation/Foundation.h>

// 网络状态改变时通知
extern NSString *const STTelephonyNetworkDidChangedNotificationName;

typedef NS_ENUM(NSUInteger, STTelStatus) {
    STTelStatusNone,
    STTelStatusGPRS,// GPRS
    STTelStatusEdge,// E
    STTelStatus2G,
    STTelStatus3G,
    STTelStatus4G
};

@interface STNetListen : NSObject

+ (instancetype)shareNetListen;

// 蜂窝网络状态
@property (nonatomic, readonly) STTelStatus status;

// 蜂窝网络状态描述
@property (nonatomic, readonly) NSString *statusDescription;

// 运营商名称
@property (nonatomic, readonly) NSString *carrierName;

@end
