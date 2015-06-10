//
//  STNetListen.m
//  STNetListenDemo
//
//  Created by zhenlintie on 15/6/10.
//  Copyright (c) 2015年 sTeven. All rights reserved.
//

#import "STNetListen.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

NSString *const STTelephonyNetworkDidChangedNotificationName = @"com.steven.telNetDidChangedNotif";

static id _st_observer = nil;

@implementation STNetListen{
    CTTelephonyNetworkInfo *_networkInfo;
    STTelStatus _status;
}

- (void)dealloc{
    [_st_observer removeObserver:self];
}

+ (instancetype)shareNetListen{
    static dispatch_once_t onceToken;
    static STNetListen *_st_shared_netlisten = nil;
    dispatch_once(&onceToken, ^{
        _st_shared_netlisten = [self new];
    });
    return _st_shared_netlisten;
}

- (instancetype)init{
    if (self = [super init]){
        _networkInfo = [CTTelephonyNetworkInfo new];
        [self updateStatus];
        [self registerNotification];
    }
    return self;
}

- (void)registerNotification{
    NSNotificationCenter *nitifC = [NSNotificationCenter defaultCenter];
    _st_observer = [nitifC addObserverForName:CTRadioAccessTechnologyDidChangeNotification
                                       object:nil
                                        queue:[NSOperationQueue mainQueue]
                                   usingBlock:^(NSNotification *note) {
                                       [self updateStatus];
                                       [[NSNotificationCenter defaultCenter] postNotificationName:STTelephonyNetworkDidChangedNotificationName object:self];
                                   }];
}

- (void)updateStatus{
    NSString *info = _networkInfo.currentRadioAccessTechnology;
    if ([info isEqualToString:CTRadioAccessTechnologyGPRS]){
        _status = STTelStatusGPRS;
    }
    else if ([info isEqualToString:CTRadioAccessTechnologyEdge]){
        _status = STTelStatusEdge;
    }
    else if ([info isEqualToString:CTRadioAccessTechnologyCDMA1x]){
        _status = STTelStatus2G;
    }
    else if ([info isEqualToString:CTRadioAccessTechnologyWCDMA] ||
             [info isEqualToString:CTRadioAccessTechnologyHSDPA] ||
             [info isEqualToString:CTRadioAccessTechnologyHSUPA] ||
             [info isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0] ||
             [info isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] ||
             [info isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB] ||
             [info isEqualToString:CTRadioAccessTechnologyeHRPD]){
        _status = STTelStatus3G;
    }
    else if ([info isEqualToString:CTRadioAccessTechnologyLTE]){
        _status = STTelStatus4G;
    }
    else{
        _status = STTelStatusNone;
    }
}

- (STTelStatus)status{
    return _status;
}

- (NSString *)statusDescripetion{
    switch (_status) {
        case STTelStatusGPRS:
        {
            return @"GPRS";
            break;
        }
        case STTelStatusEdge:
        {
            return @"E";
            break;
        }
        case STTelStatus2G:
        {
            return @"2G";
            break;
        }
        case STTelStatus3G:
        {
            return @"3G";
            break;
        }
        case STTelStatus4G:
        {
            return @"4G";
            break;
        }
        default:
            break;
    }
    return nil;
}

- (NSString *)carrierName{
    return _networkInfo.subscriberCellularProvider.carrierName;
}

- (NSString *)description{
    CTCarrier *c = _networkInfo.subscriberCellularProvider;
    return [NSString stringWithFormat:@"(%@)(%@-%@-%@-%@)",[self statusDescripetion],c.carrierName,c.mobileCountryCode,c.mobileNetworkCode,c.isoCountryCode];
}

@end
