//
//  DDMIHandler.h
//  HMLoginDemo
//
//  Created by lilingang on 15/8/3.
//  Copyright (c) 2015年 lilingang. All rights reserved.
//
/// 请在info.plist中配置URL types模板:
//<dict>
//  <key>CFBundleTypeRole</key>
//  <string>MI</string>
//  <key>CFBundleURLName</key>
//  <string>xiaomi</string>
//  <key>CFBundleURLSchemes</key>
//  <array>
//      <string>mi**************</string>
//  </array>
//</dict>
//将**************替换为你申请的小米key

#import <Foundation/Foundation.h>
#import "DDMITypeDefs.h"
#import "DDMIUserInfoItem.h"

@class UIViewController;

typedef NS_ENUM(NSUInteger, DDMIAuthState) {
    DDMIAuthStateBegan = 0,   /**< 开始 */
    DDMIAuthStateSuccess,     /**< 成功 */
    DDMIAuthStateFail,        /**< 失败 */
    DDMIAuthStateCancel,      /**< 取消 */
};

typedef void(^DDMIAuthEventHandler) (DDMIAuthState state, NSDictionary *response, NSError *error);

typedef void(^DDMIGetProfielEventHandler) (DDMIUserInfoItem *userInfoItem, NSError *error);


/**
 *  @brief 小米授权业务主入口
 */
@interface DDMIHandler : NSObject

/**
 *  @brief  注册小米SDK
 *
 *  @param redirectURL 线下填写的重定向URL
 */
- (void)registerAppWithRedirectURL:(NSString *)redirectURL;

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
 *  @param accessToken 授权DDMIAuthResponseTypeToken获取的accessToken
 *  @param handler     回调
 *
 *  @return YES ? 唤起成功 : 唤起失败
 */
- (BOOL)getProfileInfoWithAccessToken:(NSString *)accessToken handler:(DDMIGetProfielEventHandler)handler;

@end
