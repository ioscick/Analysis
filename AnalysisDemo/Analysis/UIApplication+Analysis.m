//
//  UIApplication+Analysis.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "UIApplication+Analysis.h"
#import "ExchangeMethodTool.h"
#import "TrackListManager.h"
#import "UIView+AnalysisBind.h"
#import "NSObject+CurrentController.h"

@implementation UIApplication (Analysis)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [ExchangeMethodTool exchangeMethodWithOriClass:[self class] originalSel:@selector(sendAction:to:from:forEvent:) replaceSel:@selector(analysis_sendAction:to:from:forEvent:)];
    });
}

- (BOOL)analysis_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    if (![sender isKindOfClass:[UIView class]]) {
        return [self analysis_sendAction:action to:target from:sender forEvent:event];
    }
    NSString *trackid = [NSString stringWithFormat:@"%@/%@/%@", NSStringFromClass([[NSObject currentController] class]), NSStringFromClass([target class]), NSStringFromSelector(action)];
    UIView *targetView = sender;
    if (targetView.tag > 0) {
        trackid = [trackid stringByAppendingString:[NSString stringWithFormat:@"%ld", targetView.tag]];
    }
    [[TrackListManager shareInstance] trackWithViewID:[trackid stringByReplacingOccurrencesOfString:@":" withString:@""] trackModel:targetView.info];
    return [self analysis_sendAction:action to:target from:sender forEvent:event];
}

@end
