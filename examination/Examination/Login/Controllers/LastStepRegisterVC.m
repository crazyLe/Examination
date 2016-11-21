//
//  LastStepRegisterVC.m
//  Examination
//
//  Created by gaobin on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "LastStepRegisterVC.h"
#import "HJTextField.h"
#import "LoginDetailVC.h"

@interface LastStepRegisterVC ()<UITextFieldDelegate>
{
    
    UITextField * _lastSelectTF;
    int _second;
    
}
@property (nonatomic,strong) UIImageView * backgroundImageV;
@property (nonatomic, strong) HJTextField * nameTF;
@property (nonatomic, strong) HJTextField * phoneTF;
@property (nonatomic, strong) HJTextField * validateCodeTF;
@property (nonatomic, strong) HJTextField * pswTF;
@property (nonatomic, strong) UILabel * codeMistakeLab;
@property (nonatomic, strong) UIImageView * nameImgView;
@property (nonatomic, strong) UIImageView * phoneImgView;
@property (nonatomic, strong) UIImageView * validateImgView;
@property (nonatomic, strong) UIImageView * pswImgView;
@property (nonatomic, strong) UIButton * getCodeBtn;


@end

@implementation LastStepRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _second = 60;
   
    [self initWithUI];
    
    [self setupNav:@"注册"];
}
- (void)setupNav:(NSString *)title
{
    UIView *barview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    barview.backgroundColor = NavBackColor;
    [self.view addSubview:barview];
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 44, 44)];
    [back setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [barview addSubview:back];
    
    UILabel *bartitle = [[UILabel alloc]initWithFrame:CGRectMake((kWidth-100)/2, 20, 100, 44)];
    bartitle.textColor = [UIColor whiteColor];
    bartitle.text = title;
    bartitle.textAlignment = NSTextAlignmentCenter;
    bartitle.font = Font22;
    [barview addSubview:bartitle];
    
}
- (void)initWithUI {
    
    _backgroundImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroundImageV.backgroundColor = [UIColor cyanColor];
    _backgroundImageV.userInteractionEnabled = YES;
    _backgroundImageV.image = [UIImage imageNamed:@"Layer_back"];
    [self.view addSubview:_backgroundImageV];
    
    UILabel * remindLab = [[UILabel alloc] init];
    remindLab.text = @"为方便与您取得联系\n请输入负责人手机号并进行验证";
    remindLab.numberOfLines = 2;
    remindLab.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    remindLab.textAlignment = NSTextAlignmentCenter;
    remindLab.font = Font15;
    [_backgroundImageV addSubview:remindLab];
    [remindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(40);
        make.centerX.equalTo(_backgroundImageV);
    }];
    
    _nameTF = [[HJTextField alloc] init];
    _nameTF.tag = 100;
    _nameTF.delegate = self;
    _nameTF.placeholder = @"姓名";
    [_nameTF setBackground:[UIImage imageNamed:@"背景框"]];
    [_nameTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _nameTF.layer.cornerRadius = 20.0;
    _nameTF.clipsToBounds = YES;
    _nameTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_nameTF];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerX.equalTo(_backgroundImageV);
        make.top.equalTo(remindLab.mas_bottom).offset(20);
        make.height.offset(44);
    }];
    _nameImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _nameImgView.image = [UIImage imageNamed:@"用户-(2)"];
    _nameTF.leftView = _nameImgView;
    _nameTF.leftViewMode = UITextFieldViewModeAlways;

    
    //手机号
    _phoneTF = [[HJTextField alloc] init];
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.tag = 101;
    _phoneTF.delegate = self;
    _phoneTF.placeholder = @"手机号";
    [_phoneTF setBackground:[UIImage imageNamed:@"背景框"]];
    [_phoneTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTF.layer.cornerRadius = 20.0;
    _phoneTF.clipsToBounds = YES;
    _phoneTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_phoneTF];
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerX.equalTo(_backgroundImageV);
        make.top.equalTo(_nameTF.mas_bottom).offset(22);
        make.height.offset(44);
    }];
    _phoneImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _phoneImgView.image = [UIImage imageNamed:@"手机"];
    _phoneTF.leftView = _phoneImgView;
    _phoneTF.leftViewMode = UITextFieldViewModeAlways;
    
    //验证码
    _validateCodeTF = [[HJTextField alloc] init];
    _validateCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    _validateCodeTF.tag = 102;
    _validateCodeTF.delegate = self;
    _validateCodeTF.placeholder = @"验证码";
    [_validateCodeTF setBackground:[UIImage imageNamed:@"背景框"]];
    [_validateCodeTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _validateCodeTF.layer.cornerRadius = 20.0;
    _validateCodeTF.clipsToBounds = YES;
    _validateCodeTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_validateCodeTF];
    [_validateCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerX.equalTo(_backgroundImageV);
        make.top.equalTo(_phoneTF.mas_bottom).offset(22);
        make.height.offset(44);
    }];
    _validateImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _validateImgView.image = [UIImage imageNamed:@"yanzheng"];
    _validateCodeTF.leftView = _validateImgView;
    _validateCodeTF.leftViewMode = UITextFieldViewModeAlways;
    _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getCodeBtn setTitleColor:[UIColor colorWithHexString:@"e5882c"] forState:UIControlStateNormal];
    _getCodeBtn.titleLabel.font = Font15;
    [_getCodeBtn addTarget:self action:@selector(getCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_validateCodeTF addSubview:_getCodeBtn];
    [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(_validateCodeTF);
    }];
    
    //密码
    _pswTF = [[HJTextField alloc] init];
    _pswTF.keyboardType = UIKeyboardTypeASCIICapable;
    _pswTF.tag = 103;
    _pswTF.delegate = self;
    _pswTF.placeholder = @"设置密码";
    [_pswTF setBackground:[UIImage imageNamed:@"背景框"]];
    [_pswTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _pswTF.layer.cornerRadius = 20.0;
    _pswTF.clipsToBounds = YES;
    _pswTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_pswTF];
    [_pswTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.centerX.equalTo(_backgroundImageV);
        make.top.equalTo(_validateCodeTF.mas_bottom).offset(22);
        make.height.offset(44);
    }];
    _pswImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    _pswImgView.image = [UIImage imageNamed:@"mima"];
    _pswTF.leftView = _pswImgView;
    _pswTF.leftViewMode = UITextFieldViewModeAlways;
    
    _codeMistakeLab = [[UILabel alloc] init];
    _codeMistakeLab.textColor = [UIColor colorWithHexString:@"e5882c"];
    [_backgroundImageV addSubview:_codeMistakeLab];
    [_codeMistakeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_pswTF.mas_bottom).offset(10);
        make.left.offset(80);
    }];
    
    UIButton * joinAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joinAppBtn.layer.cornerRadius = 20.0;
    joinAppBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [joinAppBtn setTitle:@"进去APP" forState:UIControlStateNormal];
    [joinAppBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [joinAppBtn addTarget:self action:@selector(joinAPPBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageV addSubview:joinAppBtn];
    [joinAppBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(44);
        make.left.offset(38);
        make.right.offset(-38);
        make.top.equalTo(_codeMistakeLab.mas_bottom).offset(50);
    }];

    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    _lastSelectTF.layer.borderColor = [UIColor clearColor].CGColor;
    switch (_lastSelectTF.tag) {
        case 100:
        {
            _nameImgView.image = [UIImage imageNamed:@"用户-(2)"];
        }
            break;
        case 101:
        {
            _phoneImgView.image = [UIImage imageNamed:@"手机"];
        }
            break;
        case 102:
        {
            _validateImgView.image = [UIImage imageNamed:@"yanzheng"];
        }
            break;
        case 103:
        {
            _pswImgView.image = [UIImage imageNamed:@"mima"];
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
            _nameImgView.image = [UIImage imageNamed:@"用户-(1"];
        }
            break;
        case 101:
        {
            _phoneImgView.image = [UIImage imageNamed:@"手机2"];
        }
            break;
        case 102:
        {
            _validateImgView.image = [UIImage imageNamed:@"yanzheng1"];

        }
            break;
        case 103:
        {
            _pswImgView.image = [UIImage imageNamed:@"mima1"];
        }
            break;
            
        default:
            break;
    }
    
    _lastSelectTF = textField;
    
}
- (void)updateTitle:(NSTimer *)timer {
    
    _second --;
    NSString * title = [NSString stringWithFormat:@"已发送(%d)",_second];
    [_getCodeBtn setTitle:title forState:UIControlStateNormal];
    if (_second == 0) {
        _second = 60;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.enabled = YES;
        [timer invalidate];
    }
    
    
}
- (void)getCodeBtnClick:(UIButton *)btn {
    
    if (![ValidateHelper validateMobile:_phoneTF.text]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    btn.enabled = NO;
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTitle:) userInfo:nil repeats:YES];
    [timer fire];
    
    [self getCodeValidate];
    
    
}
- (void)getCodeValidate {
    
    
    NSString * url = getValidateCode;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"phone"] = _phoneTF.text;
    paramDict[@"time"] = timeStr;
    paramDict[@"pushID"] = pushID;
    NSString * signStr = [NSString stringWithFormat:@"%@/user/sendCode%@%@",pushID,timeStr,_phoneTF.text];
    paramDict[@"sign"] = [signStr md5String];
    paramDict[@"flag"] = @"regist";
    [HJHttpManager PostRequestWithUrl:url param:paramDict finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"注册获取验证码%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
    } failed:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"获取验证码失败" hideAfterDelay:1.0];
        
    }];

    
    
}
- (void)joinAPPBtnClick {
    
    if (_nameTF.text.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"用户名不能为空" hideAfterDelay:1.0];
        return;
    }
    if (![ValidateHelper validateMobile:_phoneTF.text]) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入正确手机号" hideAfterDelay:1.0];
        return;
    }
    if (6 != _validateCodeTF.text.length) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6位数字验证码" hideAfterDelay:1.0];
        return;
    }
    if (![ValidateHelper validatePassword:_pswTF.text] ) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6~20位密码" hideAfterDelay:1.0];
        return;
    }
    
    [self.hudManager showNormalStateSVHUDWithTitle:nil];
    
    NSString * url = registerUrl;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"phone"] = _phoneTF.text;
    paramDict[@"time"] = timeStr;
    paramDict[@"code"] = _validateCodeTF.text;
    paramDict[@"pwd"] = _pswTF.text;
    paramDict[@"provinceId"] = _registerModel.provinceId;
    paramDict[@"cityId"] = _registerModel.cityId;
    paramDict[@"areaId"] = _registerModel.areaId;
    paramDict[@"placeId"] = _registerModel.placeId;
    paramDict[@"placeName"] = _registerModel.placeName;
    paramDict[@"realName"] = _nameTF.text;
    paramDict[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    paramDict[@"pushID"] = pushID;
    NSString * signStr = [NSString stringWithFormat:@"%@/user/register%@%@",pushID,timeStr,_phoneTF.text];
    paramDict[@"sign"] = [signStr md5String];
    //经纬度与详细地址
    if (_isFromGroupMap) {
        paramDict[@"address"] = [NSString stringWithFormat:@"%f%f",_cityModel.pt.longitude,_cityModel.pt.latitude];
        paramDict[@"addressName"] = _cityModel.address;
    }

    
    [HJHttpManager PostRequestWithUrl:url param:paramDict finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"注册%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
            [self.hudManager dismissSVHud];
            LoginDetailVC * vc = [[LoginDetailVC alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
        
    } failed:^(NSError *error) {
       
        [self.hudManager showErrorSVHudWithTitle:@"注册失败" hideAfterDelay:1.0];
        
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
