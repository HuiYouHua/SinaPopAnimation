//
//  HYViewController.m
//  SinaPopAnimation
//
//  Created by 华惠友 on 2018/6/7.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYViewController.h"
#import "HYAlertView.h"

@interface HYViewController ()
@property (nonatomic, strong) HYAlertView *alert;

@end

@implementation HYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博";
    
    NSArray *imageArray = @[@"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png", @"remind.png"];
    NSArray *titleArray = @[@"文字", @"拍摄", @"相册", @"直播", @"红包", @"头条文章", @"签到", @"点评", @"话题", @"光影秀", @"好友圈", @"音乐", @"商品", @"秒拍", @"红豆Live", @"商品", @"秒拍", @"红豆Live", @"直播", @"红包", @"头条文章", @"签到", @"点评", @"话题", @"光影秀", @"好友圈", @"音乐", @"商品", @"秒拍", @"红豆Live", @"商品", @"秒拍", @"红豆Live"];
    _alert = [[HYAlertView alloc] initWithImageArray:imageArray titleArray:titleArray];
}
- (IBAction)btnClick:(id)sender {
   
    [self.view addSubview:_alert];
    [_alert alertShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
