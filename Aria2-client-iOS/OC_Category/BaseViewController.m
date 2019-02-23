//
//  BaseViewController.m
//  huigongyou-project
//
//  Created by ss on 2016/9/28.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

#pragma mark - BaseViewController
@interface BaseViewController (Dismiss)

/**
 * 判断是否: TabBarVC -> NavController -> rootVC(self)
 */
- (BOOL)TabBarNavRootView;

/**
 * 判断是否: TabBarVC -> NavController -> rootVC -> self
 */
- (BOOL)TabBarNavSecdView;
/**
 * 设置角标数
 */
- (void)setBadgeValue:(NSString *)val;

@property Class rootTabClazz;

@end

@implementation BaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 定义状态栏样式,背景为有色,内容为白色
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景色为白色
    self.view.backgroundColor = ymBackgroudColor;

    // 通知nav,设置状态栏样式
    [self setNeedsStatusBarAppearanceUpdate];
    //  设置背景颜色
    self.navigationController.navigationBar.barTintColor = ymNavBackgroundColor;
    // 导航栏上按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //  navbar上加入返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [self backButton];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }

    self.navigationController.navigationBar.translucent = NO;
    // 修复navigationController侧滑关闭失效的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    // 设置字体的颜色和大小,比如title
    NSDictionary *textAttrbutes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:ymFontSizeBigger]
    };
    [self.navigationController.navigationBar setTitleTextAttributes:textAttrbutes];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    LLog(@"viewWillAppear self: %@",self);
}


#pragma mark BackBtn M
/**
 * 通用返回按钮
 */
- (UIBarButtonItem *)backButton {
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< 返回"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(goBack)];
    // 字体大小
    [backBarButtonItem
        setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:ymFontSizeNormal],
                                                                          NSFontAttributeName, nil]
                      forState:(UIControlStateNormal)];

    return backBarButtonItem;
}

/**
 * 返回
 */
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)goBackNoAnimated {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setTitle:(NSString *)title {
    self.navigationItem.title = title;
}

- (void)returnToVC:(UIViewController *)VC {
    [self.navigationController popToViewController:VC animated:true];
}

- (void)returnToVCWithVCIndex:(NSUInteger)returnVCIndex {
    [self.navigationController
        popToViewController:[self.navigationController.viewControllers objectAtIndex:returnVCIndex]
                   animated:true];
}

/**
 * 插入新的VC
 */
- (void)gotoVC:(UIViewController *)VC {
    if ([self.navigationController.topViewController isKindOfClass:[VC class]]) {
        return;
    }
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSUInteger)getVCIndex:(UIViewController *)vc {
    return [self.navigationController.viewControllers indexOfObject:vc];
}
@end
