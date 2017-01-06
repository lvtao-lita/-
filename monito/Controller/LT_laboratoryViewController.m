//
//  LT_laboratoryViewController.m
//  monito
//  实验室
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_laboratoryViewController.h"
#import "mytableView.h"
#import "searchView.h"
#import "PrefixHeader.pch"
@interface LT_laboratoryViewController ()<UIScrollViewDelegate,UITableViewDelegate>{
    NSMutableDictionary * dic1;
    nativeScrollView * scrollVi;
    NSArray * Btnarr;
    NSMutableArray * sourceAy;
    NSMutableArray * pamaraterAy;
    int num;
}

@end

@implementation LT_laboratoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatDataSource];
    [self creatUI];
    [self addSearchClick];
}
-(void)creatDataSource{
    num = 0;
    pamaraterAy = [[NSMutableArray alloc]init];
    sourceAy = [[NSMutableArray alloc]init];
    loginSource * loginS = [loginSource sharedInstance];
    dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"SYS_XMJD" forKey:@"linkcode"];
    [dic1 setObject:@"" forKey:@"keyword"];
    [dic1 setObject:loginS.password forKey:@"password"];
    [dic1 setObject:loginS.userName forKey:@"username"];
    [self requestWithURL:@"/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
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
    [sourceAy addObject:@[]];
    [sourceAy addObject:@[]];
    //创建表格
    [scrollVi creatMTabViewListSource:sourceAy];
    NSArray * scrollViSubAy = [scrollVi subviews];
    for (id obj in scrollViSubAy) {
        if ([obj isKindOfClass:[UITableView class]]) {
            mytableView * temp =obj;
            temp.delegate = self;
        }
    }
}

//搜索点击事件添加
-(void)addSearchClick{
    NSArray * subViewAy = [scrollVi subviews];
    for (id obj in subViewAy) {
        if ([obj isKindOfClass:[searchView class]]) {
            searchView * temp = obj;
            [temp.btn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
-(void)searchClick{
    NSArray * subViewAy = [scrollVi subviews];
    for (id obj in subViewAy) {
        if ([obj isKindOfClass:[searchView class]]) {
            searchView * temp = obj;
            if (num == 0) {
                if (temp.searchTextField.text ==nil) {
                    [dic1 setObject:@"" forKey:@"keyword"];
                }else{
                    [dic1 setObject:temp.searchTextField.text forKey:@"keyword"];
                    break;
                }
            }else{
                if (temp.searchTextField.text ==nil) {
                    [dic1 setObject:@"" forKey:@"keyword"];
                }else{
                    [dic1 setObject:temp.searchTextField.text forKey:@"keyword"];
                }
            }
            
            
        }
    }
    if (num ==0) {
        [self requestWithURL:@"/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
        NSLog(@"校核搜索");
    }else if (num ==1){
        [self requestWithURL:@"/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
        NSLog(@"审核搜索");
    }
    
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
    [self requst:btn];
}
-(void)requst:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"校核"]) {
        num = 0;
        [self requestWithURL:@"/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
    }
    if ([btn.titleLabel.text isEqualToString:@"审核"]) {
        num = 1;
        [self requestWithURL:@"/Manager/MobileSvc/AnalyseCheckSvc.asmx/checkList"];
    }
}
-(void)requestWithURL:(NSString *)url{
    
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        [pamaraterAy removeAllObjects];
        loginSource * loginS = [loginSource sharedInstance];
        for (NSDictionary *obj in dic[@"obj"]) {
            NSMutableDictionary * parameterDic = [[NSMutableDictionary alloc]init];
            
            [parameterDic setValue:obj[	@"flow_code"] forKey:@"flowcode"];
            [parameterDic setValue:obj[@"link_def_id" ] forKey:@"linkdefid"];
            [parameterDic setValue:@"submit,back,zb" forKey:@"operationcode"];
            [parameterDic setValue:loginS.password forKey:@"password"];
            [parameterDic setValue:loginS.userName forKey:@"username"];
            [parameterDic setValue:obj[@"session_id"] forKey:@"sessionid"];
            [parameterDic setValue:obj[@"task_scene_id"] forKey:@"SessionId"];
            [parameterDic setValue:@"" forKey:@"TempId"];
            [parameterDic setValue:@"" forKey:@"UserCName"];
            [parameterDic setValue:@"" forKey:@"UserCode"];
            [parameterDic setValue:loginS.obj[@"UserID"] forKey:@"UserId"];
            [parameterDic setValue:obj[@"flow_ins_id"] forKey:@"FlowInsID"];
            [parameterDic setValue:obj[@"link_ins_id"] forKey:@"LinkInsId"];
            [parameterDic setValue:obj[@"business_id"] forKey:@"businessId"];
            [parameterDic setValue:obj[@"entity_name"] forKey:@"entity_name"];
            [parameterDic setValue:@"SYS_XMJD" forKey:@"link_code"];
            [parameterDic setValue:obj[@"task_id"] forKey:@"taskId"];
            
            [pamaraterAy addObject:parameterDic];
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"monitor_unit_name"]];
            data.bottomTxet = [NSString stringWithFormat:@"%@|%@",obj[@"task_code"],obj[@"lever"]];
            data.centerTxet = [NSString stringWithFormat:@"%@|%@|%@",obj[@"envi_type"],obj[@"monitor_name"],obj[@"entity_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"scene_start_time"]];
            [cellAy addObject:data];
        }
        [sourceAy setObject:cellAy atIndexedSubscript:num];
        
        [scrollVi reloadWtihSource:sourceAy];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 90*app.autoSizeScaleY;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"跳转");
    LT_WebViewController *next = [[LT_WebViewController alloc]init];
    next.parameter = pamaraterAy[indexPath.row];
    NSArray * subAy = self.BtnView.subviews;
    for (UIButton * obj in subAy) {
        if (obj.selected == YES) {
            next.title = obj.titleLabel.text;
        }
    }
    next.BtnAy = @[@"详细信息",@"流程操作"];
    next.flag = num;
    [self.navigationController pushViewController:next animated:YES];
    
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
