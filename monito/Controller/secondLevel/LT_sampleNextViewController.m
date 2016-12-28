//
//  LT_sampleNextViewController.m
//  monito
//  采样信息下一页
//  Created by lvtao on 16/11/24.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_sampleNextViewController.h"
#import "AppDelegate.h"
#import "LT_positionViewController.h"
#import "LT_oneWebViewController.h"
#import "NetworkRequests.h"
@interface LT_sampleNextViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController * PickerCon;
}

@end

@implementation LT_sampleNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.OPView.flowBtn.tag =1;
    self.OPView.sendBtn.tag =2;
    self.OPView.transmitBtn.tag =3;
    [self.OPView setButton:self.OPView.transmitBtn WithTittle:@"转办" AndImage:@"backlog"];
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%lu",[self.scrollView subviews].count);
}

-(void)creatrightBarButtonItem{
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"定位" style:UIBarButtonItemStyleDone target:self action:@selector(location:)];
    UIBarButtonItem * rightBtn2 = [[UIBarButtonItem alloc]initWithTitle:@"拍照" style:UIBarButtonItemStyleDone target:self action:@selector(photograph:)];
    NSArray * arr = @[rightBtn2,rightBtn1];
    self.navigationItem.rightBarButtonItems = arr;
}
#pragma mark - 重写点击事件
-(void)clickButton:(UIButton *)btn{
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc]init];
    [parameter setObject:@"Edit" forKey:@"CMD"];
    [parameter setObject:self.parameter[@"EntityName"] forKey:@"EntityName"];
    [parameter setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsID"];
    [parameter setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
    [parameter setObject:self.parameter[@"sessionid"] forKey:@"SessionId"];
    [parameter setObject:self.parameter[@"TaskSceneId"] forKey:@"TaskSceneId"];
    [parameter setObject:self.parameter[@"UserId"] forKey:@"UserId"];
    [parameter setObject:self.parameter[@"business_id"] forKey:@"business_id"];
    if ([btn.titleLabel.text isEqualToString:@"基本"]) {
        [self requstWebviewWithName:0 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/Sample/SampleFarm.aspx"];
        
    }else if ([btn.titleLabel.text isEqualToString:@"现场"]){
        [self requstWebviewWithName:1 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/Sample/SampleFarmComm.aspx"];
    }else if ([btn.titleLabel.text isEqualToString:@"工况"]){
        [self requstWebviewWithName:2 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/Sample/Condition.aspx"];
    
    }else if ([btn.titleLabel.text isEqualToString:@"绘图"]){
        [self requstWebviewWithName:3 andParameter:parameter andURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/Sample/SampleFile/SampleFile.aspx"];
    }
}
-(void)operate:(UIButton *)btn{
    NSDictionary * parameterDic = [[NSDictionary alloc]init];
    LT_oneWebViewController * oneWebCon = [[LT_oneWebViewController alloc]init];
    if (btn.tag == 1) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.parameter[@"sessionid"] forKey:@"SessionId"];
        [dic setObject:self.parameter[@"business_id"] forKey:@"BusinessId"];
        [dic setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [dic setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [dic setObject:self.parameter[@"link_ins_id"] forKey:@"link_ins_id"];
        parameterDic = dic;
        oneWebCon.url = @"http://120.24.7.178/fshb/Manager/MobileSvc/WorkFlow/FlowLogMon.aspx";
        NSLog(@"流程");
    }else if (btn.tag ==2){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.parameter[@"sessionid"] forKey:@"SessionId"];
        [dic setObject:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [dic setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [dic setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [dic setObject:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [dic setObject:self.parameter[@"UserId"] forKey:@"UserId"];
        NSLog(@"发送");
        parameterDic = dic;
        oneWebCon.url = @"http://120.24.7.178/fshb/Manager/MobileSvc/WorkFlow/NewVersion/TaskSubmit.aspx";
    }else if (btn.tag ==3){
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:self.parameter[@"sessionid"] forKey:@"SessionId"];
        [dic setObject:self.parameter[@"UserCName"] forKey:@"UserCName"];
        [dic setObject:self.parameter[@"FlowInsId"] forKey:@"FlowInsId"];
        [dic setObject:self.parameter[@"LinkInsId"] forKey:@"LinkInsId"];
        [dic setObject:self.parameter[@"UserCode"] forKey:@"UserCode"];
        [dic setObject:self.parameter[@"UserId"] forKey:@"UserId"];
        NSLog(@"转办");
        parameterDic = dic;
        oneWebCon.url = @"http://120.24.7.178/fshb/Manager/MobileSvc/WorkFlow/NewVersion/TaskSpanBack.aspx";
    }
    
    oneWebCon.parameter = parameterDic;
    [self.navigationController pushViewController:oneWebCon animated:YES];
    
}
-(void)requstWebviewWithName:(int)name
                andParameter:(NSDictionary *)parameter
                      andURL:(NSString *)url{
    NSArray * webView = [self.scrollView subviews];
    [NetworkRequests requestWebWithparameters:parameter andWithURL:url Success:^(NSString *str) {
        UIWebView * temp = webView[name];
        [temp loadHTMLString:str baseURL:nil];
        
    } failure:^(NSDictionary *dic) {
        
    }];
}

-(void)location:(UIButton *)btn{
    LT_positionViewController * position = [[LT_positionViewController alloc]init];
    [self.navigationController pushViewController:position animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}

-(void)photograph:(UIButton *)btn{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [self openIamgePicKer:UIImagePickerControllerSourceTypeCamera];
    }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        [self openIamgePicKer:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
}
#pragma mark 在协议中打开
-(void)openIamgePicKer:(UIImagePickerControllerSourceType)type{
    //将打开相册相机的视图控制器初始化
    PickerCon = [[UIImagePickerController alloc]init];
    // 设置打开的是相机还是相册
    PickerCon.sourceType = type;
    
    PickerCon.delegate = self;
    
    //将用户的 信息 模态的方式弹出
    [self presentViewController:PickerCon animated:YES completion:nil];
    
}
//选择某个文件是，被调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * selectIamge = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"获得照片");
    NSData *imageData = UIImageJPEGRepresentation(selectIamge,0.1);
    //图片试图控制器消失
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
