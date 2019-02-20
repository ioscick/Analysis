//
//  ExchangeMethodTool.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "ExchangeMethodTool.h"
#import <objc/runtime.h>

@implementation ExchangeMethodTool

+ (void)exchangeMethodWithOriClass:(Class)cls replaceClas:(Class)replaceClass originalSel:(SEL)originalSel replaceSel:(SEL)replaceSel {
    if (cls == nil || replaceClass == nil || originalSel == nil || replaceSel == nil) {
        return;
    }
    Class originalClass = cls;
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replaceMethod = class_getInstanceMethod(replaceClass, replaceSel);
    if (originalMethod == nil) {
        originalMethod = class_getClassMethod(originalClass, originalSel);
        replaceMethod = class_getClassMethod(replaceClass, replaceSel);
    }
    
    BOOL isAdded = class_addMethod(originalClass, replaceSel, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
    if (isAdded) {
        Method newMethod = class_getInstanceMethod(cls, replaceSel);
        if (newMethod) {
            method_exchangeImplementations(originalMethod, newMethod);
        }
    } else {
        method_exchangeImplementations(originalMethod, replaceMethod);
    }
}

+ (void)exchangeMethodWithOriClass:(Class)cls originalSel:(SEL)originalSel replaceSel:(SEL)replaceSel {
    [self exchangeMethodWithOriClass:cls replaceClas:cls originalSel:originalSel replaceSel:replaceSel];
}

@end
