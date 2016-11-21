//
//  SecurityAccountController.m
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "SecurityAccountController.h"
#import "LoginViewController.h"

@interface SecurityAccountController ()
{
    int totalA;
    int totalB;
}

@property (nonatomic, strong) UIButton* passwordBtn;
@property (nonatomic, strong) UIButton * mobileBtn;

@property (nonatomic,strong) UIView * passWordView;
@property (nonatomic,strong) UIView * mobileView;

@property(nonatomic,weak)UIButton *sendCodeFirstbtn;
@property(nonatomic,weak)UIButton *sendCodeSecondbtn;

@property(nonatomic,weak)UITextField *text1;
@property(nonatomic,weak)UITextField *text2;
@property(nonatomic,weak)UITextField *text3;
@property(nonatomic,weak)UITextField *text4;

@end

@implementation SecurityAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI
{
    
    totalA = 60;
    totalB = 60;
    
    [super initWithUI];
    
    self.title = @"账号安全";
    
    _passwordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _passwordBtn.frame = CGRectMake((kScreenWidth-136*2)/2, 12+64, 136, 30);
    [_passwordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [_passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_payFirstBtn setBackgroundImage:[UIImage imageNamed:@"1111"] forState:UIControlStateNormal];
//    [_passwordBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"fe9a33"]] forState:UIControlStateNormal];
    [_passwordBtn setBackgroundColor:[UIColor colorWithHexString:@"fe9a33"]];
    _passwordBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _passwordBtn.tag = 100;
    [_passwordBtn addTarget:self action:@selector(pressPasswordBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_passwordBtn];
    
    _mobileBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mobileBtn.frame = CGRectMake((kScreenWidth-136*2)/2+136, 12+64, 136, 30);
    [_mobileBtn setTitle:@"修改绑定手机号" forState:UIControlStateNormal];
    [_mobileBtn setTitleColor:[UIColor colorWithHexString:@"#fe9a33"] forState:UIControlStateNormal];
    //    [_paySecondBtn setBackgroundImage:[UIImage imageNamed:@"2222"] forState:UIControlStateNormal];
    [_mobileBtn setBackgroundColor:[UIColor whiteColor]];
    _mobileBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _mobileBtn.tag = 200;
    [_mobileBtn addTarget:self action:@selector(pressPhoneNumBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mobileBtn];
    
    _passWordView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_passwordBtn.frame)+12, kScreenWidth, 296)];
    _passWordView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_passWordView];
//    _passWordView.hidden = YES;
    [self createPassWordView];
    
    
    _mobileView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_passwordBtn.frame)+12, kScreenWidth, 387)];
    _mobileView.backgroundColor = [UIColor whiteColor];
    _mobileView.hidden = YES;
    [self.view addSubview:_mobileView];
    [self createMobileView];
    
    
}

- (void)initWithData
{
    [super initWithData];
    
    
}

- (void)createPassWordView
{
    UILabel * infolabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 31, 100, 16)];
    infolabel.text = @"修改密码:";
    infolabel.textColor = RGBCOLOR(39, 39, 39);
    infolabel.font = Font15;
    //    infolabel.backgroundColor = [UIColor yellowColor];
    [_passWordView addSubview:infolabel];
    
    NSArray * arr = @[@"输入旧密码",@"输入新密码",@"再次确认新密码"];
    for (int i=0; i<3; i++) {
        
        UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth-252)/2, CGRectGetMaxY(infolabel.frame)+25+43*i, 252, 32)];
        field.borderStyle = UITextBorderStyleRoundedRect;
        if (i == 0) {
            field.layer.borderColor = RGBCOLOR(253, 143, 34).CGColor;
        }
        //            field.backgroundColor = [UIColor cyanColor];
        field.placeholder = arr[i];
        field.textAlignment = NSTextAlignmentCenter;
        field.tag = 1000+1000*i;
        [_passWordView addSubview:field];
    }
    
    UIButton * ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.frame = CGRectMake((kScreenWidth-192)/2, CGRectGetMaxY(infolabel.frame)+25+2*43+32+26, 192, 44);
    ensureBtn.tag = 202;
    ensureBtn.layer.cornerRadius = 22.0;
    ensureBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [ensureBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(pressEnsureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_passWordView addSubview:ensureBtn];
    
}

- (void)createMobileView
{
    UILabel * infolabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 31, 130, 16)];
    infolabel.text = @"修改绑定手机号:";
    infolabel.textColor = RGBCOLOR(39, 39, 39);
    infolabel.font = Font15;
//    infolabel.backgroundColor = [UIColor yellowColor];
    [_mobileView addSubview:infolabel];
    
    NSArray * arr = @[@"输入原手机号码",@"验证码",@"输入新绑定手机号码",@"验证码"];
    for (int i=0; i<4; i++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth-252)/2, CGRectGetMaxY(infolabel.frame)+25+43*i, 252, 32)];
        view.tag = 60+i;
//        view.backgroundColor = [UIColor greenColor];
        [_mobileView addSubview:view];
        
        if (i == 1 || i==3) {
            UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 152, view.frame.size.height)];
            field.borderStyle = UITextBorderStyleRoundedRect;
//            field.backgroundColor = [UIColor cyanColor];
            field.placeholder = arr[i];
            field.textAlignment = NSTextAlignmentCenter;
            field.keyboardType = UIKeyboardTypeNumberPad;
            field.tag = 100+100*i;
            [view addSubview:field];
            if (1 == i) {
                _text1 = field;
            }
            if (3 == i) {
                _text3 = field;
            }
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(field.frame)+10, 0, view.frame.size.width-152-10, view.frame.size.height);
            btn.layer.cornerRadius = 3.0;
            btn.tag = 10+10*i;
            if (i == 1) {
                btn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _sendCodeFirstbtn = btn;
                [btn addTarget:self action:@selector(pressfirBtn:) forControlEvents:UIControlEventTouchUpInside];
            }else if (i == 3){
                btn.backgroundColor = [UIColor colorWithHexString:@"#fff7ef"];
                [btn setTitleColor:RGBCOLOR(250, 137, 40) forState:UIControlStateNormal];
                btn.layer.borderWidth = 1.0;
                btn.layer.borderColor = RGBCOLOR(251, 135, 40).CGColor;
                _sendCodeSecondbtn = btn;
                [btn addTarget:self action:@selector(presssecBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            btn.titleLabel.font = Font15;
            [btn setTitle:@"发送" forState:UIControlStateNormal];
            [view addSubview:btn];
            
        }else{
            UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
            field.borderStyle = UITextBorderStyleRoundedRect;
//            field.backgroundColor = [UIColor cyanColor];
            field.placeholder = arr[i];
            field.textAlignment = NSTextAlignmentCenter;
            field.keyboardType = UIKeyboardTypeNumberPad;
            field.tag = 100+100*i;
            [view addSubview:field];
            if (0 == i) {
                _text2 = field;
            }
            if (2 == i) {
                _text4 = field;
            }
        }
    }
    
    UIButton * ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.frame = CGRectMake((kScreenWidth-192)/2, CGRectGetMaxY(infolabel.frame)+25+4*43+32+26, 192, 44);
    ensureBtn.tag = 203;
    ensureBtn.layer.cornerRadius = 22.0;
    ensureBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [ensureBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ensureBtn addTarget:self action:@selector(pressEnsureBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_mobileView addSubview:ensureBtn];
    
}

//获取验证码

- (void)getcode:(NSString *)curphone
{
    NSString *curtime = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"phone"] = curphone;
    param[@"time"] = curtime;
    param[@"pushID"] = pushID;
    param[@"sign"] = [HttpParamManager getCodeSignWithIdentify:@"/user/sendCode" time:curtime phone:curphone];
    param[@"flag"] = @"changemobile";
    
    [HJHttpManager PostRequestWithUrl:getCode param:param finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        NSString *msg = dict[@"msg"];
        if (1 == [dict[@"code"] intValue]) {
            [self.hudManager showSuccessSVHudWithTitle:@"验证码发送成功" hideAfterDelay:2.0 animaton:YES];
        }else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:2.0];
        }
    } failed:^(NSError *error) {
        
    } ];
}
//修改密码
- (void)modeifyPassword
{
    NSString *oldpsw = ((UITextField *)[_passWordView viewWithTag:1000]).text;
    NSString *newpws = ((UITextField *)[_passWordView viewWithTag:2000]).text;
    NSString *surenewpws = ((UITextField *)[_passWordView viewWithTag:3000]).text;
    
    if (![ValidateHelper validatePassword:oldpsw]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6-20位密码" hideAfterDelay:1.0];
        return;
    }
    if (![ValidateHelper validatePassword:oldpsw]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6-20位密码" hideAfterDelay:1.0];
        return;
    }
    if (![newpws isEqualToString:surenewpws]) {
        [self.hudManager showErrorSVHudWithTitle:@"修改密码输入不同" hideAfterDelay:1.0];
        return;
    }
    
    NSString *curtime = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = curtime;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/editPassword" time:curtime];
    param[@"oPwd"] = oldpsw;
    param[@"nPwd"] = newpws;
    
    [HJHttpManager PostRequestWithUrl:modifyPassword param:param finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        if (1 == [dict[@"code"] intValue]) {
            [self.hudManager showSuccessSVHudWithTitle:@"密码修改成功" hideAfterDelay:2.0 animaton:YES];
            LoginViewController *login = [[LoginViewController alloc]init];
            [self presentViewController:login animated:YES completion:nil]
            ;
        }else
        {
            NSString *msg = dict[@"msg"];
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];

        }
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    } ];
}

//修改手机号
- (void)modeifyPhone
{
    NSString *oldphone = _text2.text;
    NSString *oldcode = _text1.text;
    NSString *newphone = _text4.text;
    NSString *newcode = _text3.text;
    
    if (![ValidateHelper validateMobile:oldphone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    if (!(oldcode.length == 6)) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6位数字验证码" hideAfterDelay:1.0];

        return;
    }
    if (![ValidateHelper validateMobile:newphone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    if (!(newcode.length == 6)) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6位数字验证码" hideAfterDelay:1.0];
        return;
    }
    NSString *curtime = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = curtime;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/editPhone" time:curtime];
    param[@"oPhone"] = oldphone;
    param[@"nPhone"] = oldcode;
    param[@"oCode"] = newphone;
    param[@"nCode"] = newcode;
    
    [HJHttpManager PostRequestWithUrl:modifyPhone param:param finish:^(NSData *data) {
        
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        if (1 == [dict[@"code"] intValue]) {
            [self.hudManager showSuccessSVHudWithTitle:@"密码修改成功" hideAfterDelay:2.0 animaton:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            NSString *msg = dict[@"msg"];
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
    } failed:^(NSError *error) {
        
    } ];
}

- (void)pressPasswordBtn:(UIButton *)sender
{
    [_passwordBtn setBackgroundColor:[UIColor colorWithHexString:@"fe9a33"]];
    [_passwordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_mobileBtn setBackgroundColor:[UIColor whiteColor]];
    [_mobileBtn setTitleColor:[UIColor colorWithHexString:@"#fe9a33"] forState:UIControlStateNormal];
    
    _passWordView.hidden = NO;
    _mobileView.hidden = YES;
}

- (void)pressPhoneNumBtn:(UIButton *)sender
{
    [_mobileBtn setBackgroundColor:[UIColor colorWithHexString:@"fe9a33"]];
    [_mobileBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_passwordBtn setBackgroundColor:[UIColor whiteColor]];
    [_passwordBtn setTitleColor:[UIColor colorWithHexString:@"#fe9a33"] forState:UIControlStateNormal];
    _passWordView.hidden = YES;
    _mobileView.hidden = NO;
}

//点击确认修改
- (void)pressEnsureBtn:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (202 == tag) {
        [self modeifyPassword];
    }else
    {
        [self modeifyPhone];
    }
    
}

- (void)pressfirBtn:(UIButton *)sender
{
    NSString *oldphone = _text2.text;
    
    if (![ValidateHelper validateMobile:oldphone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    
    sender.enabled = NO;
    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatefirTitle:) userInfo:nil repeats:YES];
    [timer1 fire];
    [self getcode:oldphone];
}

- (void)presssecBtn:(UIButton *)sender
{
    NSString *newphone = _text2.text;
    
    if (![ValidateHelper validateMobile:newphone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    
    sender.enabled = NO;
    NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatesecTitle:) userInfo:nil repeats:YES];
    [timer2 fire];
    [self getcode:newphone];
}

- (void)updatefirTitle:(NSTimer *)obj
{
    totalA --;
    NSString *title = [NSString stringWithFormat:@"已发送(%d)",totalA];
    [_sendCodeFirstbtn setTitle:title forState:UIControlStateNormal];
    if (0 == totalA) {
        totalA = 60;
        [_sendCodeFirstbtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendCodeFirstbtn.enabled = YES;
        [obj invalidate];
    }
}
- (void)updatesecTitle:(NSTimer *)obj
{
    totalB --;
    NSString *title = [NSString stringWithFormat:@"已发送(%d)",totalB];
    [_sendCodeSecondbtn setTitle:title forState:UIControlStateNormal];
    if (0 == totalB) {
        totalB = 60;
        [_sendCodeSecondbtn setTitle:@"发送" forState:UIControlStateNormal];
        _sendCodeSecondbtn.enabled = YES;
        [obj invalidate];
    }
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
