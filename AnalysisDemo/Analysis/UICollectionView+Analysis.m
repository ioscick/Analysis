//
//  UICollectionView+Analysis.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "UICollectionView+Analysis.h"
#import "ExchangeMethodTool.h"
#import "TrackListManager.h"
#import "UIView+AnalysisBind.h"
#import "NSObject+CurrentController.h"

@implementation UICollectionView (Analysis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ExchangeMethodTool exchangeMethodWithOriClass:[self class] originalSel:@selector(setDelegate:) replaceSel:@selector(analysis_setDelegate:)];
    });
}

- (void)analysis_setDelegate:(id<UICollectionViewDelegate>)delegate {
    [self analysis_setDelegate:delegate];
    [self exchangeDelegate:delegate];
}

- (void)exchangeDelegate:(id<UICollectionViewDelegate>)delegate {
    [ExchangeMethodTool exchangeMethodWithOriClass:[delegate class] replaceClas:[self class] originalSel:@selector(collectionView:didSelectItemAtIndexPath:) replaceSel:@selector(analysis_collectionView:didSelectItemAtIndexPath:)];
}

- (void)analysis_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@Collection%ld%ld", NSStringFromClass([self class]), indexPath.section, indexPath.row);
    NSString *trackId = [NSString stringWithFormat:@"%@/%@/CollectionView%ld%ld", NSStringFromClass([[NSObject currentController] class]), NSStringFromClass([self class]), indexPath.section, indexPath.row];
    if (cell.tag > 0) {
        trackId = [trackId stringByAppendingString:[NSString stringWithFormat:@"/%ld", cell.tag]];
    }
    [[TrackListManager shareInstance] trackWithViewID:trackId trackModel:cell.info];
    [self analysis_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

@end
