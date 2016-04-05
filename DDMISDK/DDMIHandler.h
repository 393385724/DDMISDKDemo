//
//  DDMIHandler.h
//  HMLoginDemo
//
//  Created by lilingang on 15/8/3.
//  Copyright (c) 2015年 lilingang. All rights reserved.
//
/// info.plist 配置 CFBundleURLName为xiaomi

#import <Foundation/Foundation.h>
#import "DDMIUserInfoItem.h"
#import "DDMITypeDefines.h"

@class UIViewController;

typedef NS_ENUM(NSUInteger, DDMIAuthState) {
    DDMIAuthStateBegan = 0,   /**< 开始 */
    DDMIAuthStateSuccess,     /**< 成功 */
    DDMIAuthStateFail,        /**< 失败 */
    DDMIAuthStateCancel,      /**< 取消 */
};

typedef void(^DDMIAuthEventHandler) (DDMIAuthState state, NSDictionary *response, NSError *error);

typedef void(^DDMIGetProfielEventHandler) (DDMIUserInfoItem *userInfoItem, NSError *error);


@interface DDMIHandler : NSObject

/**
 *  @brief 向小米终端程序注册第三方应用
 *
 *  @param appid 小米开发者ID
 *  @param redirectURL 微博开放平台第三方应用授权回调页地址
 *
 *  @return YES ? 成功 : 失败
 */
- (BOOL)registerApp:(NSString *)appid withRedirectURL:(NSString *)redirectURL;

/**
 *  @brief  小米账号授权
 *
 *  @param type           授权的形式
 *  @param viewController 当前ViewController
 *  @param handler        回调方法
 *
 *  @return YES ? 唤起成功 : 唤起失败
 */
- (BOOL)authWithType:(DDMIAuthResponseType)type
          controller:(UIViewController *)viewController
             handler:(DDMIAuthEventHandler)handler;

/**
 *  @brief 获取用户信息
 *
 *  @param accessToken 授权获取的accessToken
 *  @param handler     回调
 *
 *  @return YES ? 唤起成功 : 唤起失败
 */
- (BOOL)getProfileInfoWithAccessToken:(NSString *)accessToken handler:(DDMIGetProfielEventHandler)handler;

@end
