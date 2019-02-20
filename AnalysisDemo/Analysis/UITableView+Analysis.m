//
//  UITableView+Analysis.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "UITableView+Analysis.h"
#import "ExchangeMethodTool.h"
#import "TrackListManager.h"
#import "UIView+AnalysisBind.h"
#import "UIViewController+CurrentViewController.h"

@implementation UITableView (Analysis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ExchangeMethodTool exchangeMethodWithOriClass:[self class] originalSel:@selector(setDelegate:) replaceSel:@selector(analysis_setDelegate:)];
    });
}

- (void)analysis_setDelegate:(id<UITableViewDelegate>)delegate {
    [self analysis_setDelegate:delegate];
    [self exchangeTableViewDelegate:delegate];
}

- (void)exchangeTableViewDelegate:(id<UITableViewDelegate>)delegate {
    [ExchangeMethodTool exchangeMethodWithOriClass:[delegate class] replaceClas:[self class] originalSel:@selector(tableView:didSelectRowAtIndexPath:) replaceSel:@selector(analysis_tableView:didSelectRowAtIndexPath:)];
}

- (void)analysis_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *trackid = [NSString stringWithFormat:@"%@/%@/TableView%ld%ld", NSStringFromClass([[UIViewController yh_currentViewController] class]), NSStringFromClass([self class]), (long)indexPath.section, (long)indexPath.row];
    if (cell.tag > 0) {
        trackid = [trackid stringByAppendingString:[NSString stringWithFormat:@"/%ld", (long)cell.tag]];
    }
    [[TrackListManager shareInstance] trackWithViewID:trackid trackModel:cell.info];
    [self analysis_tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
