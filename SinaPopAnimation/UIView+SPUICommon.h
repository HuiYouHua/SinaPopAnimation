//
//  UIView+SPUICommon.h
//  SuperPet
//
//  Created by JackZ on 16/3/15.
//  Copyright © 2016年 Supet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SPUICommon)

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;

- (UINavigationController *)navigationController;

@end
