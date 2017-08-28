//
//  UICollectionView+FYCollectionView.m
//  FYAPP
//
//  Created by 夜枫宇 on 2014/8/22.
//  Copyright © 2014年 fengyu. All rights reserved.
//

#import "UICollectionView+FYCollectionView.h"
#import "NSURL+FYURL.h"
#import "FYTools.h"

@implementation UICollectionView (FYCollectionView)

+ (instancetype)fy_collectionLayout:(UICollectionViewLayout *)layout target:(id)target itemName:(NSString *)itemName itemID:(NSString *)itemID {
    UICollectionView *cv = [self fy_collectionLayout:layout ?: [UICollectionViewLayout new]];
    [cv fy_collectionTarget:target];
    [cv fy_collectionItemName:itemName itemID:itemID];
    return cv;
}

+ (instancetype)fy_collectionLayout:(UICollectionViewLayout *)layout {
    return [[self alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
}

- (void)fy_collectionItemName:(NSString *)itemName itemID:(NSString *)itemID {
    if ([NSURL fy_URLNibName:itemName])
        [self registerNib:[UINib nibWithNibName:itemName bundle:nil] forCellWithReuseIdentifier:itemID];
    else [self registerClass:NSClassFromString(itemName) forCellWithReuseIdentifier:itemID];
}

- (void)fy_collectionTarget:(id)target {
    self.delegate = target;
    self.dataSource = target;
}

- (id)fy_collectionItemID:(NSString *)itemID indexPath:(NSIndexPath *)indexPath {
    return [self dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
}

- (void)fy_collectionPrefetchNO {
    if ([FYTools fy_iOSVersion] >= 10.0) self.prefetchingEnabled = NO;
}

- (void)fy_collectionHeaderID:(NSString *)headerID headerName:(NSString *)headerName {
    [self fy_collectionSupplementaryID:headerID kind:UICollectionElementKindSectionHeader supplementaryName:headerName];
}

- (void)fy_collectionFooterID:(NSString *)footerID footerName:(NSString *)footerName {
    [self fy_collectionSupplementaryID:footerID kind:UICollectionElementKindSectionFooter supplementaryName:footerName];
}

- (void)fy_collectionSupplementaryID:(NSString *)supplementaryID kind:(NSString *)kind supplementaryName:(NSString *)supplementaryName {
    if ([NSURL fy_URLNibName:supplementaryName])
        [self registerNib:[UINib nibWithNibName:supplementaryName bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:supplementaryID];
    else [self registerClass:NSClassFromString(supplementaryName) forSupplementaryViewOfKind:kind withReuseIdentifier:supplementaryID];
}

@end
