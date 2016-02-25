//
//  DDMIDefines.h
//  MDLoginSDK
//
//  Created by lilingang on 16/1/19.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#ifndef DDMIDefines_h
#define DDMIDefines_h

typedef NS_ENUM(NSUInteger, DDMIAuthResponseType) {
    DDMIAuthResponseTypeCode, //Authorization Code Flow
    DDMIAuthResponseTypeToken, //Implicit Flow
};

#ifndef MILocal
#define MILocal(s) \
[[NSBundle mainBundle] localizedStringForKey:s value:s table:@"DDMILocalizable"]
#endif

#endif /* DDMIDefines_h */
