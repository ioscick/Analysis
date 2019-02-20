//
//  TrackListManager.m
//  AnalysisDemo
//
//  Created by 沈立平 on 2019/1/4.
//  Copyright © 2019年 沈立平. All rights reserved.
//

#import "TrackListManager.h"
#import "UIViewController+CurrentViewController.h"
#import "UIView+AnalysisBind.h"
#import "GGJTrackManager.h"
#import "GGJTrackClick.h"
#import "UIGestureRecognizer+Analysis.h"

@interface TrackListManager ()

@property (strong, nonatomic) NSMutableDictionary *trackdict;
@property (strong, nonatomic) NSMutableArray *trackList;
@property (strong, nonatomic) NSMutableArray *scrollTrackList;


@end

@implementation TrackListManager

+ (instancetype)shareInstance {
    static TrackListManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TrackListManager alloc] init];
        [manager createData];
    });
    return manager;
}

- (void)createData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"AnalysisPlist" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [plistDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        NSArray *keys = [dict allKeys];
        for (NSString *dictKey in keys) {
            NSString *lastStr = [[dictKey componentsSeparatedByString:@"/"] lastObject];
            if ([lastStr isEqualToString:@"TableView"] || [lastStr isEqualToString:@"CollectionView"]) {
                [self.scrollTrackList addObject:[NSString stringWithFormat:@"%@/%@", key, dictKey]];
            } else {
                [self.trackList addObject:[NSString stringWithFormat:@"%@/%@", key, dictKey]];
            }
            [self.trackdict setObject:[obj objectForKey:dictKey] forKey:[NSString stringWithFormat:@"%@/%@", key, dictKey]];
        }
    }];
}

#pragma mark - public
- (void)trackWithViewID:(NSString *)viewID {
    [self trackWithViewID:viewID trackModel:nil];
}

- (void)trackWithViewID:(NSString *)viewID trackModel:(nullable TrackModel *)trackModel {
    //整个Table点击埋点(一般视图)
    if (trackModel && trackModel.viewTag != -1) {
        viewID = [NSString stringWithFormat:@"%@/%ld", viewID, trackModel.viewTag];
    }
    NSLog(@"Viewid is %@", viewID);
    if ([viewID containsString:@"TableView"] || [viewID containsString:@"CollectionView"]) {
        for (NSString *trackString in self.scrollTrackList) {
            if ([viewID containsString:trackString]) {
                //进行埋点统计
                NSLog(@"tableView All trackID is %@ trackmodel is %@", self.trackdict[trackString], trackModel);
                if (trackModel) {
                    NSDictionary *attributes = [GGJTrackClick attributesWithTargetId:trackModel.trackId targetName:trackModel.trackName type:nil];
                    [GGJTrackClick logEvent:[self.trackdict[viewID] intValue] attributes:attributes];
                } else {
                    [GGJTrackClick logEvent:[self.trackdict[viewID] intValue] attributes:nil];
                }
                return;
            }
        }
    }
    if (![self.trackList containsObject:viewID]) {
        NSLog(@"no track");
        return;
    }
    //进行埋点统计
    NSLog(@"trackID is %@ trackmodel is %@", self.trackdict[viewID], trackModel);
    if (trackModel) {
        NSDictionary *attributes = [GGJTrackClick attributesWithTargetId:trackModel.trackId targetName:trackModel.trackName type:nil];
        [GGJTrackClick logEvent:[self.trackdict[viewID] intValue] attributes:attributes];
    } else {
        [GGJTrackClick logEvent:[self.trackdict[viewID] intValue] attributes:nil];
    }
    
}

- (void)gestureTrack:(id)tap {
    UITapGestureRecognizer *tapgst = tap;
    NSString *tapViewId = [tapgst.analysisTag stringByReplacingOccurrencesOfString:@":" withString:@""];
    if (tapgst.view.tag != 0) {
        tapViewId = [NSString stringWithFormat:@"%@%ld", tapViewId, tapgst.view.tag];
    }
    NSLog(@"tapname is %@", tapViewId);
    tapgst.view.info.viewTag = tapgst.view.tag;
    [self trackWithViewID:tapViewId trackModel:tapgst.view.info];
}

#pragma mark - Getter && Setter
- (NSMutableArray *)trackList {
    if (!_trackList) {
        _trackList = [NSMutableArray arrayWithCapacity:3];
    }
    return _trackList;
}

- (NSMutableDictionary *)trackdict {
    if (!_trackdict) {
        _trackdict = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _trackdict;
}

- (NSMutableArray *)scrollTrackList {
    if (!_scrollTrackList) {
        _scrollTrackList = [NSMutableArray arrayWithCapacity:3];
    }
    return _scrollTrackList;
}

@end
