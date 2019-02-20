//
//  TrackListManager.h
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrackListManager : NSObject

+ (instancetype)shareInstance;

- (void)trackWithViewID:(NSString *)viewID;

- (void)trackWithViewID:(NSString *)viewID trackModel:(nullable TrackModel *)trackModel;

- (void)gestureTrack:(id)tap;

@end

NS_ASSUME_NONNULL_END
