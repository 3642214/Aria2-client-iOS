//
//  BaseNavigationController.m
//  Coding_iOS
//
//  Created by Ease on 15/2/5.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIColor+expanded.h"

@interface BaseNavigationController ()
@property (strong, nonatomic) UIView *navLineV;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //藏旧
    [self hideBorderInView:self.navigationBar];
    //添新
    //  if (!_navLineV) {
    //    _navLineV = [[UIView alloc]
    //        initWithFrame:CGRectMake(0, 44, ymScreen_Width, 1.0 / [UIScreen mainScreen].scale)];
    //    _navLineV.backgroundColor = [UIColor colorWithHexString:ymNavLineColor];
    //    [self.navigationBar addSubview:_navLineV];
    //  }
}

- (void)hideBorderInView:(UIView *)view {

    if ([view isKindOfClass:[UIImageView class]] && view.frame.size.height <= 1) {
        view.hidden = YES;
    }
    for (UIView *subView in view.subviews) {
        [self hideBorderInView:subView];
    }
}

- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
//}
//
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    //    if (![self.visibleViewController isKindOfClass:[UIAlertController class]]) { // iOS9
    //    UIWebRotatingAlertController
    return [self.topViewController supportedInterfaceOrientations];
    //    } else {
    //        return UIInterfaceOrientationMaskPortrait;
    //    }
}

/**
 * 允许子VC设置状态栏样式
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end
