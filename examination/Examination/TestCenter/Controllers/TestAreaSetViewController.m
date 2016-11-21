//
//  TestAreaSetViewController.m
//  Examination
//
//  Created by gaobin on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "CarTypeModel.h"
#import "TestSettingModel.h"
#import "TestAreaSetViewController.h"
#import "TestAreaSettingCell.h"
#import "TestAreaCollectionCell.h"
#import "TestAreaSubmitCell.h"


@interface TestAreaSetViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) TestSettingModel *settingModel; //考场设置model

@property (nonatomic, strong) NSArray *carTypeModelArr;

@end

@implementation TestAreaSetViewController
{
    NSArray *_sampleNameArr;
    NSArray *_sampleImgNameArr;
}

- (id)init
{
    if (self = [super init]) {
        _sampleNameArr    = @[@"营业执照",@"考场正门",@"车辆照片",@"考场全景"];
        _sampleImgNameArr = @[@"图层-66",@"图层-62",@"图层-64",@"图层-65"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI {
    
    [super initWithUI];
    
    self.title = @"考场设置";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"TestAreaSettingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TestAreaSettingCell"];
    [_tableView registerClass:[TestAreaSubmitCell class] forCellReuseIdentifier:@"TestAreaSubmitCell"];
    
}

- (void)initWithData
{
    [super initWithData];
    
    [self getCarTypeRequest];     //拉取车型列表
    [self getTestSettingRequest]; //拉取考场设置
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString * identifier = @"TestAreaSettingCell";
        
        TestAreaSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.delegate = self;
        
        _settingModel.carTypeModelArr = _carTypeModelArr;
        
        cell.settingModel = _settingModel;
        
//        cell.carTypeArr = _carTypeModelArr;
        
        return cell;
        
    }else {
        
        static NSString * identifier = @"TestAreaSubmitCell";
        
        TestAreaSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:240.0/255 alpha:1];
        cell.delegate = self;
        
        return cell;
        
    }

    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        return 16;
        
    }else {
        
        return 130;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
 
    return CGFLOAT_MIN;
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    if (indexPath.section == 0) {
        
         return 450;
        
    }else {
        
        return 110;
    }

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        
        UILabel * exampleLab = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 150, 18)];
        exampleLab.text = @"参考示例:";
        exampleLab.font = [UIFont systemFontOfSize:15];
        exampleLab.textColor = [UIColor colorWithHexString:@"#a2a2a2"];
        [bgView addSubview:exampleLab];
        
        //创建collectionView
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置列间距为5
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(24, 25, kScreenWidth - 24 -24, 75) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [bgView addSubview:_collectionView];
        [_collectionView registerNib:[UINib nibWithNibName:@"TestAreaCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TestAreaCollectionCell"];
        
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setImage:[UIImage imageNamed:@"icon_navbar_hamburger-拷贝-4"] forState:UIControlStateNormal];
        [bgView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_collectionView);
            make.left.offset(12);
            
        }];
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setImage:[UIImage imageNamed:@"icon_navbar_hamburger-拷贝-3"] forState:UIControlStateNormal];
        [bgView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_collectionView);
            make.right.offset(-12);
        }];
        
        return bgView;

    }
    return nil;
}
#pragma mark -- collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _sampleNameArr.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString * identifier = @"TestAreaCollectionCell";
    
    TestAreaCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.imgView.image = [UIImage imageNamed:_sampleImgNameArr[indexPath.item]];
    
    cell.nameLbl.text = _sampleNameArr[indexPath.item];
    
    return cell;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeMake((kScreenWidth -24 - 5*3 -24)/4, 80);
    return size;
    
    
}

- (void)TestAreaSubmitCell:(TestAreaSubmitCell *)cell clickBtn:(UIButton *)btn;
{
    NSString *promptStr = nil;
    if (isEmptyStr(_settingModel.placeCar) || ![_settingModel isValidCarType]) {
        promptStr = @"请选择车型";
    } else if ([self isEmptyImg:_settingModel.pic1]) {
        promptStr = @"请选择营业执照";
    }else if ([self isEmptyImg:_settingModel.pic2]) {
        promptStr = @"请选择审批资质";
    }else if ([self isEmptyImg:_settingModel.placePic1]) {
        promptStr = @"请选择考场正门";
    }else if ([self isEmptyImg:_settingModel.placePic2]) {
        promptStr = @"请选择车辆照片";
    }else if ([self isEmptyImg:_settingModel.placePic3]) {
        promptStr = @"请选择考场全景";
    }else if ([self isEmptyImg:_settingModel.placePic4]) {
        promptStr = @"请选择科目二设备";
    }else if ([self isEmptyImg:_settingModel.placePic5]) {
        promptStr = @"请选择科目三设备";
    }
    
    if (!isEmptyStr(promptStr)) {
        [LLUtils showErrorHudWithStatus:promptStr];
        return;
    }
    
    [self editRequest];
}

- (BOOL)isEmptyImg:(NSString *)img
{
    if (isNull(img)) {
        return YES;
    }
    else if ([img isKindOfClass:[NSString class]]) {
        return isEmptyStr(img);
    }
    return NO;
}

#pragma mark - Network

//考场设置拉取请求
- (void)getTestSettingRequest
{
    NSString *relativeAdd = @"/member/set";
    NSDictionary *paraDic = @{@"uid":kUid,@"time":kTimeStamp,@"sign":kSignWithIdentify(relativeAdd)};
    [NetworkEngine postRequestWithRelativeAdd:relativeAdd paraDic:paraDic completeBlock:^(BOOL isSuccess, id jsonObj) {
        if (isSuccess) {
            if (isEqualValue(jsonObj[@"code"], 1)) {
                //成功
                _settingModel = [TestSettingModel mj_objectWithKeyValues:jsonObj[@"info"]];
                NSLog(@"setting==>%@",jsonObj);
                [_tableView  reloadData];
            }
            else
            {
                
            }
        }
        else
        {
            
        }
    }];
}

//车型拉取请求
- (void)getCarTypeRequest
{
    NSString *relativeAdd = @"/getCar";
    NSDictionary *paraDic = @{@"uid":kUid,@"time":kTimeStamp,@"sign":kSignWithIdentify(relativeAdd),@"deviceInfo":kDeviceInfo};
    [NetworkEngine postRequestWithRelativeAdd:relativeAdd paraDic:paraDic completeBlock:^(BOOL isSuccess, id jsonObj) {
        if (isSuccess) {
            if (isEqualValue(jsonObj[@"code"], 1)) {
                //成功
                _carTypeModelArr = [CarTypeModel mj_objectArrayWithKeyValuesArray:jsonObj[@"info"][@"carType"]];
                NSLog(@"carTypeArr==>%@",jsonObj);
                [_tableView reloadData];
            }
            else
            {
                
            }
        }
        else
        {
            
        }
    }];
}

- (void)editRequest
{
    NSString *relativeAdd = @"/member/edit";
    NSDictionary *paraDic = @{@"uid":kUid,@"time":kTimeStamp,@"sign":kSignWithIdentify(relativeAdd),@"placeCar":_settingModel.placeCar};
    
    NSArray *bottomUploadImgArr = @[_settingModel.pic1?_settingModel.pic1:[NSNull null],_settingModel.pic2?_settingModel.pic2:[NSNull null],_settingModel.placePic1?_settingModel.placePic1:[NSNull null],_settingModel.placePic2?_settingModel.placePic2:[NSNull null],_settingModel.placePic3?_settingModel.placePic3:[NSNull null],_settingModel.placePic4?_settingModel.placePic4:[NSNull null],_settingModel.placePic5?_settingModel.placePic5:[NSNull null]];
    
    NSArray *picParaNameArr = @[@"pic1",@"pic2",@"placePic1",@"placePic2",@"placePic3",@"placePic4",@"placePic5"];
    
    NSMutableArray *serviceNameArr = [NSMutableArray array];
    NSMutableArray *fileNameArr = [NSMutableArray array];
    NSMutableArray *fileDataArr = [NSMutableArray array];
    for (int i = 0; i < bottomUploadImgArr.count; i++) {
        if ([bottomUploadImgArr[i] isKindOfClass:[UIImage class]]) {
            UIImage *img = bottomUploadImgArr[i];
            NSData * data = [LLUtils dataWithImage:img];
            if (isNull(data)) {
                continue;
            }
            [fileDataArr addObject:data];
            [serviceNameArr addObject:picParaNameArr[i]];
            [fileNameArr addObject:@"0.png"];
        }
        else if (([bottomUploadImgArr[i] isKindOfClass:[NSString class]]) && (!isEmptyStr(bottomUploadImgArr[i])))
        {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:bottomUploadImgArr[i]]];
            if (isNull(data)) {
                continue;
            }
            [fileDataArr addObject:data];
            [serviceNameArr addObject:picParaNameArr[i]];
            [fileNameArr addObject:@"0.png"];
        }
    }
    
    [LLUtils showOnlyProgressHud];
    
    [NetworkEngine UploadFileWithUrl:[HOST_ADDR stringByAppendingString:relativeAdd] param:paraDic serviceNameArr:serviceNameArr fileNameArr:fileNameArr mimeType:@"image/jpeg" fileDataArr:fileDataArr finish:^(NSData *data) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSInteger code = [dict[@"code"] integerValue];
        NSString * msg = dict[@"msg"];
        if (code == 1)
        {
            //成功
            [LLUtils showSuccessHudWithStatus:msg];
        }
        else
        {
            [LLUtils showErrorHudWithStatus:msg];
        }
        
    } failed:^(NSError *error) {
        [LLUtils showErrorHudWithStatus:@"请求异常，请稍后重试"];
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
