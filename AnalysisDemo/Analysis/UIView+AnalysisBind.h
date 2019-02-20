//
//  UIView+AnalysisBind.h
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/7.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AnalysisBind)

@property (strong, nonatomic) TrackModel *info;

@end

NS_ASSUME_NONNULL_END
