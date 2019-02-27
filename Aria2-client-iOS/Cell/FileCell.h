//
//  FileCell.h
//  Aria2
//
//  Created by zj14 on 2019/2/23.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Result.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileCell : UITableViewCell
@property (strong, nonatomic) TaskInfo *active;
@end

NS_ASSUME_NONNULL_END
