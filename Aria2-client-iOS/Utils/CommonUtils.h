//
//  CommonUtils.h
//  huigongyou-project
//
//  Created by ss on 2016/9/26.
//  Copyright © 2016年 zj14. All rights reserved.
//

#ifndef CommonUtils_h
#define CommonUtils_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Result.h"
#import "BaseViewController.h"

@interface CommonUtils : NSObject

+ (void)AlertViewByVC:(BaseViewController *)vc
           showInfoCB:(void (^)(UIAlertAction *action))showInfoCB
              pauseCB:(void (^)(UIAlertAction *action))pauseCB
           pauseTitle:(NSString *)pauseTitle
             removeCB:(void (^)(UIAlertAction *action))removeCB;

+ (NSString *)changeTimeFormat:(NSInteger)sec;
+ (NSString *)changeKMGB:(NSInteger)byte;

/**
 *  判断字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return YES or NO
 */
+ (BOOL)stringIsNull:(NSString *)string;

+ (BOOL)isUrlAddress:(NSString *)url;
@end
#endif /* CommonUtils_h */
