

//
//  APIUtils.m
//  regDevices
//
//  Created by zj15 on 2018/3/28.
//  Copyright © 2018年 zj15. All rights reserved.
//

#import "APIUtils.h"
#import "NetUtils.h"

@implementation APIUtils
+ (void)listActiveAndStop:(NSString *)rpcUri
                  success:(void (^)(NSArray *taskInfos, NSInteger count))success
                  failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *ad = [NSMutableDictionary new];
    [ad setObject:@"aria2.tellActive" forKey:@"methodName"];
    [ad setObject:@[ @[ @"gid", @"totalLength", @"completedLength", @"downloadSpeed", @"files", @"status" ] ]
           forKey:@"params"];
    NSMutableDictionary *sd = [NSMutableDictionary new];
    [sd setObject:@"aria2.tellWaiting" forKey:@"methodName"];
    [sd setObject:@[
        @(-1), @(1000), @[ @"gid", @"totalLength", @"completedLength", @"downloadSpeed", @"files", @"status" ]
    ]
           forKey:@"params"];

    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"system.multicall" forKey:@"method"];
    [dict setObject:@[ @[ [ad yy_modelToJSONObject], [sd yy_modelToJSONObject] ] ] forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            NSArray *a = (NSArray *) json;
            NSMutableArray *arr = [NSMutableArray new];
            for (NSArray *str in a) {
                NSArray *ar = [NSArray yy_modelArrayWithClass:[TaskInfo class] json:str[0]];
                [arr addObjectsFromArray:ar];
            }
            success(arr, [arr count]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)func:(NSString *)func
         gid:(NSString *)gid
      rpcUri:(NSString *)rpcUri
     success:(void (^)(NSString *okmsg))success
     failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:[NSString stringWithFormat:@"aria2.%@", func] forKey:@"method"];
    [dict setObject:@[ gid ] forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            success(json);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)statusByGid:(NSString *)gid
             rpcUri:(NSString *)rpcUri
            success:(void (^)(TaskInfo *taskInfo))success
            failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.tellStatus" forKey:@"method"];
    [dict setObject:@[ gid ] forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            success([TaskInfo yy_modelWithJSON:json]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)unpauseByGid:(NSString *)gid
              rpcUri:(NSString *)rpcUri
             success:(void (^)(NSString *okmsg))success
             failure:(void (^)(NSString *msg))failure {
    [APIUtils func:@"unpause" gid:gid rpcUri:rpcUri success:success failure:failure];
}

+ (void)pauseByGid:(NSString *)gid
            rpcUri:(NSString *)rpcUri
           success:(void (^)(NSString *okmsg))success
           failure:(void (^)(NSString *msg))failure {
    [APIUtils func:@"pause" gid:gid rpcUri:rpcUri success:success failure:failure];
}

+ (void)removeByGid:(NSString *)gid
             rpcUri:(NSString *)rpcUri
            success:(void (^)(NSString *okmsg))success
            failure:(void (^)(NSString *msg))failure {
    [APIUtils func:@"remove" gid:gid rpcUri:rpcUri success:success failure:failure];
}

+ (void)removeResultByGid:(NSString *)gid
                   rpcUri:(NSString *)rpcUri
                  success:(void (^)(NSString *okmsg))success
                  failure:(void (^)(NSString *msg))failure {
    [APIUtils func:@"removeDownloadResult" gid:gid rpcUri:rpcUri success:success failure:failure];
}

+ (void)addUri:(NSString *)uri
        rpcUri:rpcUri
       success:(void (^)(NSString *gid))success
       failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.addUri" forKey:@"method"];
    [dict setObject:@[ @[ uri ] ] forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            success(json);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)listActive:(NSString *)rpcUri
           success:(void (^)(NSArray *activite, NSInteger count))success
           failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.tellActive" forKey:@"method"];
    [dict setObject:@[ @[
              @"gid", @"totalLength", @"completedLength", @"uploadSpeed", @"downloadSpeed", @"connections",
              @"numSeeders", @"files", @"status"
          ] ]
             forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            NSArray *arr = [NSArray yy_modelArrayWithClass:[TaskInfo class] json:json];
            success(arr, [arr count]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)listWait:(NSString *)rpcUri
         success:(void (^)(NSArray *activite, NSInteger count))success
         failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.tellWaiting" forKey:@"method"];
    [dict setObject:@[
        @(0), @(1000),
        @[
           @"gid", @"totalLength", @"completedLength", @"uploadSpeed", @"downloadSpeed", @"connections", @"numSeeders",
           @"files", @"status"
        ]
    ]
             forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            NSArray *arr = [NSArray yy_modelArrayWithClass:[TaskInfo class] json:json];
            success(arr, [arr count]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)listStopped:(NSString *)rpcUri
            success:(void (^)(NSArray *activite, NSInteger count))success
            failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.tellStopped" forKey:@"method"];
    [dict setObject:@[
        @(-1), @(1000),
        @[
           @"gid", @"totalLength", @"completedLength", @"uploadSpeed", @"downloadSpeed", @"connections", @"numSeeders",
           @"files", @"status"
        ]
    ]
             forKey:@"params"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            NSArray *arr = [NSArray yy_modelArrayWithClass:[TaskInfo class] json:json];
            success(arr, [arr count]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)getGlobalOption:(NSString *)rpcUri
                success:(void (^)(Setting *setting))success
                failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.getGlobalOption" forKey:@"method"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            success([Setting yy_modelWithJSON:json]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)getVersion:(NSString *)rpcUri
           success:(void (^)(Version *version))success
           failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.getVersion" forKey:@"method"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            success([Version yy_modelWithJSON:json]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (void)getGlobalStatus:(NSString *)rpcUri
                success:(void (^)(GlobalStatus *globalStatus))success
                failure:(void (^)(NSString *msg))failure {
    NSMutableDictionary *dict = [self createDict];
    [dict setObject:@"aria2.getGlobalStat" forKey:@"method"];
    [NetUtils doPost:rpcUri
        withParameters:dict
        success:^(NSString *json, NSInteger _) {
            success([GlobalStatus yy_modelWithJSON:json]);
        }
        failure:^(NSString *msg) {
            YMFAILURE(failure, msg);
        }];
}

+ (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:@"2.0" forKey:@"jsonrpc"];
    [dict setObject:@"ios" forKey:@"id"];
    return dict;
}
@end
