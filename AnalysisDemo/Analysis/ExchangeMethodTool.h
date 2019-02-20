//
//  ExchangeMethodTool.h
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExchangeMethodTool : NSObject

+ (void)exchangeMethodWithOriClass:(Class)cls replaceClas:(Class)replaceClass originalSel:(SEL)originalSel replaceSel:(SEL)replaceSel;

+ (void)exchangeMethodWithOriClass:(Class)cls originalSel:(SEL)originalSel replaceSel:(SEL)replaceSel;

@end

NS_ASSUME_NONNULL_END
