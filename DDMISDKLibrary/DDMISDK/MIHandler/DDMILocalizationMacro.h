//
//  DDMILocalizationMacro.h
//  MDLoginSDK
//
//  Created by lilingang on 16/1/19.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#ifndef DDMILocalizationMacro_h
#define DDMILocalizationMacro_h

#ifndef MILocal
#define MILocal(s) \
[[NSBundle mainBundle] localizedStringForKey:s value:s table:@"DDMILocalizable"]
#endif

#ifndef DDMISDKBundle
#define DDMISDKBundle \
[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"DDMISDK" ofType:@"bundle"]]
#endif

#ifndef DDMISDKBundleImage
#define DDMISDKBundleImage(s) \
[UIImage imageNamed:[[[NSBundle mainBundle] pathForResource:@"DDMISDK" ofType:@"bundle"] stringByAppendingPathComponent:s]]
#endif

#endif /* DDMILocalizationMacro_h */
