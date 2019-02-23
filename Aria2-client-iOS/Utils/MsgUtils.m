//
//  MsgUtils.m
//  huigongyou-project
//
//  Created by zj14 on 16/9/27.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import "MsgUtils.h"
#import "MBProgressHUD.h"

@interface MsgUtils ()

@end

@implementation MsgUtils

+ (void)showMsg:(nonnull NSString *)msg {
    [self onView:[[UIApplication sharedApplication] keyWindow].rootViewController.view showMsg:msg WithPic:nil];
}

+ (void)onView:(nonnull UIView *)view showMsg:(nonnull NSString *)msg {
    [self onView:view showMsg:msg WithPic:nil];
}

+ (void)onView:(nonnull UIView *)view showMsg:(nonnull NSString *)msg WithPic:(nullable NSString *)pic {
    MBProgressHUD *HUD =
        [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication] keyWindow].rootViewController.view
                             animated:YES];
    HUD.labelText = @"";
    HUD.detailsLabelText = msg;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:ymFontSizeNormal];
    HUD.mode = MBProgressHUDModeCustomView;
    if (pic) {
        HUD.customView = [[UIImageView alloc]
            initWithImage:[[UIImage imageNamed:msg] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        HUD.square = YES;
    }
    [HUD hide:YES afterDelay:2];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [HUD addGestureRecognizer:tap];

    //    [HUD showAnimated:YES
    //        whileExecutingBlock:^{
    //            sleep(2);
    //        }
    //        completionBlock:^{
    //            [HUD removeFromSuperview];
    //        }];
}

+ (void)action:(UITapGestureRecognizer *)sender {
    MBProgressHUD *hud = (MBProgressHUD *) sender.view;
    [hud hide:YES];
}

+ (void)onView:(nonnull UIView *)view
            showMsg:(nonnull NSString *)msg
               time:(unsigned int)time
    completionBlock:(void (^_Nullable)())completion {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelText = @"";
    HUD.detailsLabelText = msg;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:ymFontSizeNormal];
    HUD.mode = MBProgressHUDModeCustomView;

    [HUD showAnimated:YES
        whileExecutingBlock:^{
            sleep(time);
        }
        completionBlock:^{
            completion();
            //            [HUD hide:YES];
            [HUD removeFromSuperview];
        }];
}

+ (void)onView:(nonnull UIView *)view showMsg:(nonnull NSString *)msg completionBlock:(void (^)())completion {
    [MsgUtils onView:view showMsg:msg time:2 completionBlock:completion];
}

+ (void)onView:(UIView *)view showIndeterminateMsg:(NSString *)msg toDo:(dispatch_block_t)block {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"";
    HUD.detailsLabelText = msg;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:ymFontSizeNormal];
    [HUD showAnimated:YES
        whileExecutingBlock:^{
            //对话框显示时需要执行的操作
            if (block) {
                block();
            }
            sleep(2);
        }
        completionBlock:^{
            [HUD hide:YES];
            //操作执行完后取消对话框
            //            [HUD removeFromSuperview];
        }];
}
@end
