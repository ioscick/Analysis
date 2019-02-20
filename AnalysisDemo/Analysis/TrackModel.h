//
//  TrackModel.h
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/7.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrackModel : NSObject

@property (copy, nonatomic) NSString *trackId;
@property (copy, nonatomic) NSString *trackName;
@property (assign, nonatomic) NSInteger viewTag;
@property (strong, nonatomic) NSDictionary *trackInfo;

- (instancetype)initWithTrackId:(NSString *)trackId trackName:(NSString *)trackName trackInfo:(nullable NSDictionary *)trackInfo viewTag:(NSInteger)ViewTag;
- (instancetype)initWithTrackId:(NSString *)trackId trackName:(NSString *)trackName trackInfo:(nullable NSDictionary *)trackInfo;

@end

NS_ASSUME_NONNULL_END
