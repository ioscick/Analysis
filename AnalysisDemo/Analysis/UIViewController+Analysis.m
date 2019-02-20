//
//  UIViewController+Analysis.m
//  GlobalScanner
//
//  Created by 沈立平 on 2019/1/18.
//  Copyright © 2019年 xiaojian. All rights reserved.
//

#import "UIViewController+Analysis.h"
#import "ExchangeMethodTool.h"
#import "TrackListManager.h"
#import "UIView+AnalysisBind.h"

@implementation UIViewController (Analysis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ExchangeMethodTool exchangeMethodWithOriClass:[self class] originalSel:@selector(viewWillAppear:) replaceSel:@selector(analysis_viewWillAppear:)];
    });
}

- (void)analysis_viewWillAppear:(BOOL)animated {
    [self analysis_viewWillAppear:animated];
    [[TrackListManager shareInstance] trackWithViewID:[NSString stringWithFormat:@"%@/%@", NSStringFromClass([self class]), NSStringFromClass([self class])] trackModel:self.view.info];
}

@end
