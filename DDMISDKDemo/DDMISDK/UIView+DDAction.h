//
//  UIView+DDAction.h
//  HMLoginDemo
//
//  Created by lilingang on 15/8/5.
//  Copyright (c) 2015年 lilingang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DDAction)
- (void)ddAddTarget:(id)target tapAction:(SEL)action;
@end
