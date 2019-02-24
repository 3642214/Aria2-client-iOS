//
//  APIUtils.h
//  regDevices
//
//  Created by zj15 on 2018/3/28.
//  Copyright © 2018年 zj15. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
#import "Result.h"

@interface APIUtils : NSObject

/**
 同时获取正在下载/已暂停的任务

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)listActiveAndStop:(NSString *)rpcUri
                  success:(void (^)(NSArray *taskInfos, NSInteger count))success
                  failure:(void (^)(NSString *msg))failure;

/**
 获取单个状态

 @param gid <#gid description#>
 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)statusByGid:(NSString *)gid
             rpcUri:(NSString *)rpcUri
            success:(void (^)(TaskInfo *taskInfo))success
            failure:(void (^)(NSString *msg))failure;

/**
 恢复暂停

 @param gid <#gid description#>
 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)unpauseByGid:(NSString *)gid
              rpcUri:(NSString *)rpcUri
             success:(void (^)(NSString *okmsg))success
             failure:(void (^)(NSString *msg))failure;

/**
 暂停

 @param gid <#gid description#>
 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)pauseByGid:(NSString *)gid
            rpcUri:(NSString *)rpcUri
           success:(void (^)(NSString *okmsg))success
           failure:(void (^)(NSString *msg))failure;

/**
 删除

 @param gid <#gid description#>
 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)removeByGid:(NSString *)gid
             rpcUri:(NSString *)rpcUri
            success:(void (^)(NSString *okmsg))success
            failure:(void (^)(NSString *msg))failure;

/**
 删除完成的任务记录

 @param gid <#gid description#>
 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)removeResultByGid:(NSString *)gid
                   rpcUri:(NSString *)rpcUri
                  success:(void (^)(NSString *okmsg))success
                  failure:(void (^)(NSString *msg))failure;

/**
 新增uri下载

 @param uri <#uri description#>
 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)addUri:(NSString *)uri
        rpcUri:(NSString *)rpcUri
       success:(void (^)(NSString *gid))success
       failure:(void (^)(NSString *msg))failure;

/**
 获取正在下载列表

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)listActive:(NSString *)rpcUri
           success:(void (^)(NSArray *taskInfos, NSInteger count))success
           failure:(void (^)(NSString *msg))failure;

/**
 获取暂停下载列表

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)listWait:(NSString *)rpcUri
         success:(void (^)(NSArray *taskInfos, NSInteger count))success
         failure:(void (^)(NSString *msg))failure;

/**
 获取已结束列表

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)listStopped:(NSString *)rpcUri
            success:(void (^)(NSArray *taskInfos, NSInteger count))success
            failure:(void (^)(NSString *msg))failure;

/**
 获取全局配置

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)getGlobalOption:(NSString *)rpcUri
                success:(void (^)(Setting *setting))success
                failure:(void (^)(NSString *msg))failure;

/**
 获取版本信息

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)getVersion:(NSString *)rpcUri
           success:(void (^)(Version *version))success
           failure:(void (^)(NSString *msg))failure;

/**
 获取全局状态

 @param rpcUri <#rpcUri description#>
 @param success <#success description#>
 @param failure <#failure description#>
 */
+ (void)getGlobalStatus:(NSString *)rpcUri
                success:(void (^)(GlobalStatus *globalStatus))success
                failure:(void (^)(NSString *msg))failure;
@end
