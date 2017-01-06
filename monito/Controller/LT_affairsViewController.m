//
//  LT_affairsViewController.m
//  monito
//  政务信息
//  Created by lvtao on 16/11/22.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_affairsViewController.h"
#import "affairsTableView.h"
#import "PrefixHeader.pch"
@interface LT_affairsViewController ()<UIScrollViewDelegate,UITableViewDelegate>{
    navBottomBtnView * view;
    nativeScrollView * scrollVi;
    NSArray * Btnarr;
    NSMutableArray * sourceAy;
    int num;
}

@end

@implementation LT_affairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    num = 0;
    [self creatDataSource];
    [self creatUI];
    
}
-(void)creatDataSource{
    sourceAy = [[NSMutableArray alloc]init];
    [sourceAy addObject:@[]];
    [sourceAy addObject:@[]];
    [sourceAy addObject:@[]];
    [self requestWithURL:@"/Manager/MobileSvc/OADocTaskSvc.asmx/list"];
}
-(void)creatUI{
    NSArray *BtnAy =@[@"发文",@"收文",@"查询"];
    view = [[navBottomBtnView alloc]init];
    view.frame = CGRectMakeRelative(0, 0, 375, 50);
    [view creatButton:@[@"发文",@"收文",@"查询"]];
    
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
    [scrollVi creatSearchView:@[@"发文",@"收文",@"查询"]];
    scrollVi.frame = CGRectMakeRelative(0, 50, 375, 617);
    scrollVi.backgroundColor = [UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1];
    
    [self.view addSubview:view];
    [self.view addSubview:scrollVi];
    [self.view addSubview:pgView];
    [self addClik];
    [scrollVi creatTabViewListSource:sourceAy];
    NSArray * subViews =[scrollVi subviews];
    for (id obj in subViews) {
        if ([obj isKindOfClass:[UITableView class]]) {
            affairsTableView * temp = obj;
            temp.delegate = self;
        }
    }
}
#pragma mark - 点击事件
//添加点击事件
-(void)addClik{
    Btnarr = [[NSArray alloc]initWithArray:view.subviews];
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
    if ([btn.titleLabel.text isEqualToString:@"发文"]) {
        num = 0;
        [self requestWithURL:@"/Manager/MobileSvc/OADocTaskSvc.asmx/list"];
    }
    if ([btn.titleLabel.text isEqualToString:@"收文"]) {
        num = 1;
        [self requestWithURL:@"/Manager/MobileSvc/OADocTaskSvc.asmx/list"];
    }
    if ([btn.titleLabel.text isEqualToString:@"查询"]) {
        num = 2;
        [self requestWithURL:@"/Manager/MobileSvc/OADocTaskSvc.asmx/list"];
    }
}

-(void)requestWithURL:(NSString *)url{
    loginSource * loginS = [loginSource sharedInstance];
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]init];
    [dic1 setObject:@"1=1 and type_name='发文' and user_code='admin'" forKey:@"filter"];
    [dic1 setObject:@"10" forKey:@"limit"];
    [dic1 setObject:loginS.password forKey:@"password"];
    [dic1 setObject:loginS.userName forKey:@"username"];
    [dic1 setObject:@"1" forKey:@"start"];
    NSMutableArray * cellAy = [[NSMutableArray alloc]init];
    [NetworkRequests requestWithparameters:dic1 andWithURL:url Success:^(NSDictionary *dic) {
        for (NSDictionary *obj in dic[@"obj"]) {
            dateSource * data = [[dateSource alloc]init];
            data.companyName = [NSString stringWithFormat:@"%@",obj[@"doc_title"]];
            data.centerTxet = [NSString stringWithFormat:@"%@(%@)",obj[@"link_name"],obj[@"started_user_name"]];
            data.dateText = [NSString stringWithFormat:@"%@",obj[@"started_time"]];
            [cellAy addObject:data];
        }
        [sourceAy setObject:cellAy atIndexedSubscript:num];
        [scrollVi reloadWtihSource:sourceAy];
        
    } failure:^(NSDictionary *dic) {
        NSLog(@"shishisshs");
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate * app = (id)[UIApplication sharedApplication].delegate;
    return 60*app.autoSizeScaleY;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LT_WebViewController * next = [[LT_WebViewController alloc]init];
    next.BtnAy = @[@"公文信息",@"附件信息"];
    [self.navigationController pushViewController:next animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
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
    NSArray * btn = [view subviews];
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
