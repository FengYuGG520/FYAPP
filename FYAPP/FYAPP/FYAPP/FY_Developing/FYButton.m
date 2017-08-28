//
//  FYButton.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "FYButton.h"
#import "UILabel+FYLabel.h"
#import "FYAutoLayout.h"

@implementation FYButton

- (instancetype)initWithImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    if (self = [super init]) {
        /**
         *  创建 UIImageView + UILabel
         *  实现图片与文本的分离
         */
        UIImageView *imageView = [UIImageView new];
        UILabel *label = [UILabel new];
        [self addSubview:imageView];
        [self addSubview:label];
        imageView.image = img;
        [label recordLblText:title color:titleColor fontSize:fontSize];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        // 完成两个子控件的布局
        [imageView fy_makeConstraints:^(FYConstraintMaker *make) {
            
            make.top.right.left.equalTo(self);
            make.size.fy_equalTo(CGSizeMake(imgWH, imgWH));
        }];
        [label fy_makeConstraints:^(FYConstraintMaker *make) {
            
            make.top.equalTo(imageView.fy_bottom).offset(spacing);
            make.centerX.equalTo(imageView);
        }];
        [self fy_makeConstraints:^(FYConstraintMaker *make) {
            
            make.bottom.equalTo(label.fy_bottom);
        }];
        // 记录属性, 可以通过访问父类的这两个属性得到这两个控件
        _imageView = imageView;
        _label = label;
    }
    return self;
}

// 类方法 极速创建 FYButton
+ (instancetype)fy_btnImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing {
    return [[self alloc] initWithImg:img imgWH:imgWH title:title fontSize:fontSize titleColor:titleColor spacing:spacing];
}

// MARK: 添加高亮的两个事件
- (void)setHighlighted:(BOOL)highlighted {
    // 按下去 UIControlEventTouchUpInside
    if (highlighted) [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    // 弹起 UIControlEventTouchUpOutside
    else [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
}

@end
