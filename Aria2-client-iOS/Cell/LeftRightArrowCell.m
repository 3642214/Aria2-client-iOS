//
//  LeftRightArrowCell.m
//  huigongyou-project
//  左key,右value,带箭头 cell
//  Created by zj14 on 2017/3/28.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "LeftRightArrowCell.h"

@interface LeftRightArrowCell ()
@property (strong, nonatomic) UILabel *labelText, *textText;
@end

@implementation LeftRightArrowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ymColorWhite;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_labelText) {
            _labelText = [UILabel new];
            [_labelText setText:@" "];
            [self.contentView addSubview:_labelText];
            _labelText.font = [UIFont systemFontOfSize:ymFontSizeNormal];
            [_labelText setTextColor:ymLabelColor];
            [_labelText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ymScreen_left_padding);
                make.top.equalTo(self.contentView).offset(ymScreen_top_padding);
                make.bottom.equalTo(self.contentView).offset(ymScreen_bottom_padding);
            }];
        }
        [_labelText setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                    forAxis:UILayoutConstraintAxisHorizontal];
        if (!_textText) {
            _textText = [UILabel new];
            [_textText setText:@"无"];
            [self.contentView addSubview:_textText];
            _textText.textAlignment = NSTextAlignmentRight;
            _textText.font = [UIFont systemFontOfSize:ymFontSizeNormal];
            [_textText setTextColor:ymContentPrimaryTextColor];
            [_textText mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_labelText);
                //                make.bottom.equalTo(self.contentView).offset(ymScreen_bottom_padding);
                make.left.equalTo(_labelText.mas_right).offset(ymScreen_left_padding);
                make.size.equalTo(self.contentView).priorityLow();

                if ([reuseIdentifier isEqualToString:LeftRightNoArrowCellText]) {
                    make.right.equalTo(self.contentView).offset(ymScreen_right_padding * 2);
                } else {
                    make.right.equalTo(self.contentView).offset(ymScreen_right_padding);
                }
            }];
            _textText.numberOfLines = 0;
        }

        UIView *v = [UIView new];
        [self.contentView addSubview:v];
        v.backgroundColor = ymColorIngoreGrayLight;
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_textText.mas_bottom).offset(ymScreen_top_padding);
            make.height.equalTo(@1);
            make.left.right.bottom.equalTo(self.contentView);
        }];
    }
    if ([reuseIdentifier isEqualToString:LeftRightNoArrowCellText]) {
        self.accessoryType = UITableViewCellAccessoryNone;
    } else {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return self;
}

- (void)setLabel:(NSString *)label text:(NSString *)text {
    [_labelText setText:label];
    [_textText setText:text];
}

- (void)setTextColor:(UIColor *)color {
    [_textText setTextColor:color];
}

- (void)setLabel:(NSString *)label {
    [_labelText setText:label];
}
- (void)setText:(NSString *)text {
    [_textText setText:text];
}

- (NSString *)getTextStr {
    return [_textText text];
}
@end
