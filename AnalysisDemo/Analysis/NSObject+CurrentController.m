//
//  NSObject+CurrentController.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/2/12.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "NSObject+CurrentController.h"

@implementation NSObject (CurrentController)

+ (UIViewController *)currentController {
    UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (rootController.presentedViewController) {
        return rootController;
    } else if ([rootController isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)rootController topViewController];
    } else if ([rootController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)rootController;
        UINavigationController *nav = tab.selectedViewController;
        return [nav topViewController];
    } else {
        return rootController;
    }
}

@end
