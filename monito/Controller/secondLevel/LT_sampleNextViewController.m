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
@interface LT_sampleNextViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImagePickerController * PickerCon;
}

@end

@implementation LT_sampleNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)creatrightBarButtonItem{
    UIBarButtonItem * rightBtn1 = [[UIBarButtonItem alloc]initWithTitle:@"定位" style:UIBarButtonItemStyleDone target:self action:@selector(location:)];
    UIBarButtonItem * rightBtn2 = [[UIBarButtonItem alloc]initWithTitle:@"拍照" style:UIBarButtonItemStyleDone target:self action:@selector(photograph:)];
    NSArray * arr = @[rightBtn2,rightBtn1];
    self.navigationItem.rightBarButtonItems = arr;
}

-(void)location:(UIButton *)btn{
    NSLog(@"location");
    LT_positionViewController * position = [[LT_positionViewController alloc]init];
    [self.navigationController pushViewController:position animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}

-(void)photograph:(UIButton *)btn{
    NSLog(@"pai zhao");
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
