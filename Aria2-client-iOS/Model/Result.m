//
//  Result.m
//  Aria2
//
//  Created by zj14 on 2019/2/23.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "Result.h"

@implementation Version
@end

@implementation GlobalStatus
@end

@implementation Uris
@end

@implementation Files
- (NSArray *)uris {
    return [NSArray yy_modelArrayWithClass:[Uris class] json:_uris];
}
@end

@implementation TaskInfo
- (NSArray *)files {
    return [NSArray yy_modelArrayWithClass:[Files class] json:_files];
}
@end

@implementation Setting

@end
