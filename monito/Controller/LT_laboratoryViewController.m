//
//  LT_laboratoryViewController.m
//  monito
//  实验室
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_laboratoryViewController.h"
#import "PrefixHeader.pch"
@interface LT_laboratoryViewController ()<UIScrollViewDelegate>{
    nativeScrollView * scrollVi;
    NSArray * Btnarr;
    NSMutableArray * sourceAy;
}

@end

@implementation LT_laboratoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDataSource];
    [self creatUI];
}
-(void)creatDataSource{
    sourceAy = [[NSMutableArray alloc]init];
    [self requestWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
    [self requestWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
}
-(void)creatUI{
    NSArray *BtnAy =@[@"校核",@"审核"];
    self.BtnView = [[navBottomBtnView alloc]init];
    self.BtnView.frame = CGRectMakeRelative(0, 0, 375, 50);
    [self.BtnView creatButton:BtnAy];
   
    UIView * pgView = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 50, 375, 3)];
    pgView.tag = 1;
    for (int i = 0; i<BtnAy.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        if (i==0) {
            [btn setBackgroundColor:[UIColor redColor]];
        }
        [pgView addSubview:btn];
        if (BtnAy.count<5) {
            btn.frame = CGRectMakeRelative(0+375.0/BtnAy.count*i, 0, 375.0/BtnAy.count, 3 );
        }else{
            btn.frame = CGRectMakeRelative(0+75*i, 0, 75, 3);
        }
        if (i==0) {
            btn.selected = YES;
        }
    }
    
    scrollVi  = [[nativeScrollView alloc]init];
    scrollVi.delegate = self;
    [scrollVi creatSearchView:@[@"校核",@"审核"]];
    
    scrollVi.frame = CGRectMakeRelative(0, 50, 375, 617);
    scrollVi.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    
    [self.view addSubview:self.BtnView];
    [self.view addSubview:scrollVi];
    [self.view addSubview:pgView];
    [self addClik];
}
//添加点击事件
-(void)addClik{
    Btnarr = [[NSArray alloc]initWithArray:self.BtnView.subviews];
    for (int i = 0; i < Btnarr.count; i++) {
        [Btnarr[i] addTarget:self action:@selector(clik:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//点击事件
-(void)clik:(UIButton *)btn{
    UIView * vi= [self.view viewWithTag:1];
    for (int i = 0; i < vi.subviews.count; i++) {
        if (vi.subviews[i].frame.origin.x == btn.frame.origin.x) {
            vi.subviews[i].backgroundColor = [UIColor redColor];
        }else{
            vi.subviews[i].backgroundColor = [UIColor whiteColor];
        }
    }
    
    scrollVi.contentOffset = CGPointMake(btn.frame.origin.x/btn.frame.size.width*self.view.frame.size.width, 0);
   
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
}

-(void)requestWithURL:(NSString *)url{
    loginSource * loginS = [loginSource sharedInstance];
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"SYS_XMJD" forKey:@"linkcode"];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:loginS.password forKey:@"password"];
    [dic1 setObject:loginS.userName forKey:@"username"];
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"monitor_unit_name"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|%@",obj[@"task_code"],obj[@"lever"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"envi_type"],obj[@"monitor_name"],obj[@"entity_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"scene_start_time"]];
            [cellAy addObject:data];
        }
        [sourceAy addObject:cellAy];
        [scrollVi creatMTabViewListSource:sourceAy];
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
    
}
CG_INLINE CGRect
CGRectMakeRelative(CGFloat x,CGFloat y,CGFloat width,CGFloat height)
{
    //创建appDelegate 在这不会产生类的对象,(不存在引起循环引用的问题)
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    
    //计算返回
    return CGRectMake(x * app.autoSizeScaleX, y * app.autoSizeScaleY, width * app.autoSizeScaleX, height * app.autoSizeScaleY);
}
//滚动协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // called when scroll view grinds to a halt
    UIView * vi= [self.view viewWithTag:1];
    NSArray * btn = [self.BtnView subviews];
    for (int i = 0; i < vi.subviews.count; i++) {
        NSLog(@"btn%f-scroll%f",vi.subviews[i].frame.origin.x/vi.subviews[i].frame.size.width,scrollView.contentOffset.x/scrollView.frame.size.width);
        if ((vi.subviews[i].frame.origin.x/vi.subviews[i].frame.size.width) == (scrollView.contentOffset.x/scrollView.frame.size.width)) {
            vi.subviews[i].backgroundColor = [UIColor redColor];
            for (int j=0; j<btn.count; j++) {
                if (j==i) {
                    [btn[j] setValue:@"YES" forKey:@"selected"];
                }else{
                    [btn[j] setValue:@"NO" forKey:@"selected"];
                }
                
                
            }
        }else{
            vi.subviews[i].backgroundColor = [UIColor whiteColor];
        }
    }
    NSLog(@"已经减速结束时调用");
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
