//
//  JsonrpcServerCell.m
//  Aria2-client-iOS
//
//  Created by zj14 on 2019/2/24.
//  Copyright © 2019 郑珏. All rights reserved.
//

#import "JsonrpcServerCell.h"

@interface JsonrpcServerCell ()
@property (strong, nonatomic) UILabel *nameT, *uriT, *statT, *speedT;
@end

@implementation JsonrpcServerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = ymColorWhite;
        if (!_nameT) {
            _nameT = [UILabel new];
            [_nameT setText:@" "];
            [self.contentView addSubview:_nameT];
            _nameT.numberOfLines = 2;
            _nameT.font = [UIFont systemFontOfSize:ymFontSizeBigger];
            [_nameT setTextColor:ymContentPrimaryTextColor];
            [_nameT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(ymScreen_left_padding);
                make.right.equalTo(self.contentView).offset(ymScreen_right_padding);
                make.top.equalTo(self.contentView).offset(ymScreen_top_padding);
            }];
        }
        [_nameT setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                forAxis:UILayoutConstraintAxisHorizontal];
        if (!_uriT) {
            _uriT = [UILabel new];
            [_uriT setText:@"无"];
            [self.contentView addSubview:_uriT];
            _uriT.font = [UIFont systemFontOfSize:ymFontSizeNormal];
            [_uriT setTextColor:ymLabelColor];
            [_uriT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_nameT);
                make.top.equalTo(_nameT.mas_baseline).offset(ymScreen_top_padding / 3);
            }];
        }

        if (!_statT) {
            _statT = [UILabel new];
            _statT.text = @" ";
            [self.contentView addSubview:_statT];
            _statT.font = [UIFont systemFontOfSize:ymFontSizeNormal];
            [_statT setTextColor:ymContentPrimaryTextColor];
            [_statT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_nameT);
                make.top.equalTo(_uriT.mas_bottom).offset(ymScreen_top_padding);
            }];
        }

        if (!_speedT) {
            _speedT = [UILabel new];
            _speedT.text = @" ";
            [self.contentView addSubview:_speedT];
            _speedT.font = [UIFont systemFontOfSize:ymFontSizeNormal];
            [_speedT setTextColor:ymContentPrimaryTextColor];
            [_speedT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(ymScreen_right_padding);
                make.top.equalTo(_uriT.mas_bottom).offset(ymScreen_top_padding);
            }];
        }

        UIView *v = [UIView new];
        [self.contentView addSubview:v];
        v.backgroundColor = ymColorIngoreGrayLight;
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@2);
            make.top.equalTo(_statT.mas_bottom).offset(ymScreen_top_padding);
            make.bottom.equalTo(self.contentView);
        }];
    }

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    return self;
}

- (void)setJsonrpcServer:(JsonrpcServer *)jsonrpcServer {
    _nameT.text = jsonrpcServer.name;
    _uriT.text = jsonrpcServer.uri;
}

- (void)setStat:(GlobalStatus *)stat {
    if (stat) {
        _statT.text = [NSString
            stringWithFormat:@"🔽%ld ⏸️%ld ⏹%ld", stat.numActive, stat.numWaiting, stat.numStoppedTotal];
        _speedT.text = [NSString stringWithFormat:@"⏬%@/s ⏫%@/s", [CommonUtils changeKMGB:stat.downloadSpeed],
                                                  [CommonUtils changeKMGB:stat.uploadSpeed]];
    } else {
        [self setOfflineStat];
    }
}

- (void)setOfflineStat {
    _statT.text = @"服务器状态获取失败，刷新试试";
    _speedT.text = @" ";
}

@end
