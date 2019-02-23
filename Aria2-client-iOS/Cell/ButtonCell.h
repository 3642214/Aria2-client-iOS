//
//  ButtonCell.h
//  huigongyou-project
//
//  Created by zj14 on 2017/4/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ButtonCellText @"ButtonCellText"
@interface ButtonCell : UITableViewCell
@property (strong, nonatomic) void (^clickEvent)();
- (id)initWithBtnStyle:(StrapButtonStyle)style title:(NSString *)title clickEvent:(void (^)())clickEvent;
@end
