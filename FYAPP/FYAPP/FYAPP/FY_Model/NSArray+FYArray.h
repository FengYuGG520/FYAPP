#import <UIKit/UIKit.h>

@interface NSArray (FYArray)

/**
 根据 plist 文件名 (不需要加 .plist 后缀), 以及模型名, 得到这个模型数组
 
 @param plistName plist 文件名 (不需要加 .plist 后缀)
 @param modelName 模型名
 @return 得到这个模型数组
 */
+ (NSArray *)fy_plistName:(NSString *)plistName modelName:(NSString *)modelName;

/**
 根据一个 URL 路径的数组, 返回一个图片数组
 
 @param urls URL 路径的数组
 @return 一个图片数组
 */
+ (NSArray<UIImage *> *)fy_ImgArrWithURLArr:(NSArray<NSURL *> *)urls;

/**
 移动某行数据到某行数据, 可变数组数据的移动

 @param moveRow 要移动的数据
 @param toRow 目标行
 */
- (void)fy_arrMoveRow:(NSInteger)moveRow toRow:(NSInteger)toRow;

/**
 在一个可变数组后面加数组

 @param arr 数组
 */
- (void)fy_arrmAddArr:(NSArray *)arr;

@end
