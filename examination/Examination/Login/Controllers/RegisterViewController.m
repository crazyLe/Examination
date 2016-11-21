//
//  RegisterViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "RegisterViewController.h"
#import "ChooseExamRoomController.h"
#import "ProvinceModel.h"
#import "RegisterModel.h"

@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *dataArr;
    //    所有市数组
    NSMutableArray *shiArr;
    //    所属区数组
    NSMutableArray *quArr;
    //    所有省数组
    NSMutableArray *totalArr;
    
    NSInteger _curtag;
}
@property (nonatomic,strong) UIImageView * backgroundImageV;
@property (strong, nonatomic) UITableView *table;
@property (nonatomic, strong) UITextField * provinceTF;
@property (nonatomic, strong) UITextField * cityTF;
@property (nonatomic, strong) UITextField * areaTF;
@property (nonatomic, strong) RegisterModel * registerModel;

@property (nonatomic, strong) UITextField * currentField;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registerModel = [[RegisterModel alloc] init];
    
    [self initWithUI];
    [self initWithData];
    [self initdata];
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
- (void)initdata
{
    NSArray *addressArr = kProvinceData;
    NSMutableArray *dataArray = [NSMutableArray  array];
    for (NSData *data in addressArr) {
        ProvinceModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [dataArray addObject:model];
    }
    totalArr = dataArray;
}

- (void)initShiData:(NSString *)shengname
{
    NSMutableArray *temp =[NSMutableArray array];
    for (ProvinceModel *model in totalArr) {
        if ([model.name hasPrefix:shengname]) {
            temp = model.citys;
            shiArr = temp;
            break;
        }
    }
}

- (void)initQuData:(NSString *)quname
{
    NSMutableArray *temp =[NSMutableArray array];
    for (CityModel *model in shiArr) {
        if ([model.name hasPrefix:quname]) {
            temp = model.countrys;
            quArr = temp;
            break;
        }
    }
}
- (void)initWithUI
{
    _backgroundImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backgroundImageV.backgroundColor = [UIColor cyanColor];
    _backgroundImageV.userInteractionEnabled = YES;
    _backgroundImageV.image = [UIImage imageNamed:@"Layer_back"];
    [self.view addSubview:_backgroundImageV];

    
    UILabel * chooseLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 176, kScreenWidth-40, 17)];
    chooseLabel.text = @"请选择您选择所在的城市";
    chooseLabel.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    chooseLabel.textAlignment = NSTextAlignmentCenter;
    chooseLabel.font = Font18;
    [_backgroundImageV addSubview:chooseLabel];
    

    //省
    _provinceTF = [[UITextField alloc] init];
    _provinceTF.enabled = NO;
    _provinceTF.placeholder = @"    请选择省";
    [_provinceTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    [_provinceTF setBackground:[UIImage imageNamed:@"背景框"]];
    _provinceTF.layer.cornerRadius = 20.0;
    _provinceTF.delegate = self;
    _provinceTF.tag = 1000;
    
    _provinceTF.clipsToBounds = YES;
    _provinceTF.layer.borderWidth = 0.5;
    _provinceTF.layer.borderColor = [UIColor colorWithHexString:@"#7d7264"].CGColor;
     _provinceTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_provinceTF];
    [_provinceTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.equalTo(chooseLabel.mas_bottom).offset(25);
        make.height.offset(44);
    }];
    UILabel * provinceLab = [[UILabel alloc] init];
    provinceLab.text = @"省";
    provinceLab.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_provinceTF addSubview:provinceLab];
    [provinceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_provinceTF);
        make.right.offset(-25);
    }];
    UIView * provinceView = [[UIView alloc] init];
    provinceView.backgroundColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_provinceTF addSubview:provinceView];
    [provinceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(provinceLab.mas_left).offset(-20);
        make.width.offset(1);
        make.height.offset(20);
        make.centerY.equalTo(_provinceTF);
    }];
    UIButton * provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [provinceBtn setImage:[UIImage imageNamed:@"triangle_orange"] forState:UIControlStateNormal];
    [provinceBtn addTarget:self action:@selector(triangleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    provinceBtn.tag = 100;
    [_backgroundImageV addSubview:provinceBtn];
    [provinceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_provinceTF);
        make.right.equalTo(provinceView.mas_left).offset(-10);
        make.width.offset(50);
        make.height.offset(25);

    }];
    [provinceBtn setContentEdgeInsets:UIEdgeInsetsMake(3, 15, 0, 0)];
    
    //市
    _cityTF = [[UITextField alloc] init];
    _cityTF.enabled = NO;
    _cityTF.placeholder = @"    请选择市";
    [_cityTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    [_cityTF setBackground:[UIImage imageNamed:@"背景框"]];
    _cityTF.layer.cornerRadius = 20.0;
    _cityTF.delegate = self;
    _cityTF.tag = 1010;
    
    _cityTF.clipsToBounds = YES;
    _cityTF.layer.borderWidth = 0.5;
    _cityTF.layer.borderColor = [UIColor colorWithHexString:@"#7d7264"].CGColor;
    _cityTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_cityTF];
    [_cityTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.equalTo(_provinceTF.mas_bottom).offset(22);
        make.height.offset(44);
    }];
    UILabel * cityLab = [[UILabel alloc] init];
    cityLab.text = @"市";
    cityLab.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_cityTF addSubview:cityLab];
    [cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cityTF);
        make.right.offset(-25);
    }];
    UIView * cityView = [[UIView alloc] init];
    cityView.backgroundColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_cityTF addSubview:cityView];
    [cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cityLab.mas_left).offset(-20);
        make.width.offset(1);
        make.height.offset(20);
        make.centerY.equalTo(_cityTF);
    }];
    UIButton * cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cityBtn setImage:[UIImage imageNamed:@"triangle_orange"] forState:UIControlStateNormal];
    [cityBtn addTarget:self action:@selector(triangleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cityBtn.tag = 101;
    [_backgroundImageV addSubview:cityBtn];
    [cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cityTF);
        make.right.equalTo(cityView.mas_left).offset(-10);
        make.width.offset(50);
        make.height.offset(25);
        
    }];
    [cityBtn setContentEdgeInsets:UIEdgeInsetsMake(3, 15, 0, 0)];
    
    //区
    _areaTF = [[UITextField alloc] init];
    _areaTF.enabled = NO;
    _areaTF.placeholder = @"    请选择区";
    [_areaTF setValue:[UIColor colorWithHexString:@"#acacac"] forKeyPath:@"_placeholderLabel.textColor"];
    [_areaTF setBackground:[UIImage imageNamed:@"背景框"]];
    _areaTF.layer.cornerRadius = 20.0;
    _areaTF.delegate = self;
    _areaTF.tag = 1020;
    
    _areaTF.clipsToBounds = YES;
    _areaTF.layer.borderWidth = 0.5;
    _areaTF.layer.borderColor = [UIColor colorWithHexString:@"#7d7264"].CGColor;
    _areaTF.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_backgroundImageV addSubview:_areaTF];
    [_areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(40);
        make.right.offset(-40);
        make.top.equalTo(_cityTF.mas_bottom).offset(22);
        make.height.offset(44);
    }];
    UILabel * areaLab = [[UILabel alloc] init];
    areaLab.text = @"区";
    areaLab.textColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_areaTF addSubview:areaLab];
    [areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_areaTF);
        make.right.offset(-25);
    }];
    UIView * areaView = [[UIView alloc] init];
    areaView.backgroundColor = [UIColor colorWithHexString:@"d1d1d1"];
    [_areaTF addSubview:areaView];
    [areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(areaLab.mas_left).offset(-20);
        make.width.offset(1);
        make.height.offset(20);
        make.centerY.equalTo(_areaTF);
    }];
    UIButton * areaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [areaBtn setImage:[UIImage imageNamed:@"triangle_orange"] forState:UIControlStateNormal];
    [areaBtn addTarget:self action:@selector(triangleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    areaBtn.tag = 102;
    [_backgroundImageV addSubview:areaBtn];
    [areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_areaTF);
        make.right.equalTo(areaView.mas_left).offset(-10);
        make.width.offset(50);
        make.height.offset(25);
        
    }];
    [areaBtn setContentEdgeInsets:UIEdgeInsetsMake(3, 15, 0, 0)];
    
    
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(38, 500, kScreenWidth-38*2, 44);
    loginBtn.layer.cornerRadius = 20.0;
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(pressLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backgroundImageV addSubview:loginBtn];
    
    
    
    _table =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = [UIColor colorWithHexString:@"000000"];
    [_backgroundImageV addSubview:_table];
    
    
}



- (void)triangleBtnClick:(UIButton *)btn {
    
    
    if (btn.tag == 100) {
        
        _curtag = 100;
        dataArr = totalArr;
        _table.frame = CGRectMake(50, CGRectGetMaxY(_provinceTF.frame), kScreenWidth - 50*2, 200);
        [_table reloadData];
        
    }
    if (btn.tag == 101) {
        
        _curtag = 101;
        dataArr = shiArr;
        _table.frame = CGRectMake(50, CGRectGetMaxY(_cityTF.frame), kScreenWidth - 50*2, 200);
        [_table reloadData];
        
    }
    if (btn.tag == 102) {
        
        _curtag = 102;
        dataArr = quArr;
        _table.frame = CGRectMake(50, CGRectGetMaxY(_areaTF.frame), kScreenWidth - 50*2, 200);
        [_table reloadData];
    }
    
    _currentField.layer.borderColor = [UIColor colorWithHexString:@"#7d7264"].CGColor;
    UITextField * field1 = [self.view viewWithTag:10*(btn.tag)];
    field1.layer.borderColor = [UIColor colorWithHexString:@"fe9a33"].CGColor;
    _currentField = field1;
    
}
#pragma mark -- tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    
    cell.textLabel.font = Font12;
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor colorWithHexString:@"000000"];
    
    if (100 == _curtag) {
        ProvinceModel *model = dataArr[indexPath.row];
        cell.textLabel.text = model.name;
        
    }
    else if (101 == _curtag) {
        CityModel *model = dataArr[indexPath.row];
        cell.textLabel.text = model.name;
    }
    else if (102 == _curtag) {
        CountryModel *model = dataArr[indexPath.row];
        cell.textLabel.text = model.name;
    }else
    {
        NSDictionary *dict = dataArr[indexPath.row];
        cell.textLabel.text = dict[@"short_name"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (100 == _curtag) {
        ProvinceModel *model = dataArr[indexPath.row];
        _provinceTF.text = [NSString stringWithFormat:@"    %@",model.name];
        _registerModel.provinceId = [NSString stringWithFormat:@"%d",model.idNum];
        [self initShiData:model.name];
    }
    if (_curtag == 101) {
        CityModel *model = dataArr[indexPath.row];
        _cityTF.text = [NSString stringWithFormat:@"    %@",model.name];
        _registerModel.cityId = [NSString stringWithFormat:@"%d",model.idNum];
        [self initQuData:model.name];
        
    }
    if (_curtag == 102) {
        CountryModel *model = dataArr[indexPath.row];
        _areaTF.text = [NSString stringWithFormat:@"    %@",model.name];
        _registerModel.areaId = [NSString stringWithFormat:@"%d",model.idNum];
        //[self loadSchool:[NSString stringWithFormat:@"%d",model.idNum]];
        
    }
    
    _table.frame = CGRectZero;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _table.frame = CGRectZero;
}
- (void)initWithData
{
    
}

- (void)pressLoginBtn:(UIButton *)sender
{
    
    if (_provinceTF.text.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择省份" hideAfterDelay:1.0];
        return;
    }
    if (_cityTF.text.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择城市" hideAfterDelay:1.0];
        return;
    }
    if (_areaTF.text.length == 0) {
        [self.hudManager showErrorSVHudWithTitle:@"请选择县区" hideAfterDelay:1.0];
        return;
    }

    ChooseExamRoomController * vc = [[ChooseExamRoomController alloc]init];
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
