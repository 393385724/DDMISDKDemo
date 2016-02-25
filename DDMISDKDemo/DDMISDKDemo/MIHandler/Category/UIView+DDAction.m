//
//  UIView+DDAction.m
//  HMLoginDemo
//
//  Created by lilingang on 15/8/5.
//  Copyright (c) 2015年 lilingang. All rights reserved.
//

#import "UIView+DDAction.h"

@implementation UIView (DDAction)
- (void)ddAddTarget:(id)target tapAction:(SEL)action{
    self.userInteractionEnabled = YES;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}
@end
