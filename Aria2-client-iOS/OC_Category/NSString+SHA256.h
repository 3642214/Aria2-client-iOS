//
//  NSString+SHA256.h
//  regDevices
//
//  Created by zj15 on 2018/3/28.
//  Copyright © 2018年 zj15. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA256)
- (NSString *)SHA256;
+ (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key;
@end
