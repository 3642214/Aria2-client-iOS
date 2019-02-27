//
//  ActiveListViewController.h
//  Aria2
//
//  Created by zj14 on 2019/2/23.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "BaseViewController.h"
#import "JsonrpcServer.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActiveListViewController : BaseViewController
@property (strong, nonatomic) JsonrpcServer *jsonrpcServer;
@end

NS_ASSUME_NONNULL_END
