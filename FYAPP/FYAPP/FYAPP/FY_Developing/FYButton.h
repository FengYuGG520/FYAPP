//
//  FYButton.h
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYButton : UIControl

@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *label;

/**
 图片文本按钮, 里面有两个子控件, (UIImageView *)imageView (UILabel *)label
 
 @param img 图片
 @param imgWH 图片宽高
 @param title 文本
 @param fontSize 文字大小
 @param titleColor 文字颜色
 @param spacing 图片和文本间距
 @return 图片文本按钮
 */
+ (instancetype)fy_btnImg:(UIImage *)img imgWH:(CGFloat)imgWH title:(NSString *)title fontSize:(CGFloat)fontSize titleColor:(UIColor *)titleColor spacing:(CGFloat)spacing;

@end
