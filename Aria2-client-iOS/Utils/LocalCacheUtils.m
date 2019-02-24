//
//  LocalCacheUtils.m
//  huigongyou-project
//
//  Created by zj14 on 2016/11/1.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import "LocalCacheUtils.h"
#import "JsonrpcServer.h"

@interface LocalCacheUtils ()

@property (nonatomic, retain) NSUserDefaults *userDefaults;
@end

@implementation LocalCacheUtils

+ (id)getInstance {
    static LocalCacheUtils *single = nil;
    static dispatch_once_t onceLock;
    dispatch_once(&onceLock, ^{
        single = [[self alloc] init];
        single.userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return single;
}

- (void)setArray:(NSArray *)array forKey:(NSString *)key {
    [_userDefaults setObject:array forKey:key];
    [_userDefaults synchronize];
}

- (NSArray *)getArrayByKey:(NSString *)key {
    return (NSArray *) [_userDefaults objectForKey:key];
}

- (void)setDict:(NSDictionary *)dict forKey:(NSString *)key {
    [_userDefaults setObject:dict forKey:key];
    [_userDefaults synchronize];
}

- (NSDictionary *)getDictByKey:(NSString *)key {
    return (NSDictionary *) [_userDefaults objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [_userDefaults removeObjectForKey:key];
    [_userDefaults synchronize];
}

- (id)getObjectByKey:(NSString *)key {
    return [_userDefaults objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [_userDefaults setObject:object forKey:key];
    [_userDefaults synchronize];
}

- (void)setJsonrpcArray:(NSArray *)array {
    [_userDefaults setObject:[array yy_modelToJSONString] forKey:JSONRPCKey];
    [_userDefaults synchronize];
}

- (NSArray *)getJsonrpcArray {
    return  [NSArray yy_modelArrayWithClass:[JsonrpcServer class] json:[_userDefaults objectForKey:JSONRPCKey]];
}
@end
