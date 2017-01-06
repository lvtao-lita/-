//
//  LT_positionViewController.m
//  monito
//  GPS定位
//  Created by lvtao on 16/11/25.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_positionViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

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
    
    _locService = [[BMKLocationService alloc]init];
    _poisearch = [[BMKPoiSearch alloc]init];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _poisearch.delegate = self;
    [self setUI];
    [self MobileCarrier];
    [self Position];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
}
-(void)MobileCarrier{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
        
    self.GPSoperators.text = [NSString stringWithFormat:@"运营商：%@", [carrier carrierName]];
    NSLog(@"%@",self.GPSoperators.text);
    
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
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
    self.name.text = self.Nmonitor_unit_name;
}
-(void)setTextfiled:(UITextField *)tf andName:(NSString *)string{
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 35)];
    lab.text =string;
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = lab;
}
//定位
-(void)Position{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];

}
- (void)outputAdd
{
    // 初始化反地址编码选项（数据模型）
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    // 将数据传到反地址编码模型
    option.reverseGeoPoint = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    NSLog(@"%f - %f", option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    // 调用反地址编码方法，让其在代理方法中输出
    [self.geoCode reverseGeoCode:option];
}

//保存搜索定位
- (IBAction)saveSeacrhPosition:(UIButton *)sender {
    

}
//地址搜索
- (IBAction)SearchAdress:(UIButton *)sender {
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageCapacity = 10;
    citySearchOption.city=self.cityName.text;;
    citySearchOption.keyword = self.keyword.text;
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
/** 经纬度转换成度分秒格式 */
- (NSString *)stringWithCoordinateString:(NSString *)coordinateString
{
    /** 将经度或纬度整数部分提取出来 */
    int latNumber = [coordinateString intValue];
    
    /** 取出小数点后面两位(为转化成'分'做准备) */
    NSArray *array = [coordinateString componentsSeparatedByString:@"."];
    /** 小数点后面部分 */
    NSString *lastCompnetString = [array lastObject];
    
    /** 拼接字字符串(将字符串转化为0.xxxx形式) */
    NSString *str1 = [NSString stringWithFormat:@"0.%@", lastCompnetString];
    
    /** 将字符串转换成float类型以便计算 */
    float minuteNum = [str1 floatValue];
    
    /** 将小数点后数字转化为'分'(minuteNum * 60) */
    float minuteNum1 = minuteNum * 60;
    
    /** 将转化后的float类型转化为字符串类型 */
    NSString *latStr = [NSString stringWithFormat:@"%f", minuteNum1];
    
    /** 取整数部分即为纬度或经度'分' */
    int latMinute = [latStr intValue];
    
    /** 将经度或纬度字符串合并为(xx°xx')形式 */
    NSString *string = [NSString stringWithFormat:@"%d°%d'", latNumber, latMinute];
    
    return string;
}

//保存GPS定位
- (IBAction)saveGPSAdress:(UIButton *)sender {
   
}
// 路径规划 调用百度地图APP
- (IBAction)pathPlanning:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
        NSString*urlString=[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地  &mode=driving&coord_type=gcj02",self.latitude,self.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
       
    }else{
        NSString*urlString=[[NSString stringWithFormat:@"http://maps.apple.com/?daddr=%f,%f&saddr=slat,slng",self.latitude,self.longitude]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
    
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
    NSString * lat = [NSString stringWithFormat:@"%f",self.latitude];
    NSString * lon = [NSString stringWithFormat:@"%f",self.longitude];
    self.GPSLat.text = [NSString stringWithFormat:@"纬度：%@(%@)",[self stringWithCoordinateString:lat],lat];
    self.GPSLog.text =  [NSString stringWithFormat:@"经度：%@(%@)",[self stringWithCoordinateString:lon],lon];
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
    [self outputAdd];
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
        NSLog(@"位置结果是：%@%@", result.address, result.addressDetail.city);
        NSDate * nowDate = [NSDate date];
        NSDateFormatter * dateFomatter = [[NSDateFormatter alloc] init];
        dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        self.GPSTime.text = [NSString stringWithFormat:@"时间：%@",[dateFomatter stringFromDate:nowDate] ];
        
        self.GPSadress.text = [NSString stringWithFormat:@"地址：%@",result.address];
        
        self.GPSdescribe.text = @"描述：网络定位成功";
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
