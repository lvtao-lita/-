/**
 * @class LT_HomeViewController.h
 * @brief 首页
 * @author lvtao
 * @date 2016-11-21
 **/
#define With self.view.frame.size.width

#import "LT_HomeViewController.h"
#import "PrefixHeader.pch"
#import "AppDelegate.h"
#import "loginSource.h"
#import "loginRecord.h"
#import "NetworkRequests.h"
@interface LT_HomeViewController (){
    LT_HomeWeb * HomeWeb;
    LT_HomeCollection* collection;
    NSMutableArray * tittleAy;
    NSMutableArray * imageAy;
}
@end

@implementation LT_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSource];
    [self creatUI];
    [self loadWeb];
}
-(void)creatSource{
    loginSource * loginS =[loginSource sharedInstance];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSData * data = [user objectForKey:@"loginRecord"];
//    loginR = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSDictionary * dic = @{@"password":[NSString stringWithFormat:@"%@",loginS.password],@"username":[NSString stringWithFormat:@"%@",loginS.userName]};
    [NetworkRequests requestWithparameters:dic andWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/LoginSvc.asmx/getAppModule" Success:^(NSDictionary *dic) {
        NSLog(@"首页列表:%@",dic);
        tittleAy = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in dic[@"obj"]) {
            [tittleAy addObject:obj[@"M_CName"]];
        }
        [collection datasourcetittle:tittleAy andimge:nil];
        [collection reloadData];
    } failure:^(NSDictionary *dic) {
        NSLog(@"失败:%@",dic);
    }];
}
-(void)creatUI{
    self.title = @"环境监测系统";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes =@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    UIView * rightview = [[UIView alloc]initWithFrame:CGRectMakeRelative(0, 0, 44, 44)];
    UIButton * loadWeb = [[UIButton alloc]init];
    loadWeb.frame =CGRectMakeRelative(0, 0, 44, 44);
    loadWeb.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [loadWeb setImage:[UIImage imageNamed:@"load.png"] forState:UIControlStateNormal];
    [loadWeb addTarget:self action:@selector(loadWeb) forControlEvents:UIControlEventTouchUpInside];
    [rightview addSubview:loadWeb];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightview];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    HomeWeb = [[LT_HomeWeb alloc]init];
    
    HomeWeb.frame = CGRectMakeRelative(0, 0, 375, 220);
    
    collection = [[LT_HomeCollection alloc]init];
    [collection datasourcetittle:tittleAy andimge:nil];
    collection.frame = CGRectMakeRelative(0, 223, 375, 444);
    [self.view addSubview:HomeWeb];
    [self.view addSubview:collection];
    
}


-(void)loadWeb{
    loginSource * log = [loginSource sharedInstance];
    NSString * name = log.obj[@"U_LoginName"];
    NSString *url = [NSString stringWithFormat:@"http://120.24.7.178/fshb/Manager/MobileSvc/SceneAnalysis.aspx?UserName=%@",name];
    [HomeWeb loadHomeWev:url];
}


//创建内联函数 (在程序编译的时候执行,在函数前声明后编译器执行起来更具效率，使宏的定义更节省，不涉及栈的操作)
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
