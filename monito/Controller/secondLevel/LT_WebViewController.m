//
//  LT_WebViewController.m
//  monito
//  网页加载控制器
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_WebViewController.h"
#import "PrefixHeader.pch"
@interface LT_WebViewController ()<UIScrollViewDelegate>{
    UIScrollView * scrollView;
    navBottomBtnView * view;
    NSArray * Btnarr;
}

@end

@implementation LT_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatScrollView:self.BtnAy];
    [self creatBtn:self.BtnAy];
    [self creatWeb:self.BtnAy];
    [self addClik];
   
}
-(void)creatrightBarButtonItem{
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"二维码" style:UIBarButtonItemStyleDone target:self action:@selector(QRcode:)];
    self.navigationItem.rightBarButtonItem = rightBtn1;
}
-(void)creatloadItem{
    UIView * rightview = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 0, 44, 44)];
    UIButton * loadWeb = [[UIButton alloc]init];
    loadWeb.frame =CGRectMakeRelative(0, 0, 44, 44);
    loadWeb.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [loadWeb setImage:[UIImage imageNamed:@"load.png"] forState:UIControlStateNormal];
    [loadWeb addTarget:self action:@selector(loadWeb) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:loadWeb];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem = rightBtn;
}
-(void)loadWeb{
    NSLog(@"点击查询");
}
-(void)QRcode:(UIButton *)btn{
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        SGScanningQRCodeVC *VC = [[SGScanningQRCodeVC alloc] init];
        VC.block = ^(NSString * string){
            NSLog(@"扫描结果%@",string);
        };
        [self.navigationController pushViewController:VC animated:YES];
        
    } else {
        
        SGAlertView *alertView = [SGAlertView alertViewWithTitle:@"⚠️ 警告" delegate:nil contentTitle:@"未检测到您的摄像头, 请在真机上测试" alertViewBottomViewType:(SGAlertViewBottomViewTypeOne)];
        [alertView show];
    }
    
}
-(void)creatBtn:(NSArray *)arr{
    if (arr.count > 1) {
        view = [[navBottomBtnView alloc]init];
        if (arr.count >5) {
            view.frame =CGRectMakeRelative(0, 0,arr.count*75, 60 );
        }else{
            view.frame = CGRectMakeRelative(0, 0, 375, 50);
        }
        [view creatButton:arr];
        [self.view addSubview:view];
        UIView * pgView = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 50, 375, 3)];
        pgView.tag = 10;
        [self.view addSubview:pgView];
        for (int i = 0; i<arr.count; i++) {
            UIButton * btn = [[UIButton alloc]init];
            if (i==0) {
                [btn setBackgroundColor:[UIColor redColor]];
            }
            [pgView addSubview:btn];
            if (arr.count<5) {
                btn.frame = CGRectMakeRelative(0+375.0/arr.count*i, 0, 375.0/arr.count, 3 );
            }else{
                btn.frame = CGRectMakeRelative(0+75*i, 0, 75, 3);
            }
            if (i==0) {
                btn.selected = YES;
            }
        }
    }
    
    
}
-(void)creatScrollView:(NSArray *)arr{
    scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    if (arr.count > 1) {
        scrollView.frame = CGRectMakeRelative(0, 50, 375, 553);
        scrollView.contentSize = CGSizeMake(375*arr.count, 553);
    }else{
        scrollView.frame = CGRectMakeRelative(0, 0, 375, 603);
        scrollView.contentSize = CGSizeMake(375*arr.count, 603);
    }
    
    [self.view addSubview:scrollView];
    
}
-(void)creatWeb:(NSArray *)arr{
    if (arr.count > 1) {
        for (int i = 0; i < arr.count; i++) {
            UIWebView * WebView = [[UIWebView alloc]init];
            WebView.tag = i+1;
            WebView.frame =CGRectMakeRelative(0+375*i, 0, 375, 553);
            [self loadWeb:WebView andUrl:self.URLAy];
            [scrollView addSubview:WebView];
        }
    }else{
        UIWebView * WebView = [[UIWebView alloc]init];
        WebView.tag = 1;
        WebView.frame =CGRectMakeRelative(0, 0, 375, 603);
        [self loadWeb:WebView andUrl:self.URLAy];
        [scrollView addSubview:WebView];
    }
}
-(void)loadWeb:(UIWebView *)WebView andUrl:(NSString *)url{
    NSURL * Url = [NSURL URLWithString:url];
    NSURLRequest * requst = [NSURLRequest requestWithURL:Url];
    [WebView loadRequest:requst];
}
-(void)addClik{
    Btnarr = [[NSArray alloc]initWithArray:view.subviews];
    for (int i = 0; i < Btnarr.count; i++) {
        [Btnarr[i] addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//点击事件
-(void)clik:(UIButton *)btn{
    NSLog(@"点击事件 %@",btn.titleLabel.text);
    UIView * vi= [self.view viewWithTag:10];
    for (int i = 0; i < vi.subviews.count; i++) {
        if (vi.subviews[i].frame.origin.x == btn.frame.origin.x) {
            vi.subviews[i].backgroundColor = [UIColor redColor];
        }else{
            vi.subviews[i].backgroundColor = [UIColor whiteColor];
        }
    }

    scrollView.contentOffset = CGPointMake(btn.frame.origin.x/btn.frame.size.width*self.view.frame.size.width, 0);
    
    if (btn.selected == YES) {
        
    }else{
        for (int i = 0; i < Btnarr.count; i++) {
            if (btn != Btnarr[i]) {
                [Btnarr[i] setValue:@"NO" forKey:@"selected"];
                [Btnarr[i] setValue:@"YES" forKey:@"enabled"];
            }
        }
        btn.selected = YES;
        
    }
    //btn  超过5个
    if ((Btnarr.count > 5)&&(btn.frame.origin.x<=btn.frame.size.width*2)) {
        view.frame = CGRectMakeRelative(0, 0, 375, 50);
        vi.frame = CGRectMakeRelative(0, 50, 375, 3);
    }
    if ((Btnarr.count > 5)&&(btn.frame.origin.x>=btn.frame.size.width*3)) {
        view.frame = CGRectMakeRelative(-btn.frame.size.width, 0, self.BtnAy.count*75, 50);
        vi.frame = CGRectMakeRelative(-btn.frame.size.width, 50, self.BtnAy.count*75, 3);
    }
}

//滚动协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // called when scroll view grinds to a halt
    UIView * vi= [self.view viewWithTag:10];
    for (int i = 0; i < vi.subviews.count; i++) {
        if ((vi.subviews[i].frame.origin.x/vi.subviews[i].frame.size.width) == (scrollView.contentOffset.x/scrollView.frame.size.width)) {
            vi.subviews[i].backgroundColor = [UIColor redColor];
        }else{
            vi.subviews[i].backgroundColor = [UIColor whiteColor];
        }
    }
    NSLog(@"已经减速结束时调用");
}

CG_INLINE CGRect
CGRectMakeRelative(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    //创建appDelegate 在这不会产生类的对象,(不存在引起循环引用的问题)
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    
    //计算返回
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
