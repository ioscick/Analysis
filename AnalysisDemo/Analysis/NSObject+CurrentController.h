//
//  NSObject+CurrentController.h
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/2/12.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CurrentController)

+ (UIViewController *)currentController;

@end

NS_ASSUME_NONNULL_END
