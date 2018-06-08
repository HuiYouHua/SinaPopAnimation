//
//  UIView+SPUICommon.m
//  SuperPet
//
//  Created by JackZ on 16/3/15.
//  Copyright © 2016年 Supet. All rights reserved.
//

#import "UIView+SPUICommon.h"

@implementation UIView (SPUICommon)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (UINavigationController *)navigationController{
    UIViewController *viewController = [self viewController];
    if (viewController) {
        if (viewController.navigationController) {
            return viewController.navigationController;
        }
    }
    return nil;
}

@end
