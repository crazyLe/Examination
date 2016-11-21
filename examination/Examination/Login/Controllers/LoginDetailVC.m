//
//  LoginDetailVC.m
//  Examination
//
//  Created by gaobin on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "LoginDetailVC.h"
#import "RootViewController.h"
#import "HJTextField.h"
#import "User.h"
#import "AssistantLoginVC.h"

@interface LoginDetailVC ()<UITextFieldDelegate>

{
    UITextField * _lastSelectTF;
    int totalA;
}
@property (nonatomic, strong) UIButton * leftBtn;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) HJTextField * phoneTF;
@property (nonatomic, strong) UIImageView * phoneImgView;
@property (nonatomic, strong) HJTextField * pswTF;
@property (nonatomic, strong) UIImageView * pswImgView;
@property (nonatomic, strong) UIButton * assistantLoginBtn;
@property (nonatomic, strong) UIButton * getCodeBtn;
@property (nonatomic, assign) BOOL isPswLogin;

@end

@implementation LoginDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    totalA = 60;
    
    _isPswLogin = YES;
    
    [self createUI];
    
    [self setupNav:nil];
}
- (void)setupNav:(NSString *)title
{
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 44, 44)];
    [back setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}
- (void)createUI {
    
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"Layer_back"];
    [self.view addSubview:bgImgView];
    
    
    UIView * topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.layer.cornerRadius = 5;
    topView.clipsToBounds = YES;
    topView.layer.borderWidth = 0.5;
    topView.layer.borderColor = [UIColor colorWithHexString:@"fe9a33"].CGColor;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(25);
        make.width.offset(210);
        make.height.offset(30);
    }];
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _leftBtn.selected = YES;
    _leftBtn.titleLabel.font = Font15;
    _leftBtn.backgroundColor = [UIColor colorWithHexString:@"fe9a33"];
    [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.left.offset(0);
        make.width.equalTo(topView.mas_width).multipliedBy(0.5);
    }];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"fe9a33"] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = Font15;
    _rightBtn.backgroundColor = [UIColor whiteColor];
    [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.width.equalTo(topView.mas_width).multipliedBy(0.5);
    }];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"808080"];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(topView.mas_bottom).offset(5);
        make.height.offset(1.5);
    }];
    
    
    
    _phoneTF = [[HJTextField alloc] init];
    _phoneTF.tag = 100;
    _phoneTF.delegate = self;
    _phoneTF.placeholder = @"手机号";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    [_phoneTF setBackground:[UIImage imageNamed:@"背景框"]];
    [_phoneTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTF.layer.cornerRadius = 20.0;
    _phoneTF.clipsToBounds = YES;
    _phoneTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [bgImgView addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerX.equalTo(bgImgView);
        make.top.equalTo(topView.mas_bottom).offset(100);
        make.height.offset(44);
    }];
    _phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _phoneImgView.image = [UIImage imageNamed:@"手机"];
    _phoneTF.leftView = _phoneImgView;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    //密码
    _pswTF = [[HJTextField alloc] init];
    _pswTF.tag = 103;
    _pswTF.delegate = self;
    _pswTF.placeholder = @"密码";
    _pswTF.secureTextEntry = YES;
    _pswTF.keyboardType = UIKeyboardTypeASCIICapable;
    [_pswTF setBackground:[UIImage imageNamed:@"背景框"]];
    [_pswTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _pswTF.layer.cornerRadius = 20.0;
    _pswTF.clipsToBounds = YES;
    _pswTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [bgImgView addSubview:_pswTF];
    [_pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerX.equalTo(bgImgView);
        make.top.equalTo(_phoneTF.mas_bottom).offset(22);
        make.height.offset(44);
    }];
    _pswImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _pswImgView.image = [UIImage imageNamed:@"mima"];
    _pswTF.leftView = _pswImgView;
    _pswTF.leftViewMode = UITextFieldViewModeAlways;
    

    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor colorWithHexString:@"e5882c"] forState:UIControlStateNormal];
    _getCodeBtn.titleLabel.font = Font15;
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_pswTF addSubview:_getCodeBtn];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(_pswTF);
    }];
    _getCodeBtn.alpha = 0;

    //登录
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.layer.cornerRadius = 20.0;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.equalTo(_pswTF.mas_bottom).offset(50);
        make.height.offset(44);
    }];
    
    //考场助理登录
    _assistantLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _assistantLoginBtn.layer.cornerRadius = 20.0;
    _assistantLoginBtn.alpha = 0.7;
    _assistantLoginBtn.backgroundColor = [UIColor colorWithHexString:@"000000"];
    [_assistantLoginBtn setTitle:@"考场助理登录" forState:UIControlStateNormal];
    [_assistantLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_assistantLoginBtn addTarget:self action:@selector(assistantLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:_assistantLoginBtn];
    [_assistantLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.height.offset(44);
        make.bottom.offset(-100);
    }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _lastSelectTF.layer.borderColor = [UIColor clearColor].CGColor;
    switch (_lastSelectTF.tag) {
        case 100:
        {
             _phoneImgView.image = [UIImage imageNamed:@"手机"];
        }
            break;
        case 103:
        {
            if (_isPswLogin) {
                
                _pswImgView.image = [UIImage imageNamed:@"mima"];
            }else {
                
                _pswImgView.image = [UIImage imageNamed:@"yanzheng"];
            }

        }
            break;
        default:
            break;
    }
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor colorWithHexString:@"fe9a33"].CGColor;
    switch (textField.tag) {
        case 100:
        {
            _phoneImgView.image = [UIImage imageNamed:@"手机2"];

        }
            break;
        case 103:
        {
            if (_isPswLogin) {
                
                _pswImgView.image = [UIImage imageNamed:@"mima1"];
            }else {
                
                _pswImgView.image = [UIImage imageNamed:@"yanzheng1"];
            }
            
        }
            break;
        default:
            break;
    }
    _lastSelectTF = textField;
}


#pragma mark -- 登录
- (void)loginBtnClick {
    
    
    NSString *phone = _phoneTF.text;
    
    NSString *psw = _pswTF.text;
    
    NSString *channel = (_isPswLogin)?@"1":@"2";
    
    if (![ValidateHelper validateMobile:phone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    if (_isPswLogin) {
        if (![ValidateHelper validatePassword:psw]) {
            [self.hudManager showErrorSVHudWithTitle:@"请输入6-20位密码" hideAfterDelay:1.0];
            return;
        }
    }else
    {
        if (! (6 == psw.length)) {
            [self.hudManager showErrorSVHudWithTitle:@"请输入6位验证码" hideAfterDelay:1.0];
            return;
        }
    }

    
    NSString * url = loginUrl;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"phone"] = _phoneTF.text;
    paramDict[@"time"] = timeStr;
    paramDict[@"password"] = _pswTF.text;
    paramDict[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    paramDict[@"pushID"] = pushID;
    paramDict[@"loginChannel"] = channel;
    paramDict[@"sign"] = [HttpParamManager getCodeSignWithIdentify:@"/user/login" time:timeStr phone:_phoneTF.text];
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    [HJHttpManager PostRequestWithUrl:url param:paramDict finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        if (1 == [dict[@"code"] intValue]) {
            [self.hudManager showSuccessSVHudWithTitle:@"登录成功" hideAfterDelay:2.0 animaton:YES];
            [User userWithDict:dict[@"info"]];
            RootViewController * rootVC = [[RootViewController alloc]init];
            [self presentViewController:rootVC animated:YES completion:nil];

        }else
        {
            NSString *msg = dict[@"msg"];
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
            
        }
    } failed:^(NSError *error) {
        
    }];
}
#pragma mark -- 考场助理登录
- (void)assistantLoginBtnClick:(UIButton *)btn {
    
    
    
    AssistantLoginVC * vc = [[AssistantLoginVC alloc] init];
    
    [self presentViewController:vc animated:YES completion:nil];
    
}
#pragma mark -- 获取验证码
- (void)getCodeBtnClick:(UIButton *)sender
{
    NSString *newphone = _phoneTF.text;
    
    if (![ValidateHelper validateMobile:newphone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    
    sender.enabled = NO;
    NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updatesecTitle:) userInfo:nil repeats:YES];
    [timer2 fire];
    [self getcode:newphone];
}

- (void)updatesecTitle:(NSTimer *)obj
{
    totalA --;
    NSString *title = [NSString stringWithFormat:@"已发送(%d)",totalA];
    [_getCodeBtn setTitle:title forState:UIControlStateNormal];
    if (0 == totalA) {
        totalA = 60;
        [_getCodeBtn setTitle:@"发送" forState:UIControlStateNormal];
        _getCodeBtn.enabled = YES;
        [obj invalidate];
    }
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
    param[@"flag"] = @"login";
    
    [HJHttpManager PostRequestWithUrl:getCode param:param finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        if (1 == [dict[@"code"] intValue]) {
            [self.hudManager showSuccessSVHudWithTitle:@"验证码发送成功" hideAfterDelay:2.0 animaton:YES];
        }else
        {
            [self.hudManager showSuccessSVHudWithTitle:@"验证码发送失败，请重试" hideAfterDelay:2.0 animaton:YES];
        }
    } failed:^(NSError *error) {
        
    } ];
}
- (void)leftBtnClick {
    
    
    _isPswLogin = YES;
    
    _leftBtn.backgroundColor = [UIColor colorWithHexString:@"fe9a33"];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _rightBtn.backgroundColor = [UIColor whiteColor];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"fe9a33"] forState:UIControlStateNormal];
    
    _pswTF.text = nil;
    
    _pswImgView.image = [UIImage imageNamed:@"mima"];
    _pswTF.placeholder = @"密码";
    _getCodeBtn.alpha = 0;
    
    _pswTF.secureTextEntry = YES;
    _pswTF.keyboardType = UIKeyboardTypeASCIICapable;

}
- (void)rightBtnClick {
    
    
    _isPswLogin = NO;
    
    _rightBtn.backgroundColor = [UIColor colorWithHexString:@"fe9a33"];
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _leftBtn.backgroundColor = [UIColor whiteColor];
    [_leftBtn setTitleColor:[UIColor colorWithHexString:@"fe9a33"] forState:UIControlStateNormal];
    _pswTF.text = nil;
    
    _pswImgView.image = [UIImage imageNamed:@"yanzheng"];
    _pswTF.placeholder = @"验证码";
    _getCodeBtn.alpha = 1;
    _pswTF.secureTextEntry = NO;
    _pswTF.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)backClick {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
