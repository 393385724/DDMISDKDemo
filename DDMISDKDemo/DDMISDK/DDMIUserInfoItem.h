//
//  DDMIUserInfoItem.h
//  midong
//
//  Created by lilingang on 16/2/1.
//  Copyright © 2016年 HM IOS Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDMIUserInfoItem : NSObject

@property (nonatomic, copy, readonly) NSString *userId;
@property (nonatomic, copy, readonly) NSString *miliaoNick;
@property (nonatomic, copy, readonly) NSString *miliaoIcon_orig;
@property (nonatomic, copy, readonly) NSString *miliaoIcon;
@property (nonatomic, copy, readonly) NSString *miliaoIcon_320;
@property (nonatomic, copy, readonly) NSString *miliaoIcon_120;
@property (nonatomic, copy, readonly) NSString *miliaoIcon_75;
@property (nonatomic, copy, readonly) NSString *miliaoIcon_90;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
