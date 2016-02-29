//
//  DDMainViewController.m
//  DDMISDKDemo
//
//  Created by lilingang on 16/2/29.
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
    [self.miHandler registerAppWithRedirectURL:@""];
}

- (IBAction)codeAuthButtonAction:(id)sender {
    [self.miHandler authWithType:DDMIAuthResponseTypeCode controller:self handler:^(DDMIAuthState state, NSDictionary *response, NSError *error) {
        
    }];
}
- (IBAction)tokenAuthAction:(id)sender {
    [self.miHandler authWithType:DDMIAuthResponseTypeToken controller:self handler:^(DDMIAuthState state, NSDictionary *response, NSError *error) {
        
    }];
}

- (IBAction)userInfoAction:(id)sender {
    
}

@end
