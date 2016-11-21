//
//  AssistantLoginVC.m
//  Examination
//
//  Created by gaobin on 16/9/18.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AssistantLoginVC.h"
#import "HJTextField.h"
#import "RootViewController.h"
#import "User.h"

@interface AssistantLoginVC ()<UITextFieldDelegate>

@property (nonatomic, strong) HJTextField * phoneTF;
@property (nonatomic, strong) UIImageView * phoneImgView;
@property (nonatomic, strong) HJTextField * pswTF;
@property (nonatomic, strong) UIImageView * pswImgView;

@end

@implementation AssistantLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"考场助理登录";
    
    [self createUI];
    
    [self setupNav:@"考场助理登录"];
}
- (void)createUI {
    
    UIImageView * bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:@"Layer_back"];
    [self.view addSubview:bgImgView];
    
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:120/255.0 green:115/255.0 blue:115/255.0 alpha:1.0];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(64);
        make.height.offset(1);
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
        make.top.equalTo(lineView.mas_bottom).offset(90);
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

}

#pragma mark -- 登录
- (void)loginBtnClick {
    
    
    NSString *phone = _phoneTF.text;
    
    NSString *psw = _pswTF.text;
    
    
    if (![ValidateHelper validateMobile:phone]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }

    if (![ValidateHelper validatePassword:psw]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6-20位密码" hideAfterDelay:1.0];
        return;
    }

    
    NSString * url = loginUrl;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"phone"] = _phoneTF.text;
    paramDict[@"time"] = timeStr;
    paramDict[@"password"] = _pswTF.text;
    paramDict[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    paramDict[@"pushID"] = pushID;
    paramDict[@"loginChannel"] = @"3";
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

- (void)setupNav:(NSString *)title
{
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 44, 44)];
    [back setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UILabel *bartitle = [[UILabel alloc]init];
    bartitle.textColor = [UIColor whiteColor];
    bartitle.text = title;
    bartitle.textAlignment = NSTextAlignmentCenter;
    bartitle.font = Font20;
    [self.view addSubview:bartitle];
    [bartitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(30);
    }];
    
    
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
