//
//  AppDelegate.h
//  monito
//
//  Created by lvtao on 16/11/18.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager * _mapManager;
}
@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,assign)CGFloat autoSizeScaleX;
@property(nonatomic,assign)CGFloat autoSizeScaleY;

@end

