//
//  DDViewController.m
//  DDMISDKDemo
//
//  Created by lilingang on 16/2/24.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#import "DDViewController.h"
#import "DDMIHandler.h"

@interface DDViewController ()

@property (nonatomic, strong) DDMIHandler *miHandler;

@property (nonatomic, copy) NSString *code;
@end

@implementation DDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.miHandler = [[DDMIHandler alloc] init];
    [self.miHandler registerAppWithRedirectURL:@"http://xiaomi.com"];
}

- (IBAction)miCodeAuthButtonAction:(id)sender {
    [self.miHandler authWithType:DDMIAuthResponseTypeCode controller:self handler:^(DDMIAuthState state, NSDictionary *response, NSError *error) {
        switch (state) {
            case DDMIAuthStateBegan: {
                
                break;
            }
            case DDMIAuthStateSuccess: {
                [[[UIAlertView alloc] initWithTitle:@"授权成功" message:[NSString stringWithFormat:@"%@",response] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                break;
            }
            case DDMIAuthStateFail: {
                [[[UIAlertView alloc] initWithTitle:@"授权失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                break;
            }
            case DDMIAuthStateCancel: {
                [[[UIAlertView alloc] initWithTitle:@"授权取消" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                break;
            }
        }
    }];
}

- (IBAction)miTokenAuthButtonAction:(id)sender {
    __weak __typeof(&*self)weakSelf = self;
    [self.miHandler authWithType:DDMIAuthResponseTypeToken controller:self handler:^(DDMIAuthState state, NSDictionary *response, NSError *error) {
        switch (state) {
            case DDMIAuthStateBegan: {
                
                break;
            }
            case DDMIAuthStateSuccess: {
                weakSelf.code = [response objectForKey:@"access_token"];
                [[[UIAlertView alloc] initWithTitle:@"授权成功" message:[NSString stringWithFormat:@"%@",response] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                break;
            }
            case DDMIAuthStateFail: {
                [[[UIAlertView alloc] initWithTitle:@"授权失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                break;
            }
            case DDMIAuthStateCancel: {
                [[[UIAlertView alloc] initWithTitle:@"授权取消" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                break;
            }
        }
    }];
}
- (IBAction)getUserInfoButtonAction:(id)sender {
    [self.miHandler getProfileInfoWithAccessToken:self.code handler:^(DDMIUserInfoItem *userInfoItem, NSError *error) {
        if (!error) {
            [[[UIAlertView alloc] initWithTitle:@"获取用户信息成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"获取用户信息失败" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }];
}
@end
