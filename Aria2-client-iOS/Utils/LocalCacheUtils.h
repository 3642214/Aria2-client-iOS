//
//  LocalCacheUtils.h
//  huigongyou-project
//
//  Created by zj14 on 2016/11/1.
//  Copyright © 2016年 zj14. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSONRPCKey @"jsonrpcKey"

@interface LocalCacheUtils : NSObject
+ (id)getInstance;

- (void)setServerIPUri:(NSString *)uri;
- (NSString *)getServerIPUri;

- (void)setArray:(NSArray *)array forKey:(NSString *)key;
- (NSArray *)getArrayByKey:(NSString *)key;

- (void)setDict:(NSDictionary *)dict forKey:(NSString *)key;
- (NSDictionary *)getDictByKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

- (id)getObjectByKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

- (void)setJsonrpcArray:(NSArray *)array;
- (NSArray *)getJsonrpcArray;
@end
