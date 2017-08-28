/**
 *  CoverFlowView 使用方式:
 *      1. new
 *      2. 添加到父视图布局并记录
 *      3. 设置图片数组
 */

#import <UIKit/UIKit.h>

@interface FYCoverFlowView : UIView

/**
 设置图片的数组
 */
@property (strong, nonatomic) NSArray<UIImage *> *models;

@end
