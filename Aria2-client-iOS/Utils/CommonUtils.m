//
//  CommonUtils.m
//  huigongyou-project
//
//  Created by zj14 on 16/9/26.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import "CommonUtils.h"
#import "MsgUtils.h"
#import <Foundation/Foundation.h>
@implementation CommonUtils : NSObject

+ (NSString *)changeTimeFormat:(NSInteger)sec {
    if (sec < 0) {
        return @"未知";
    }

    NSInteger hours, minutes, seconds;
    NSString *hoursText, *minutesText, *secondsText;
    hours = sec / 3600;
    hoursText = hours > 9 ? [@(hours) stringValue] : [NSString stringWithFormat:@"0%ld", hours];

    minutes = sec % 3600 / 60;
    minutesText = minutes > 9 ? [@(minutes) stringValue] : [NSString stringWithFormat:@"0%ld", minutes];

    seconds = sec % 3600 % 60;
    secondsText = seconds > 9 ? [@(seconds) stringValue] : [NSString stringWithFormat:@"0%ld", seconds];
    return [NSString stringWithFormat:@"%@:%@:%@", hoursText, minutesText, secondsText];
}

+ (NSString *)changeKMGB:(NSInteger)byte {
    if (byte / 1024 / 1024 / 1024 > 0) {
        return [NSString stringWithFormat:@"%.2f GB", (float) byte / 1024 / 1024 / 1024];
    } else if (byte / 1024 / 1024 > 0) {
        return [NSString stringWithFormat:@"%.2f MB", (float) byte / 1024 / 1024];
    } else if (byte / 1024 > 0) {
        return [NSString stringWithFormat:@"%.2f KB", (float) byte / 1024];
    } else {
        return [NSString stringWithFormat:@"%.2f B", (float) byte];
    }
}

+ (BOOL)stringIsNull:(NSString *)string {
    BOOL result = NO;
    if (string == nil || [string isKindOfClass:[NSNull class]] ||
        [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        result = YES;
    }
    return result;
}

@end
