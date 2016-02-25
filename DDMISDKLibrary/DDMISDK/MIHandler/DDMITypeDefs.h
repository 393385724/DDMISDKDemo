//
//  DDMITypeDefs.h
//  DDMISDK
//
//  Created by lilingang on 16/2/23.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#ifndef DDMITypeDefs_h
#define DDMITypeDefs_h

typedef NS_ENUM(NSUInteger, DDMIAuthResponseType) {
    DDMIAuthResponseTypeCode, //Authorization Code Flow
    DDMIAuthResponseTypeToken, //Implicit Flow
};

#endif /* DDMITypeDefs_h */
