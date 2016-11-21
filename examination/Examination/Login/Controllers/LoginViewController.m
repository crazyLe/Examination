//
//  LoginViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginDetailVC.h"

@interface LoginViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * backScrollView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initWithUI];
    [self initWithData];
}

- (void)initWithUI
{
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backScrollView.delegate = self;
    _backScrollView.showsVerticalScrollIndicator =  NO;
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, 667);
    [self.view addSubview:_backScrollView];
    
    UIImageView * topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 442)];
    topImageView.image = [UIImage imageNamed:@"login_orange"];
    [_backScrollView addSubview:topImageView];
    
    UIImageView * markImageV = [[UIImageView alloc] init];
    markImageV.image = [UIImage imageNamed:@"logo_markImage"];
    [topImageView addSubview:markImageV];
    [markImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topImageView);
        make.width.height.offset(kWidth - 150);
        
    }];
   
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(38, CGRectGetMaxY(topImageView.frame)+55, kScreenWidth-38*2, 44);
    loginBtn.layer.cornerRadius = 20.0;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(pressLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:loginBtn];
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(38, CGRectGetMaxY(loginBtn.frame)+27, kScreenWidth-38*2, 44);
    registerBtn.layer.cornerRadius = 20.0;
    registerBtn.layer.borderWidth = 1.0;
    registerBtn.layer.borderColor = [UIColor colorWithHexString:@"#ff9a33"].CGColor;
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#fff7ef"];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"ff9a33"] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(pressRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:registerBtn];
    
//    [self setupNav];
}

- (void)setupNav
{
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(15, 20, 44, 44)];
    [back setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initWithData
{
    
}

- (void)pressLoginBtn:(UIButton *)sender
{
    LoginDetailVC * vc = [[LoginDetailVC alloc] init];

    [self presentViewController:vc animated:YES completion:nil];
}

- (void)pressRegisterBtn:(UIButton *)sender
{
    RegisterViewController * regisVC = [[RegisterViewController alloc]init];
    [self presentViewController:regisVC animated:YES completion:nil];
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
