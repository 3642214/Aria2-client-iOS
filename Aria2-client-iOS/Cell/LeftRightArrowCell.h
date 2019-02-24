//
//  LeftRightArrowCell.h
//  huigongyou-project
//  左key,右value,带箭头 cell
//  Created by zj14 on 2017/3/28.
//  Copyright © 2017年 ss. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LeftRightArrowCellText @"LeftRightArrowCellText"
#define LeftRightNoArrowCellText @"LeftRightNoArrowCellText"

@interface LeftRightArrowCell : UITableViewCell
- (void)setLabel:(NSString *)label text:(NSString *)text;
- (void)setLabel:(NSString *)label;
- (void)setText:(NSString *)text;
- (void)setTextColor:(UIColor *)color;
- (NSString *)getTextStr;
@end
