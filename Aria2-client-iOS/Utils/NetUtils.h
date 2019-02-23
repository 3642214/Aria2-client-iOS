//
//  NetUtils.h
//  test
//
//  Created by zj14 on 16/9/20.
//  Copyright © 2016年 zj14. All rights reserved.
//

#ifndef NetUtils_h
#define NetUtils_h

#define YMFAILURE(f, m)                                                                                                \
    LLog(@"%@", m);                                                                                                    \
    if (f) f(m)

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

typedef void (^responseOK)(NSString *, NSInteger count);
typedef void (^responseFAIL)(NSString *);

@interface NetUtils : NSObject
+ (void)doPost:(NSString *)url
    withParameters:(NSDictionary *)dict
           success:(responseOK)success
           failure:(responseFAIL)failure;

@end
#endif /* NetUtils_h */
