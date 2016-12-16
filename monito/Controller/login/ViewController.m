/**
*@brief 用户登录
**/

#import "ViewController.h"
#import "PrefixHeader.pch"
#import "NetworkRequests.h"
#import "loginRecord.h"
#import "NSString+subAppend.h"
#import "loginSource.h"
@interface ViewController (){
    NSString * pswStr;
    
}
///@brief 用户名输入
@property (weak, nonatomic) IBOutlet UITextField *userName;
///@brief 密码输入
@property (weak, nonatomic) IBOutlet UITextField *pastword;
///@brief 外网IP
@property (weak, nonatomic) IBOutlet UITextField *outIP;
///@brief 内网IP
@property (weak, nonatomic) IBOutlet UITextField *intIP;
//记住选项
@property (weak, nonatomic) IBOutlet UIButton *outIPBtn;
@property (weak, nonatomic) IBOutlet UIButton *passtwordBtn;
@property (weak, nonatomic) IBOutlet UIButton *InputBtn;
@property (strong,nonatomic) loginRecord * login;






@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.passtwordBtn setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
    [self.outIPBtn setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
    [self.InputBtn setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSData * data = [user objectForKey:@"loginRecord"];
    _login = [loginRecord sharedInstance];
    _login = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (_login.passflag == YES) {
        self.userName.text = _login.userName;
        self.pastword.text = _login.password;
        self.passtwordBtn.selected = _login.passflag;
    }
    if (_login.OUTIPflag == YES) {
        self.outIP.text    = _login.OUTIP;
        self.outIPBtn.selected = _login.OUTIPflag;
    }
    if (_login.INPIPflag == YES) {
        self.intIP.text    = _login.INTIP;
    }

    self.InputBtn.selected    = _login.INPIPflag;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 记住密码
- (IBAction)rememberPasstword:(UIButton *)sender {
    if ( self.passtwordBtn.selected == NO) {
        self.passtwordBtn.selected= YES;
//        login.passflag = YES;
        
    }else{
        self.passtwordBtn.selected= NO;
//        login.passflag = NO;
    }
}
#pragma mark - 记住外网IP
- (IBAction)rememberOutIP:(UIButton *)sender {
    if ( self.outIPBtn.selected == NO) {
        self.outIPBtn.selected= YES;
        
    }else{
        self.outIPBtn.selected= NO;
        
    }
    
}
#pragma mark - 记住内网IP
- (IBAction)rememberInputIP:(UIButton *)sender {
    if ( self.InputBtn.selected == NO) {
        self.InputBtn.selected= YES;
        
    }else{
        self.InputBtn.selected= NO;
        
    }
    
}
#pragma mark - 登录
- (IBAction)logIn:(UIButton *)sender {
    //密码记录
    _login.userName = self.userName.text;
    _login.password = self.pastword.text;
    _login.OUTIP = self.outIP.text;
    _login.INTIP = self.intIP.text;
    if ( self.passtwordBtn.selected == YES) {
  
        
        _login.passflag = YES;
        
    }else{
        _login.passflag = NO;
    }
    if ( self.outIPBtn.selected == YES) {
        _login.OUTIPflag =YES;
    }else{
        _login.OUTIPflag =NO;
    }
    if ( self.InputBtn.selected == YES) {
        
        _login.INPIPflag = YES;
    }else{
        _login.INPIPflag = NO;
    }
    
    
    
    //登录操作
    NSDictionary * dic = @{@"psw":@"tingting",@"estr":[NSString stringWithFormat:@"%@",self.pastword.text]};
    pswStr = [[NSString alloc]init];
    loginSource * logSource = [loginSource sharedInstance];
    [NetworkRequests requesPasswordtWithparameters:dic andWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/LoginSvc.asmx/getTestPsw" Success:^(NSString *password) {
        NSLog(@"%@",password);
        pswStr = password;
   
        logSource.password = password;
        _login.encryptPsw = password;
        NSDictionary * loginDic = @{@"password":[NSString stringWithFormat:@"%@",pswStr],@"username":[NSString stringWithFormat:@"%@",self.userName.text]};
        NSLog(@"%@",loginDic);
        [NetworkRequests requestWithparameters:loginDic andWithURL:@"http://120.24.7.178/fshb/Manager/MobileSvc/LoginSvc.asmx/login" Success:^(NSDictionary *dic) {
            //记录用户名
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:_login];
            [user setObject:data forKey:@"loginRecord"];
            [user synchronize];
            //返回数据记录
            
            logSource.obj = dic[@"obj"][0];
            logSource.idid =dic[@"id"];
            logSource.total = dic[@"total"];
            logSource.success = dic[@"success"];
            logSource.userName = self.userName.text;
            //跳转
            LT_HomeViewController * homeCon = [[LT_HomeViewController alloc]init];
            UINavigationController * navCon = [[UINavigationController alloc]initWithRootViewController:homeCon];
            [self presentViewController:navCon animated:YES completion:nil];
            
        } failure:^(NSDictionary *dic) {
            UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"登录失败" message:dic[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [self presentViewController:alert animated:YES completion:nil];
        }];
        
    } failure:^(NSString *str){
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"登录失败" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    


    
}

@end
