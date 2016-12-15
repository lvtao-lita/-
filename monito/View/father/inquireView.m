/**
 * @brief 查询View
 **/

#import "inquireView.h"
#import "YPpickViewController.h"
#import "PrefixHeader.pch"

@implementation inquireView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView{
    self.backgroundColor = [UIColor whiteColor];
//    NSArray * arr = @[@"开始时间：",@"结束时间：",@"关 键 字："];
    self.starTime = [[UITextField alloc]init];
    self.starTime.frame = CGRectMakeRelative(0, 0, 375, 40);
    self.starTime.placeholder = @"输入开始时间";
    self.starTime.delegate =self;
    [self setTextfiled:self.starTime leftViewname:@"开始时间："];
    self.endTime = [[UITextField alloc]init];
    self.endTime.frame = CGRectMakeRelative(0, 40, 375, 40);
    self.endTime.placeholder = @"输入结束时间";
    self.endTime.delegate = self;
    [self setTextfiled:self.endTime leftViewname:@"结束时间："];
    self.keyword = [[UITextField alloc]init];
    self.keyword.frame = CGRectMakeRelative(0, 80, 375, 40);
    self.keyword.placeholder = @"输入关键字";
    [self setTextfiled:self.keyword leftViewname:@"关 键 字："];
}
-(void)setTextfiled:(UITextField *)tf leftViewname:(NSString *)string{

    tf.borderStyle = UITextBorderStyleRoundedRect;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMakeRelative(10, 0, 120, 40)];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMakeRelative(10, 0, 120, 40)];
    lab.text = string;
    [view addSubview:lab];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = view;
    [self addSubview:tf];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"将要开始编辑时调用");
    YPpickViewController *ypVC  = [[YPpickViewController alloc]init];
    ypVC.calendarblock = ^(YPpickViewModel *model){
        
        NSLog(@"%@\n",model.year);
        NSLog(@"%@\n",model.moth);
        NSLog(@"%@\n",model.day);
        textField.text = [NSString stringWithFormat:@"%@-%@-%@",model.year,model.moth,model.day];
        
    };
    
    [ [self viewController].navigationController pushViewController:ypVC animated:YES];
    // return NO to disallow editing.
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"开始编辑");

}
//获取父视图
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
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


@end
