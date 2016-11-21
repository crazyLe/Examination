//
//  ChooseExamRoomController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "ChooseExamRoomController.h"
#import "InputExamRoomController.h"
#import "ExamRoomModel.h"
#import "GroundMapController.h"
#import "LastStepRegisterVC.h"

@interface ChooseExamRoomController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView * backgroundImageV;
@property (nonatomic, strong) UITextField * examRoomTF;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) ExamRoomModel * examRoom;

@end

@implementation ChooseExamRoomController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray array];
    
    
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
    chooseLabel.text = @"请选择您的城市考场";
    chooseLabel.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    chooseLabel.textAlignment = NSTextAlignmentCenter;
    chooseLabel.font = Font18;
    [_backgroundImageV addSubview:chooseLabel];
    
    
    _examRoomTF = [[UITextField alloc] init];
    _examRoomTF.enabled = NO;
    [_examRoomTF setBackground:[UIImage imageNamed:@"背景框"]];
    _examRoomTF.placeholder = @"    请选择";
    [_examRoomTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    _examRoomTF.layer.cornerRadius = 20.0;
    _examRoomTF.tag = 100;
    _examRoomTF.clipsToBounds = YES;
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

    UIButton * examRoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [examRoomBtn setImage:[UIImage imageNamed:@"triangle_orange"] forState:UIControlStateNormal];
    [examRoomBtn addTarget:self action:@selector(examRoomBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageV addSubview:examRoomBtn];
    [examRoomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_examRoomTF);
        make.right.offset(-60);
        make.width.offset(50);
        make.height.offset(25);
    }];
    [examRoomBtn setContentEdgeInsets:UIEdgeInsetsMake(3, 15, 0, 0)];
    
    
    
    UILabel * topRemindLab = [[UILabel alloc] init];
    topRemindLab.text = @"您选择的考场已被注册";
    topRemindLab.textColor = [UIColor colorWithHexString:@"e5882c"];
    topRemindLab.font = Font15;
    topRemindLab.textAlignment = NSTextAlignmentCenter;
    [_backgroundImageV addSubview:topRemindLab];
    [topRemindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundImageV);
        make.top.equalTo(_examRoomTF.mas_bottom).offset(40);
    }];
    UILabel * bottomRemindLab = [[UILabel alloc] init];
    bottomRemindLab.text = @"如有疑问请联系客服400-800-6533";
    bottomRemindLab.textColor = [UIColor colorWithHexString:@"e5882c"];
    bottomRemindLab.font = Font15;
    bottomRemindLab.textAlignment = NSTextAlignmentCenter;
    [_backgroundImageV addSubview:bottomRemindLab];
    [bottomRemindLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_backgroundImageV);
        make.top.equalTo(topRemindLab.mas_bottom).offset(10);
    }];
    

    UIButton * otherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    otherBtn.layer.cornerRadius = 20.0;
    otherBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [otherBtn setTitle:@"以上没有我的考场" forState:UIControlStateNormal];
    [otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [otherBtn addTarget:self action:@selector(pressOtherBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageV addSubview:otherBtn];
    [otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(44);
        make.left.offset(38);
        make.right.offset(-38);
        make.top.equalTo(bottomRemindLab.mas_bottom).offset(130);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"000000"];
    [_backgroundImageV addSubview:_tableView];
    
}
- (void)examRoomBtnClick {
    
    UITextField * field = [self.view viewWithTag:100];
    field.layer.borderColor = [UIColor colorWithHexString:@"#fe9a33"].CGColor;

    
    NSString * url = getExamRoomUrl;
    NSMutableDictionary * paramDic = [NSMutableDictionary dictionary];
    paramDic[@"time"] = [HttpParamManager getTime];
    paramDic[@"cityId"] = _registerModel.cityId;
    paramDic[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    paramDic[@"pushID"] = pushID;
    paramDic[@"sign"] = [NSString stringWithFormat:@"%@/getPlace%@",pushID,[HttpParamManager getTime]];
    
    [HJHttpManager PostRequestWithUrl:url param:paramDic finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"驾校列表%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1) {
            
            NSArray * infoArray = dict[@"info"];
            _dataArray  = [ExamRoomModel mj_objectArrayWithKeyValuesArray:infoArray];
            
            _tableView.frame = CGRectMake(50, CGRectGetMaxY(_examRoomTF.frame), kScreenWidth - 50*2, 200);
            
            [_tableView reloadData];
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
        
    } failed:^(NSError *error) {
        
        [self.hudManager showErrorSVHudWithTitle:@"加载失败" hideAfterDelay:1.0];
        
    }];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = Font12;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithHexString:@"000000"];
    ExamRoomModel * examRoom = _dataArray[indexPath.row];
    cell.textLabel.text = examRoom.name;
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ExamRoomModel * examRoom = _dataArray[indexPath.row];
    
    //用户是否注册检测
    NSString * url = registerCheck;
    NSString * timeStr = [HttpParamManager getTime];
    
    NSMutableDictionary * paramDict = [NSMutableDictionary dictionary];
    paramDict[@"placeName"] = examRoom.name;
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
                _examRoomTF.text = [NSString stringWithFormat:@"    %@",examRoom.name];
                
                _registerModel.placeId = examRoom.idStr;
                _registerModel.placeName = examRoom.name;
                
                _tableView.frame = CGRectZero;
                
                LastStepRegisterVC * vc = [[LastStepRegisterVC alloc] init];
                vc.registerModel = _registerModel;
                vc.isFromGroupMap = NO;
                [self presentViewController:vc animated:YES completion:nil];
//                GroundMapController * vc = [[GroundMapController alloc] init];
//                vc.registerModel = _registerModel;
//                [self presentViewController:vc animated:YES completion:nil];
                
            }else {
                
                _tableView.frame = CGRectZero;
                [self.hudManager showErrorSVHudWithTitle:@"用户已存在" hideAfterDelay:1.0];
            }

            
        }else {
            
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
        
        
    } failed:^(NSError *error) {
        
        
    }];

    
    
}
- (void)initWithData
{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _tableView.frame = CGRectZero;
}
- (void)pressOtherBtn:(UIButton *)sender
{
    InputExamRoomController * vc = [[InputExamRoomController alloc]init];
    _registerModel.placeId = @"0";
    vc.registerModel = _registerModel;
    [self presentViewController:vc animated:YES completion:nil];
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
