//
//  UIGestureRecognizer+Analysis.m
//  GlobalScanner
//
//  Created by 沈立平 on 2019/1/11.
//  Copyright © 2019年 xiaojian. All rights reserved.
//

#import "UIGestureRecognizer+Analysis.h"
#import "UIView+AnalysisBind.h"
#import "ExchangeMethodTool.h"
#import "TrackListManager.h"
#import "UIViewController+CurrentViewController.h"
#import <objc/runtime.h>

static NSString *analysisTagString = @"analysisTagString";

@implementation UIGestureRecognizer (Analysis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ExchangeMethodTool exchangeMethodWithOriClass:[self class] originalSel:@selector(initWithTarget:action:) replaceSel:@selector(analysis_initWithTarget:action:)];
        [ExchangeMethodTool exchangeMethodWithOriClass:[self class] originalSel:@selector(addTarget:action:) replaceSel:@selector(analysis_addTarget:action:)];
    });
}

- (void)setAnalysisTag:(NSString *)analysisTag {
    objc_setAssociatedObject(self, &analysisTagString, analysisTag, OBJC_ASSOCIATION_COPY);
}

- (NSString *)analysisTag {
    return objc_getAssociatedObject(self, &analysisTagString);
}

- (instancetype)analysis_initWithTarget:(id)target action:(SEL)action {
    id gester = [self analysis_initWithTarget:target action:action];
    if ([gester isKindOfClass:[UITapGestureRecognizer class]]) {
        self.analysisTag = [NSString stringWithFormat:@"%@/%@/%@", NSStringFromClass([[UIViewController yh_currentViewController] class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
        [gester analysis_addTarget:[TrackListManager shareInstance] action:@selector(gestureTrack:)];
    }
    return gester;
}

- (void)analysis_addTarget:(id)target action:(SEL)action {
    [self analysis_addTarget:target action:action];
    if ([self isKindOfClass:[UITapGestureRecognizer class]]) {
        self.analysisTag = [NSString stringWithFormat:@"%@/%@/%@", NSStringFromClass([[UIViewController yh_currentViewController] class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
        [self analysis_addTarget:[TrackListManager shareInstance] action:@selector(gestureTrack:)];
    }
}

@end
