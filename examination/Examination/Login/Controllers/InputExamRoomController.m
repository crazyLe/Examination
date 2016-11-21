//
//  InputExamRoomController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "InputExamRoomController.h"
#import "GroundMapController.h"

@interface InputExamRoomController ()<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView * backgroundImageV;
@property (nonatomic,strong) UITableView * examTable;
@property (nonatomic, strong) UITextField * examRoomTF;
@end

@implementation InputExamRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithUI];
    [self initWithData];
    
    [self setupNav:@"注册"];
}
- (void)setupNav:(NSString *)title
{
    UIView *barview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
//    barview.backgroundColor = NavBackColor;
    barview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barview];
    
    UILabel * lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, kWidth, 0.5)];
    lineLabel.backgroundColor = [UIColor colorWithHexString:@"#808080"];
    [barview addSubview:lineLabel];
    
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

- (void)initWithUI
{
    _backgroundImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroundImageV.backgroundColor = [UIColor cyanColor];
    _backgroundImageV.userInteractionEnabled = YES;
    _backgroundImageV.image = [UIImage imageNamed:@"Layer_back"];
    [self.view addSubview:_backgroundImageV];
    
    UILabel * chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 175, kScreenWidth-40, 17)];
    chooseLabel.text = @"请输入您的考场名称";
    chooseLabel.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    chooseLabel.textAlignment = NSTextAlignmentCenter;
    chooseLabel.font = Font18;
    [_backgroundImageV addSubview:chooseLabel];

    _examRoomTF = [[UITextField alloc] init];
    [_examRoomTF setBackground:[UIImage imageNamed:@"背景框"]];
    _examRoomTF.placeholder = @"请输入您的考场名称";
    [_examRoomTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _examRoomTF.layer.cornerRadius = 20.0;
    _examRoomTF.clipsToBounds = YES;
    _examRoomTF.delegate = self;
    _examRoomTF.layer.borderWidth = 0.5;
    _examRoomTF.layer.borderColor = [UIColor colorWithHexString:@"#7d7264"].CGColor;
    _examRoomTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_examRoomTF];
    [_examRoomTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.equalTo(chooseLabel.mas_bottom).offset(25);
        make.height.offset(44);
    }];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    _examRoomTF.leftView = paddingView;
    _examRoomTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    UIButton * nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(38, 466, kScreenWidth-38*2, 44);
    nextBtn.layer.cornerRadius = 20.0;
    nextBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(pressNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageV addSubview:nextBtn];
    
}

- (void)initWithData
{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = [UIColor colorWithHexString:@"#fe9a33"].CGColor;
}

- (void)pressNextBtn:(UIButton *)sender
{
    
    if (isEmptyStr(_examRoomTF.text)) {
        [LLUtils showErrorHudWithStatus:@"请输入您的考场名称"];
        return;
    }
    
    //用户是否注册检测
    NSString * url = registerCheck;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"placeName"] = _examRoomTF.text;
    paramDict[@"pushID"] = pushID;
    paramDict[@"time"] = timeStr;
    paramDict[@"sign"] = [NSString stringWithFormat:@"%@/user/exist%@",pushID,timeStr];
    
    [HJHttpManager PostRequestWithUrl:url param:paramDict finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"用户是否注册检测%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
        
            NSString * stateStr = [dict[@"info"][@"state"] stringValue];
            if ([stateStr isEqualToString:@"0"]) {
                //未注册
                
                _registerModel.placeId = @"0";
                _registerModel.placeName = _examRoomTF.text;
                
                GroundMapController * vc = [[GroundMapController alloc] init];
                vc.registerModel = _registerModel;
                [self presentViewController:vc animated:YES completion:nil];

                
            }else {
                
                [self.hudManager showErrorSVHudWithTitle:@"用户已存在" hideAfterDelay:1.0];
            }

            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
        
    } failed:^(NSError *error) {
        
        
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
