//
//  JsonrpcServer.h
//  Aria2-client-iOS
//
//  Created by zj14 on 2019/2/24.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JsonrpcServer : NSObject
@property (strong, nonatomic) NSString *uri;
@property (strong, nonatomic) NSString *name;
@end

NS_ASSUME_NONNULL_END
