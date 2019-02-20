//
//  AnalysisDemo.h
//  GlobalScanner
//
//  Created by 沈立平 on 2019/1/23.
//  Copyright © 2019年 xiaojian. All rights reserved.
//

#ifndef AnalysisDemo_h
#define AnalysisDemo_h


#endif /* AnalysisDemo_h */

/**
 目前所有点击响应事件都有自己的ViewID，用于区分当前事件，用作埋点  事件ID的生成由当前的Controller和所在的父View和Action方法名加上Viewtag用于区分相同的事件不同的处理
 如果需要传参，需要在view绑定数据，绑定TrackModel。 例：UserCenterCollectionBuilder 52行 cell.info = [[TrackModel alloc] initWithTrackId:goodsModel.saleGoodsId trackName:goodsModel.name trackInfo:nil];
 
 
 */
