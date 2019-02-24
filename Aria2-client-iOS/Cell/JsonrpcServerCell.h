//
//  JsonrpcServerCell.h
//  Aria2-client-iOS
//
//  Created by zj14 on 2019/2/24.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonrpcServer.h"
#import "Result.h"

NS_ASSUME_NONNULL_BEGIN

@interface JsonrpcServerCell : UITableViewCell
@property (strong, nonatomic) JsonrpcServer *jsonrpcServer;
@property (strong, nonatomic) GlobalStatus *stat;
- (void)setOfflineStat;
@end

NS_ASSUME_NONNULL_END
