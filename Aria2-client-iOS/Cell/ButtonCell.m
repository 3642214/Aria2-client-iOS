//
//  ButtonCell.m
//  huigongyou-project
//
//  Created by zj14 on 2017/4/6.
//  Copyright © 2017年 ss. All rights reserved.
//

#import "ButtonCell.h"

@interface ButtonCell ()
@property (strong, nonatomic) UIButton *btn;
@end

@implementation ButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    return [self initWithBtnStyle:StrapSuccessStyle title:@"关闭" clickEvent:nil];
}

- (id)initWithBtnStyle:(StrapButtonStyle)style title:(NSString *)title clickEvent:(void (^)())clickEvent {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ButtonCellText];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (!_btn) {
            _btn = [UIButton buttonWithStyle:style
                                    andTitle:title
                                    andFrame:CGRectMake(18, 20, ymScreen_Width - 18 * 2, 45)
                                      target:self
                                      action:@selector(btnClicked)];
            [self.contentView addSubview:_btn];
            [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@45);
                make.top.equalTo(self.contentView).offset(ymScreen_top_padding);
                make.left.equalTo(self.contentView).offset(ymScreen_left_padding);
                make.right.equalTo(self.contentView).offset(ymScreen_right_padding);
                make.bottom.equalTo(self.contentView).offset(ymScreen_bottom_padding);
            }];
        }
    }
    _clickEvent = clickEvent;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

- (void)btnClicked {
    if (_clickEvent) {
        _clickEvent();
    }
}

@end
