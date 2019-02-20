//
//  TrackModel.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/7.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "TrackModel.h"

@implementation TrackModel

- (instancetype)initWithTrackId:(NSString *)trackId trackName:(NSString *)trackName trackInfo:(nullable NSDictionary *)trackInfo viewTag:(NSInteger)ViewTag {
    if (self = [super init]) {
        self.trackId = trackId;
        self.trackName = trackName;
        self.trackInfo = trackInfo;
        self.viewTag = ViewTag;
    }
    return self;
}

- (instancetype)initWithTrackId:(NSString *)trackId trackName:(NSString *)trackName trackInfo:(nullable NSDictionary *)trackInfo {
    return [self initWithTrackId:trackId trackName:trackName trackInfo:trackInfo viewTag:-1];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"id is %@\n name is %@ \n info is %@", self.trackId, self.trackName, self.trackInfo];
}

@end
