//
//  UIButton+Bootstrap.m
//  UIButton+Bootstrap
//
//  Created by Oskur on 2013-09-29.
//  Copyright (c) 2013 Oskar Groth. All rights reserved.
//
#import "UIButton+Bootstrap.h"
#include "UIColor+expanded.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIButton (Bootstrap)

- (void)bootstrapStyle {
    self.layer.borderWidth = 1;
        self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
    // 剪切超过图层的显示部分
    self.layer.masksToBounds = YES;
    // 去掉系统按下高亮灰色效果
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:self.titleLabel.font.pointSize]];
}

- (void)defaultStyle {
    [self bootstrapStyle];
    [self setTitleColor:ymColorBrandGreen forState:UIControlStateNormal];
    [self setTitleColor:ymColorBrandGreen forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235 / 255.0
                                                                        green:235 / 255.0
                                                                         blue:235 / 255.0
                                                                        alpha:1]]
                    forState:UIControlStateHighlighted];
}

- (void)primaryStyle {
    [self bootstrapStyle];
    self.backgroundColor = ymColorBrandGreen;
    self.layer.borderColor = [ymColorBrandGreen CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x28a464"]]
                    forState:UIControlStateHighlighted];
}

- (void)successStyle {
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:ymColorBrandGreen] forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x3bbc79" andAlpha:0.5]]
                    forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x32a067"]]
                    forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (void)infoStyle {
    [self bootstrapStyle];
    self.layer.borderColor = [[UIColor clearColor] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x4E90BF"]]
                    forState:UIControlStateNormal];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x4E90BF" andAlpha:0.5]]
                    forState:UIControlStateDisabled];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0x4E90BF"]]
                    forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}

- (void)warningStyle {
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithHexString:@"0xff5847"];
    self.layer.borderColor = [[UIColor colorWithHexString:@"0xff5847"] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithHexString:@"0xef4837"]]
                    forState:UIControlStateHighlighted];
}

- (void)dangerStyle {
    [self bootstrapStyle];
    self.backgroundColor = [UIColor colorWithRed:217 / 255.0 green:83 / 255.0 blue:79 / 255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212 / 255.0 green:63 / 255.0 blue:58 / 255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210 / 255.0
                                                                        green:48 / 255.0
                                                                         blue:51 / 255.0
                                                                        alpha:1]]
                    forState:UIControlStateHighlighted];
}

- (UIImage *)buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIButton *)buttonWithStyle:(StrapButtonStyle)style
                     andTitle:(NSString *)title
                     andFrame:(CGRect)rect
                       target:(id)target
                       action:(SEL)selector {
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    const SEL selArray[] = {
        @selector(bootstrapStyle),
        @selector(defaultManager),
        @selector(primaryStyle),
        @selector(successStyle),
        @selector(infoStyle),
        @selector(warningStyle),
        @selector(dangerStyle)
    };
    if ([btn respondsToSelector:selArray[style]]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [btn performSelector:selArray[style]];
#pragma clang diagnostic pop
    }
    return btn;
}

@end
