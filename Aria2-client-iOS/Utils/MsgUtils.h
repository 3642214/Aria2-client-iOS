//
//  MsgUtils.h
//  huigongyou-project
//
//  Created by zj14 on 16/9/27.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgUtils : NSObject

+ (void)showMsg:(nonnull NSString *)msg;

///**
// *  屏幕中间显示信息框,延时2s
// *
// *  @param view self.view
// *  @param msg  显示的消息
// */
//+ (void)onView:(nonnull UIView *)view showMsg:(nonnull NSString *)msg;

/**
 *  屏幕中间显示信息框,延时time,然后执行completion
 *
 *  @param view       <#view description#>
 *  @param msg        <#msg description#>
 *  @param completion <#completion description#>
 */
+ (void)onView:(nonnull UIView *)view
            showMsg:(nonnull NSString *)msg
               time:(unsigned int)time
    completionBlock:(void (^_Nullable)())completion;

/**
 *  屏幕中间显示信息框,延时2s,然后执行completion
 *
 *  @param view       <#view description#>
 *  @param msg        <#msg description#>
 *  @param completion <#completion description#>
 */
+ (void)onView:(nonnull UIView *)view showMsg:(nonnull NSString *)msg completionBlock:(void (^_Nullable)())completion;
/**
 *  屏幕中间显示信息框,附带图片,延时2s
 *
 *  @param view self.view
 *  @param msg  显示的消息
 *  @param pic  消息前面图片地址
 */
+ (void)onView:(nonnull UIView *)view showMsg:(nonnull NSString *)msg WithPic:(nullable NSString *)pic;

/**
 *  屏幕中间显示菊花载入图
 *
 *  @param view  self.view
 *  @param msg   载入图下面消息
 *  @param block 运行的代码段
 */
+ (void)onView:(nonnull UIView *)view showIndeterminateMsg:(nonnull NSString *)msg toDo:(nonnull dispatch_block_t)block;

@end
