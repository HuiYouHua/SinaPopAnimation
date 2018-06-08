//
//  HYAlertView.h
//  SinaPopAnimation
//
//  Created by 华惠友 on 2018/6/7.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYAlertView : UIView

- (instancetype)initWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray;

- (void)alertShow;

@end
