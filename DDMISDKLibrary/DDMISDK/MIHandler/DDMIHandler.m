//
//  DDMIHandler.m
//  HMLoginDemo
//
//  Created by lilingang on 15/8/3.
//  Copyright (c) 2015年 lilingang. All rights reserved.
//

#import "DDMIHandler.h"

#import "DDMILoginViewController.h"
#import "DDMIAuthViewController.h"
#import "DDMIVerifyLoginViewController.h"

#import "DDMIRequestHandle.h"

@interface DDMIHandler ()<DDMICancelDelegate,DDMILoginViewControllerDelegate,DDMIAuthViewControllerDelegate,DDMIVerifyLoginViewControllerDelegate>

@property (nonatomic, copy) NSString *appKey;

@property (nonatomic, copy) NSString *redirectUrl;

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) DDMIRequestHandle *requestHandle;

@property (nonatomic, copy) DDMIAuthEventHandler authEventHandle;

@property (nonatomic, assign) DDMIAuthResponseType  responseType;

@end

@implementation DDMIHandler

- (void)registerAppWithRedirectURL:(NSString *)redirectURL{
    self.redirectUrl = redirectURL;
}

- (BOOL)authWithType:(DDMIAuthResponseType)type
          controller:(UIViewController *)viewController
             handler:(DDMIAuthEventHandler)handler{
    if (!handler) {
        return NO;
    }
    self.responseType = type;
    self.authEventHandle = handler;
    self.authEventHandle(DDMIAuthStateBegan,nil,nil);
    [self presetLoginViewControllerInViewController:viewController];
    return YES;
}

- (BOOL)getProfileInfoWithAccessToken:(NSString *)accessToken handler:(DDMIGetProfielEventHandler)handler{
    if (!handler) {
        return NO;
    }
    return [self.requestHandle getProfileWithAccessToken:accessToken clientId:self.appKey completeHandler:^(NSDictionary *responseDict, NSError *connectionError) {
        if (connectionError) {
            handler(nil, connectionError);
        } else {
            DDMIUserInfoItem *item = [[DDMIUserInfoItem alloc] initWithDict:responseDict];
            handler(item, nil);
        }
    }];
}

#pragma mark - Private Methods

- (void)presetLoginViewControllerInViewController:(UIViewController *)viewController{
    DDMILoginViewController *loginViewController = [[DDMILoginViewController alloc] initWithRequestHandle:self.requestHandle];
    loginViewController.delegate = self;
    loginViewController.cancelDelegate = self;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [viewController presentViewController:self.navigationController animated:YES completion:nil];
}

- (void)pushWebAuthViewContoller{
    NSAssert(self.redirectUrl, @"必须优先实现 registerAppWithRedirectURL: 方法");
    DDMIAuthViewController *viewController = [[DDMIAuthViewController alloc] initWithAppid:self.appKey redirectUrl:self.redirectUrl];
    viewController.cancelDelegate = self;
    viewController.delegate = self;
    viewController.responseType = self.responseType;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)pushVerifyLoginViewControllerWithAccount:(NSString *)account{
    DDMIVerifyLoginViewController *viewController = [[DDMIVerifyLoginViewController alloc] initWithRequestHandle:self.requestHandle];
    viewController.delegate = self;
    viewController.cancelDelegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)disMissWithCompletion:(void (^)(void))completion{
    __weak __typeof(&*self)weakSelf = self;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        weakSelf.navigationController = nil;
        if (completion) {
            completion();
        }
    }];
}

#pragma mark - DDMICancelDelegate

- (void)viewControllerCanceled:(UIViewController *)viewController{
    __weak __typeof(&*self)weakSelf = self;
    [self disMissWithCompletion:^{
        weakSelf.authEventHandle(DDMIAuthStateCancel,nil,nil);
        weakSelf.authEventHandle = nil;
    }];
}

#pragma mark - DDMILoginViewControllerDelegate

- (void)loginViewController:(DDMILoginViewController *)viewController successNeedDaynamicCode:(BOOL)needDaynamicCode{
    if (!needDaynamicCode) {
        [self pushWebAuthViewContoller];
    }
    else {
        [self pushVerifyLoginViewControllerWithAccount:self.requestHandle.account];
    }
}

#pragma mark - DDMIVerifyLoginViewControllerDelegate

- (void)viewControllerDidVerifySucess:(DDMIVerifyLoginViewController *)viewController{
    [self pushWebAuthViewContoller];
}

- (void)viewControllerNeedPop:(DDMIVerifyLoginViewController *)viewController{
    [self.navigationController popViewControllerAnimated:YES];
    self.requestHandle.delegate = ((DDMILoginViewController *)self.navigationController.topViewController);
}

#pragma mark - DDMIAuthViewControllerDelegate

- (void)authViewController:(DDMIAuthViewController *)viewController failedWithError:(NSError *)error{
    __weak __typeof(&*self)weakSelf = self;
    [self disMissWithCompletion:^{
        weakSelf.authEventHandle(DDMIAuthStateFail,nil,error);
        weakSelf.authEventHandle = nil;
    }];
}

- (void)authViewController:(DDMIAuthViewController *)viewController successWithResponse:(NSDictionary *)response{
    __weak __typeof(&*self)weakSelf = self;
    [self disMissWithCompletion:^{
        weakSelf.authEventHandle(DDMIAuthStateSuccess,response,nil);
        weakSelf.authEventHandle = nil;
    }];
}

- (void)authViewControllerSwitchLogin{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark - Getter and Setter

- (DDMIRequestHandle *)requestHandle{
    if (!_requestHandle) {
        _requestHandle = [[DDMIRequestHandle alloc] init];
    }
    return _requestHandle;
}

- (NSString *)appKey{
    if (!_appKey) {
        NSArray *urlTypesArray = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
        NSArray *urlSchemes;
        for (NSDictionary *dict in urlTypesArray) {
            if ([[dict objectForKey:@"CFBundleURLName"] isEqualToString:@"xiaomi"]) {
                urlSchemes = [dict objectForKey:@"CFBundleURLSchemes"];
                break;
            }
        }
        for (NSString *string in urlSchemes) {
            if ([string hasPrefix:@"mi"]) {
                _appKey = string;
            }
        }
        if (!_appKey) {
            NSLog(@"请在info.plist中配置URL types模板:\n<dict>\n<key>CFBundleTypeRole</key>\n<string>MI</string>\n<key>CFBundleURLName</key>\n<string>xiaomi</string>\n<key>CFBundleURLSchemes</key>\n<array>\n<string>mi**************</string>\n</array>\n</dict>\n将**************替换为你申请的小米key");
        }
        _appKey = [_appKey stringByReplacingOccurrencesOfString:@"mi" withString:@""];
    }
    return _appKey;
}
@end
