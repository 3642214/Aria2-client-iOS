//
//  FileInfoViewController.h
//  Aria2-client-iOS
//
//  Created by zj14 on 2019/2/24.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "BaseViewController.h"
#import "Result.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileInfoViewController : BaseViewController
@property (strong, nonatomic) NSString *gid;
@property (strong, nonatomic) NSString *rpcUri;
@property (strong, nonatomic) TaskInfo *taskInfo;
@end

NS_ASSUME_NONNULL_END
