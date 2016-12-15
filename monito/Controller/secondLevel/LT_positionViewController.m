//
//  LT_positionViewController.m
//  monito
//  GPS定位
//  Created by lvtao on 16/11/25.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_positionViewController.h"

@interface LT_positionViewController (){
    BMKLocationService* _locService;
    BMKPoiSearch* _poisearch;
    int curPage;
    BMKMapView* _mapView;
}
///@brief 名称
@property (weak, nonatomic) IBOutlet UITextField *name;
///@brief 地址
@property (weak, nonatomic) IBOutlet UITextField *adress;
///@brief 经纬度
@property (weak, nonatomic) IBOutlet UITextField *LatLon;
///@brief 城市名称
@property (weak, nonatomic) IBOutlet UITextField *cityName;
///@brief 关键字
@property (weak, nonatomic) IBOutlet UITextField *keyword;
///@brief GPS时间
@property (weak, nonatomic) IBOutlet UILabel *GPSTime;
///@brief GPS地址
@property (weak, nonatomic) IBOutlet UILabel *GPSadress;
///@brief GPS纬度
@property (weak, nonatomic) IBOutlet UILabel *GPSLat;
///@brief GPS经度
@property (weak, nonatomic) IBOutlet UILabel *GPSLog;
///@brief GPS营运商
@property (weak, nonatomic) IBOutlet UILabel *GPSoperators;
///@brief GPS描述
@property (weak, nonatomic) IBOutlet UILabel *GPSdescribe;

//@property (nonatomic, strong) BMKLocationService *locService;

@property (nonatomic, strong) BMKGeoCodeSearch *geoCode;        // 地理编码

@property (nonatomic, assign) CGFloat longitude;  // 经度

@property (nonatomic, assign) CGFloat latitude; // 纬度
@end

@implementation LT_positionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _locService = [[BMKLocationService alloc]init];
    _poisearch = [[BMKPoiSearch alloc]init];
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
     _poisearch.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _poisearch.delegate = nil;
}
-(void)setUI{
    [self setTextfiled:self.name andName:@" 名    称："];
    [self setTextfiled:self.adress andName:@" 地   址："];
    [self setTextfiled:self.LatLon andName:@" 经 纬 度："];
    [self setTextfiled:self.cityName andName:@" 城市名称:"];
    [self setTextfiled:self.keyword andName:@" 关 键 字:"];
}
-(void)setTextfiled:(UITextField *)tf andName:(NSString *)string{
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 35)];
    lab.text =string;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lab;
}
//保存搜索定位
- (IBAction)saveSeacrhPosition:(UIButton *)sender {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    // 初始化反地址编码选项（数据模型）
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    // 将数据传到反地址编码模型
    option.reverseGeoPoint = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    NSLog(@"%f - %f", option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    // 调用反地址编码方法，让其在代理方法中输出
    [self.geoCode reverseGeoCode:option];

}
//地址搜索
- (IBAction)SearchAdress:(UIButton *)sender {
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageCapacity = 10;
    citySearchOption.city=@"北京";
    citySearchOption.keyword = @"网吧";
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }
    
}
//保存GPS定位
- (IBAction)saveGPSAdress:(UIButton *)sender {
    
}
// 路径规划
- (IBAction)pathPlanning:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser
{
    NSLog(@"启动定位");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    self.latitude =userLocation.location.coordinate.latitude;
    self.longitude =userLocation.location.coordinate.longitude;
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}
#pragma mark geoCode的Get方法，实现延时加载
- (BMKGeoCodeSearch *)geoCode
{
    if (!_geoCode)
    {
        _geoCode = [[BMKGeoCodeSearch alloc] init];
        _geoCode.delegate = self;
    }
    return _geoCode;
}
//#pragma mark 代理方法返回反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        NSLog(@"位置结果是：%@ - %@", result.address, result.addressDetail.city);

        // 定位一次成功后就关闭定位
        [_locService stopUserLocationService];
        
    }else{
        NSLog(@"%@", @"找不到相对应的位置");
    }
    
}

#pragma mark 代理方法返回地理编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        NSString *locationString = [NSString stringWithFormat:@"经度为：%.2f   纬度为：%.2f", result.location.longitude, result.location.latitude];
        NSLog(@"经纬度为：%@ 的位置结果是：%@", locationString, result.address);
                NSLog(@"%@", result.address);
    }else{
//                self.location.text = @"找不到相对应的位置";
        NSLog(@"%@", @"找不到相对应的位置");
    }
}
#pragma mark --BMKPoiSearchDelegate
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (errorCode == BMK_SEARCH_NO_ERROR)
    {
        for (int i = 0; i < poiResult.poiInfoList.count; i++)
        {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            NSLog(@"搜索结果：%@",poi.address);
            //BMKPoiInfo就是检索出来的poi信息
        }
    }
    
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

@end
