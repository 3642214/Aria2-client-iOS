//
//  NetUtils.m
//  test
//  网络库
//  Created by zj14 on 16/9/20.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import "NetUtils.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "CommonUtils.h"

#define TIMEOUT 3.0f

@implementation NetUtils

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+ (void)doPost:(NSString *)url
    withParameters:(NSDictionary *)dict
           success:(responseOK)success
           failure:(responseFAIL)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = TIMEOUT;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSMutableDictionary *newDict = [self addParameters:dict];
    [NetUtils printUrl:url args:newDict method:@"POST"];
    [manager POST:url
        parameters:[newDict yy_modelToJSONObject]
        success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *serializedData =
                [NSJSONSerialization JSONObjectWithData:errorData options:kNilOptions error:nil];
            LLog(@"http post used %0.2f s",
                 [[NSDate date] timeIntervalSince1970] - [[newDict valueForKey:@"TT"] intValue]);
            //            LLog(@"post return data:%@", serializedData);

            if ([serializedData objectForKey:@"result"]) {
                success(serializedData[@"result"], 0);
            } else {
                failure(serializedData[@"error"]);
            }
        }];
}

#pragma GCC diagnostic pop

+ (NSMutableDictionary *)addParameters:(NSDictionary *)dict {
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
    [newDict setObject:[NSString stringWithFormat:@"%0.0f", [[NSDate date] timeIntervalSince1970]] forKey:@"TT"];
    return newDict;
}

+ (void)printUrl:(NSString *)url args:(NSMutableDictionary *)dict method:(NSString *)method {
    if ([@"GET" isEqualToString:method]) {
        LLog(@"curl -X %@ %@?%@", method, url, [dict yy_modelToJSONString]);
    } else {
        LLog(@"curl -X %@ --data \'%@\' %@", method, [dict yy_modelToJSONString], url);
    }
}
@end
