//
//  DDMIUserInfoItem.m
//  midong
//
//  Created by lilingang on 16/2/1.
//  Copyright © 2016年 HM IOS Team. All rights reserved.
//

#import "DDMIUserInfoItem.h"

@implementation DDMIUserInfoItem
@synthesize userId = _userId;
@synthesize miliaoNick = _miliaoNick;
@synthesize miliaoIcon_orig = _miliaoIcon_orig;
@synthesize miliaoIcon = _miliaoIcon;
@synthesize miliaoIcon_320 = _miliaoIcon_320;
@synthesize miliaoIcon_120 = _miliaoIcon_120;
@synthesize miliaoIcon_90 = _miliaoIcon_90;
@synthesize miliaoIcon_75 = _miliaoIcon_75;

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _userId = [dict objectForKey:@"userId"];
        _miliaoNick = [dict objectForKey:@"miliaoNick"];
        _miliaoIcon = [dict objectForKey:@"miliaoIcon"];
        _miliaoIcon_orig = [dict objectForKey:@"miliaoIcon_orig"];
        _miliaoIcon_320 = [dict objectForKey:@"miliaoIcon_320"];
        _miliaoIcon_120 = [dict objectForKey:@"miliaoIcon_120"];
        _miliaoIcon_90 = [dict objectForKey:@"miliaoIcon_90"];
        _miliaoIcon_75 = [dict objectForKey:@"miliaoIcon_75"];
    }
    return self;
}


@end
