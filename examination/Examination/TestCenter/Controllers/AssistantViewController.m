//
//  AssistantViewController.m
//  Examination
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AssistantViewController.h"

@interface AssistantViewController ()

@property (nonatomic, strong) UITextField * passwordField;

@property (nonatomic, strong) UITextField * confirmField;

@end

@implementation AssistantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI
{
    [super initWithUI];
    self.title = @"助理设置";
    
    UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 46+64, kScreenWidth-40, 14)];
    phoneLabel.text = [NSString stringWithFormat:@"助理账号：%@",kPhone];
    phoneLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLabel];
    
    _passwordField = [[UITextField alloc]initWithFrame:CGRectMake(39,CGRectGetMaxY(phoneLabel.frame)+25, kScreenWidth-39*2, 45)];
    _passwordField.placeholder = @"设置助理登录密码";
//    [_passwordField setValue:[UIColor colorWithHexString:@"#cacaca"] forKeyPath:@"_placeholderLabel.textColor"];
//    [_passwordField setValue:Font13 forKeyPath:@"_placeholderLabel.font"];
//    [_passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _passwordField.textAlignment = NSTextAlignmentCenter;
    NSMutableParagraphStyle *style = [_passwordField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = _passwordField.font.lineHeight - (_passwordField.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"设置助理登录密码"
                                           attributes:@{
                                           NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#cacaca"],
                                           NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                           NSParagraphStyleAttributeName : style
                                            }
                                           ];
    _passwordField.layer.borderWidth = 1.0;
    _passwordField.layer.borderColor = kAPPThemeColor.CGColor;
    _passwordField.layer.cornerRadius = _passwordField.frame.size.height/2;
    _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    _passwordField.secureTextEntry = YES;
    [self.view addSubview:_passwordField];
    
    _confirmField = [[UITextField alloc]initWithFrame:CGRectMake(39,CGRectGetMaxY(_passwordField.frame)+25, kScreenWidth-39*2, 45)];
    _confirmField.placeholder = @"确认助理登录密码";
    //    [_passwordField setValue:[UIColor colorWithHexString:@"#cacaca"] forKeyPath:@"_placeholderLabel.textColor"];
    //    [_passwordField setValue:Font13 forKeyPath:@"_placeholderLabel.font"];
    //    [_passwordField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    _confirmField.textAlignment = NSTextAlignmentCenter;
    NSMutableParagraphStyle *style2 = [_passwordField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = _passwordField.font.lineHeight - (_passwordField.font.lineHeight - [UIFont systemFontOfSize:14.0].lineHeight) / 2.0;
    _confirmField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"确认助理登录密码"
                                                                           attributes:@{
                                                                                        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#cacaca"],
                                                                                        NSFontAttributeName : [UIFont systemFontOfSize:14.0],
                                                                                        NSParagraphStyleAttributeName : style2
                                                                                        }
                                            ];
    _confirmField.layer.borderWidth = 1.0;
    _confirmField.layer.borderColor = kAPPThemeColor.CGColor;
    _confirmField.layer.cornerRadius = _confirmField.frame.size.height/2;
    _confirmField.keyboardType = UIKeyboardTypeASCIICapable;
    _confirmField.secureTextEntry = YES;
    [self.view addSubview:_confirmField];
    
    UIButton * ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ensureBtn.frame = CGRectMake(39, CGRectGetMaxY(_confirmField.frame)+45, kScreenWidth-39*2, 45);
    ensureBtn.backgroundColor = kAPPThemeColor;
    [ensureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ensureBtn.layer.cornerRadius = ensureBtn.frame.size.height/2;
    [ensureBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ensureBtn];
    
}

- (void)initWithData
{
    [super initWithData];
    
    
}

- (void)pressBtn:(UIButton *)sender
{
    
    if (![ValidateHelper validatePassword:_passwordField.text] ) {
        [self.hudManager showErrorSVHudWithTitle:@"请输入6~20位密码" hideAfterDelay:1.0];
        return;
    }
    
    if (![_passwordField.text isEqualToString:_confirmField.text]) {
        [self.hudManager showErrorSVHudWithTitle:@"两次输入的密码不一致，请重新输入" hideAfterDelay:1.0f];
        return;
    }
    
    [self.hudManager showNormalStateSVHUDWithTitle:nil];
    
    NSString * url = assistantSetting;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"uid"] = kUid;
    paramDic[@"time"] = timeStr;
    paramDic[@"sign"] = [HttpParamManager getSignWithIdentify:@"/member/setassistant" time:timeStr];
    paramDic[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    paramDic[@"pwd"] = _passwordField.text;
    paramDic[@"confirmPwd"] = _passwordField.text;
    
    [HJHttpManager PostRequestWithUrl:url param:paramDic finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"助手账号设置%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
//            [self.hudManager dismissSVHud];
            [self.hudManager showSuccessSVHudWithTitle:@"设置成功" hideAfterDelay:1.0f animaton:YES];
            
        }if (code == 2) {
            
            [self.hudManager showErrorSVHudWithTitle:@"请先登录" hideAfterDelay:1.0];
        }if (code == 0) {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
    } failed:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"设置失败" hideAfterDelay:1.0];
        
    }];
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
