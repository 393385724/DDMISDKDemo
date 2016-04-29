//
//  DDMainViewController.m
//  DDMISDKDemo
//
//  Created by lilingang on 16/4/27.
//  Copyright © 2016年 LiLingang. All rights reserved.
//

#import "DDMainViewController.h"
#import "DDMIHandler.h"

@interface DDMainViewController ()

@property (nonatomic, strong) DDMIHandler *miHandler;

@end

@implementation DDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.miHandler = [[DDMIHandler alloc] init];
    [self.miHandler registerWithAppKey:@"2882303761517373163" appSecret:nil redirectURL:@"http://xiaomi.com" appDescription:nil];
}

- (IBAction)miLoginButtonAction:(id)sender {
    [self.miHandler authWithMode:DDSSAuthModeCode controller:self handler:^(DDSSPlatform platform, DDSSAuthState state, DDAuthItem *authItem, NSError *error) {
        switch (state) {
            case DDSSAuthStateBegan: {
                NSLog(@"开始授权");
                break;
            }
            case DDSSAuthStateSuccess: {
                NSLog(@"授权成功:%@",authItem);
                break;
            }
            case DDSSAuthStateFail: {
                NSLog(@"授权失败:%@",error);
                break;
            }
            case DDSSAuthStateCancel: {
                NSLog(@"取消授权");
                break;
            }
        }
    }];
}

@end
