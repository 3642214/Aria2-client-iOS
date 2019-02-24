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

@interface CommonUtils : NSObject
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
