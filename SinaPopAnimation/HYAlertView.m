//
//  HYAlertView.m
//  SinaPopAnimation
//
//  Created by 华惠友 on 2018/6/7.
//  Copyright © 2018年 华惠友. All rights reserved.
//

#import "HYAlertView.h"
#import "HYSecondViewController.h"
#import "HYButton.h"
#import "UIView+SPUICommon.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kItemWidth 70
#define iItemHeight 100
#define kPadding 30 // 左右边距
#define kMarginX ((kScreenWidth-2*kPadding)-4*kItemWidth)/3.0 // item间距
#define kMarginY 40 // item上下边距

@interface HYAlertView()<UICollectionViewDelegateFlowLayout> {
    int count;
}

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *exitBtn;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation HYAlertView
- (instancetype)initWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    count = (int)imageArray.count;
    if (self) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _bgView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _bgView.frame = self.bounds;
        [self addSubview:_bgView];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.contentSize = CGSizeMake((count/8 + 1)*kScreenWidth, kScreenHeight);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.frame = CGRectMake(0, kScreenHeight-76, kScreenWidth, 10);
        pageControl.numberOfPages = count/8 + 1;
        pageControl.currentPage = 0;
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
        UIButton *exitBtn = [[UIButton alloc] init];
        exitBtn.center = CGPointMake(kScreenWidth/2.0, kScreenHeight-25);
        exitBtn.bounds = CGRectMake(0, 0, 50, 50);
        [exitBtn setBackgroundImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [exitBtn addTarget:self action:@selector(alertDismiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:exitBtn];
        self.exitBtn = exitBtn;
        
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(0, kScreenHeight-55, kScreenWidth, 1);
        lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:lineLayer];
        
        for (int i=0; i<imageArray.count; i++) {
            UIView *item = [[UIView alloc] init];
            item.tag = 100+i;
            int a = i/4; // 取商
            int b = i%4; // 取余
            int c = a%2; // 如果c=0， 表示该item在上面/ 如果c=1， 表示该item在下面
            int d = i/8; // 第几页
            CGFloat x = kPadding + (kItemWidth + kMarginX) * b + kScreenWidth * d;
            CGFloat y = kScreenHeight - 76 - 35 - iItemHeight - (iItemHeight +kMarginY)*(c==0?1:0);

            item.frame = CGRectMake(x, y + (76 + 35 + iItemHeight*2+kMarginY+10), kItemWidth, iItemHeight);
            [scrollView addSubview:item];
            
            HYButton *btn = [[HYButton alloc] initWithFrame:CGRectMake(0, 0, kItemWidth, kItemWidth+30)];
           
            [btn setTitle:titleArray[i] forState:0];
            [btn setTitleColor:[UIColor blackColor] forState:0];
            [btn setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [item addSubview:btn];
        
        }
        
    }
    return self;
}

- (void)alertShow {
    // 让视图显示出来
    self.alpha = 1;
    self.hidden = NO;
    for (int i=0; i<count; i++) {
        UIView *item = [self viewWithTag:100+i];
        item.alpha = 1;
    }
    
    // 下面的+号动画
    [UIView animateWithDuration:0.2 animations:^{
        self.exitBtn.transform = CGAffineTransformRotate(self.exitBtn.transform, M_PI_4);
    }];
    
    // 让除第一页的item上去
    for (int i=count; i>=8; i--) {
        UIView *item = [self viewWithTag:100+i];
        item.transform = CGAffineTransformTranslate(item.transform, 0, -(76 + 35 + iItemHeight*2+kMarginY));
    }
    
    // 当前页item动画
    for (int i=0; i<8; i++) {
        UIView *item = [self viewWithTag:100+i];
        [UIView animateWithDuration:(i+2)*.1 animations:^{
            item.transform = CGAffineTransformTranslate(item.transform, 0, -(76 + 35 + iItemHeight*2+kMarginY + 10));
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                item.transform = CGAffineTransformTranslate(item.transform, 0, 10);
            }];
        }];
    }
}

- (void)alertDismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.exitBtn.transform = CGAffineTransformIdentity;
    }];
    
    // 计算 当前页有多少个item
    int currentPageItemCount = 0;
    int currentPageItemEndIndex = 0; // 当前页最后一个item序号
    if (self.pageControl.numberOfPages-1 == self.pageControl.currentPage) {
        currentPageItemCount = count - 8*((int)self.pageControl.numberOfPages-1);
        currentPageItemEndIndex = count;
    } else {
        currentPageItemCount = 8;
        currentPageItemEndIndex = 8*((int)self.pageControl.currentPage+1);
    }
    int a=-1;
    // 当前页item动画下去
    for (int i=currentPageItemEndIndex; i>=currentPageItemEndIndex-8; i--) {
        a++;
        UIView *item = [self viewWithTag:100+i];
        [UIView animateWithDuration:(a+2)*.1 animations:^{
            item.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    // 所有item下去
    for (int i=0; i<count; i++) {
        UIView *item = [self viewWithTag:100+i];
        item.transform = CGAffineTransformIdentity;
    }
    // 隐藏该视图
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1*8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {

            // 移动到第一页
            self.pageControl.currentPage = 0;
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
            
            self.hidden = YES;
            
            
        }];
    });
    
}

- (void)btnClick:(UIButton *)sender {
    
    UIView *view = sender.superview;
    
    // 使其他的item渐变消失
    for (int i=0; i<count; i++) {
        if (i+100 == view.tag) {
            continue;
        }
        [UIView animateWithDuration:0.2 animations:^{
            UIView *item = [self viewWithTag:100+i];
            item.alpha = 0;
        }];
    }
    
    // 当前item放大消失
    [UIView animateWithDuration:0.2 animations:^{
        sender.transform = CGAffineTransformScale(sender.transform, 3.3, 3.3);
        view.alpha = 0;
        
    } completion:^(BOOL finished) {
        // 所有item下去
        for (int i=0; i<count; i++) {
            UIView *item = [self viewWithTag:100+i];
            item.transform = CGAffineTransformIdentity;
        }
        
        sender.transform = CGAffineTransformIdentity;
        // 跳转
        [self.viewController presentViewController:[HYSecondViewController new] animated:YES completion:^{
            
            // 移动到第一页
            self.pageControl.currentPage = 0;
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.contentOffset.y);
            
            self.alpha = 0;
//            [self removeFromSuperview];
            self.hidden = YES;
        }];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self alertDismiss];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float dealer = scrollView.contentOffset.x / kScreenWidth;
    self.pageControl.currentPage = dealer;
    
}

@end
