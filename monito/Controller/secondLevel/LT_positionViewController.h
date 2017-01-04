//
//  LT_positionViewController.h
//  monito
//
//  Created by lvtao on 16/11/25.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
@interface LT_positionViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate, BMKPoiSearchDelegate>
@property(copy,nonatomic) NSString * Nmonitor_unit_name;

@end
