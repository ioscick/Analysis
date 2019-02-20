//
//  UIView+AnalysisBind.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/7.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "UIView+AnalysisBind.h"
#import <objc/runtime.h>

static NSString *infoStringkey = @"infoStringkey";

@implementation UIView (AnalysisBind)

- (NSDictionary *)info {
    return objc_getAssociatedObject(self, &infoStringkey);
}

- (void)setInfo:(NSDictionary *)info {
    objc_setAssociatedObject(self, &infoStringkey, info, OBJC_ASSOCIATION_RETAIN);
}

@end
