//
//  BaseViewController.h
//  huigongyou-project
//
//  Created by ss on 2016/9/28.
//  Copyright © 2016年 zj14. All rights reserved.
//

#ifndef BaseViewController_h
#define BaseViewController_h
#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 * 跳转新页面
 */
- (void)gotoVC:(UIViewController *)VC;

- (void)gotoVCWithStoryboard:(NSString *)SBName andIdentifier:(NSString *)identifier;
/**
 * 返回
 */
- (void)goBack;
- (void)goBackNoAnimated;

/**
 * 返回至某页面
 */
- (void)returnToVC:(UIViewController *)VC;
- (void)returnToVCWithVCIndex:(NSUInteger)returnVCIndex;

/**
 * 设置标题
 */
- (void)setTitle:(NSString *)title;

@property (nonatomic) Boolean hiddenNavigationBar;

/**
 *  获取vc在navigationController.viewControllers中的index
 *
 *  @param vc <#vc description#>
 *
 *  @return <#return value description#>
 */
- (NSUInteger)getVCIndex:(UIViewController *)vc;

/**
 *  隐藏底部栏
 */
- (void)hideTabBar;

/**
 *  是否隐藏导航栏
 *
 *  @return <#return value description#>
 */
- (BOOL)isHiddenNavigationBar;
@end

#endif /* BaseViewController_h */
