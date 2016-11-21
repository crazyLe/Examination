//
//  ManagerHoursViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "CYLTableViewPlaceHolder.h"
#import "ManagerHoursViewController.h"
#import "ManagerTableCell.h"
#import "AppendHoursViewController.h"
#import "MHFisrtTableCell.h"
#import "MHSecondTableCell.h"
#import "MHThirdTableCell.h"
#import "MHFourthTableCell.h"
#import "MHFifthTableCell.h"
#import "AppointmentModel.h"
#import "EarnExtraMoneyController.h"

@interface ManagerHoursViewController ()<UITableViewDataSource,UITableViewDelegate,ManagerTableCellDelegate,MHSecondTableCellDelegate,MHThirdTableCellDelegate,MHFourthTableCellDelegate,UIAlertViewDelegate>


{
//    int curpage;

    NSMutableArray *xueshiArr;
    NSInteger sub; //科目二2 科目三3
    listModel *curmodel;//点击的model
    NSString *xueshiID;
    NSString * _xueshiModifyID;
}
@property (nonatomic, strong) UIButton* payFirstBtn;
@property (nonatomic, strong) UIButton * paySecondBtn;
@property (nonatomic,strong) UITableView * managerTable;

@property (nonatomic, strong) UIButton *grayBackBtn;
//@property (nonatomic, strong) UIView * customView;
@property (nonatomic, strong) UITableView * customTable;

@property(strong,nonatomic)listModel * clickListModel;

@property (nonatomic, strong)NSMutableDictionary * modifyDict;

@end

@implementation ManagerHoursViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.grayBackBtn removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBCOLOR(236, 237, 236);
//    self.view.backgroundColor = [UIColor cyanColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"学时管理";
    
    sub = 2;
    
    _modifyDict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"id",@"",@"carNum",@"",@"price1",@"",@"price2",@"",@"coach_state",nil];
    
    [self initWithUI];
}

- (void)initWithUI
{
    
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 5, 70, 20);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"新增学时" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font13;
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    _payFirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payFirstBtn.frame = CGRectMake((kScreenWidth-134*2)/2, 12+64, 134, 30);
    [_payFirstBtn setTitle:@"科目二" forState:UIControlStateNormal];
    [_payFirstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_payFirstBtn setBackgroundImage:[UIImage imageNamed:@"1111"] forState:UIControlStateNormal];
    [_payFirstBtn setBackgroundColor:[UIColor colorWithHexString:@"fe9a33"]];
    _payFirstBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _payFirstBtn.tag = 100;
    [_payFirstBtn addTarget:self action:@selector(pressPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payFirstBtn];
    
    _paySecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _paySecondBtn.frame = CGRectMake((kScreenWidth-134*2)/2+134, 12+64, 134, 30);
    [_paySecondBtn setTitle:@"科目三" forState:UIControlStateNormal];
    [_paySecondBtn setTitleColor:[UIColor colorWithHexString:@"#fe9a33"] forState:UIControlStateNormal];
//    [_paySecondBtn setBackgroundImage:[UIImage imageNamed:@"2222"] forState:UIControlStateNormal];
    [_paySecondBtn setBackgroundColor:[UIColor whiteColor]];
    _paySecondBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _paySecondBtn.tag = 200;
    [_paySecondBtn addTarget:self action:@selector(pressPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_paySecondBtn];
    
    _managerTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64+54, kScreenWidth, kScreenHeight-64-54-49) style:UITableViewStylePlain];
    _managerTable.delegate = self;
    _managerTable.dataSource = self;
    _managerTable.showsVerticalScrollIndicator = NO;
    _managerTable.backgroundColor = RGBCOLOR(236, 237, 236);
//    _managerTable.backgroundColor = [UIColor cyanColor];
    _managerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_managerTable];
    
//    _managerTable.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        curpage = 0;
//        [self loadData];
//        [_managerTable.mj_header endRefreshing];
//    }];
//    
//    [_managerTable.mj_header beginRefreshing];
//    
//    _managerTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        curpage++;
//        [self loadData];
//        [_managerTable.mj_footer endRefreshing];
//    }];
    
    
//    [self loadData];
}

- (void)loadData
{
    NSString *timestr = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
//    param[@"uid"] = @"1";
    param[@"time"] = timestr;
    param[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    param[@"sign"] = [HttpParamManager getSignWithXUESHIIdentify:@"/appointment" time:timestr];
    param[@"subjectId"] = @(sub);
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    [HJHttpManager PostRequestWithUrl:getXueshiUrl param:param finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        NSString *msg = dict[@"msg"];
        int code = [dict[@"code"] intValue];
        if (1 == code) {
            [self.hudManager dismissSVHud];
            NSArray *temp = [dict[@"info"] objectForKey:@"appointment"];
            NSMutableArray *zz = [AppointmentModel mj_objectArrayWithKeyValuesArray:temp];
            NSLog(@"%@",zz);
            xueshiArr = zz;
            [_managerTable cyl_reloadData];
        }else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
    } failed:^(NSError *error) {
    }];
}

- (void)pressSaveBtn
{
//
//}
//-(void)editXUESHI
//{
    
    NSLog(@"点击保存%@",_modifyDict);
    
    NSString *timestr = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"uid"] = @"1";
    param[@"uid"] = kUid;
    param[@"time"] = timestr;
//    param[@"sign"] = [HttpParamManager getSignWithXUESHIIdentify:@"/appointment/edit" time:timestr];
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/appointment/edit" time:timestr addExtraStr:_xueshiModifyID];
    NSDictionary * dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:_xueshiModifyID,@"id",[_modifyDict objectForKey:@"carNum"],@"carNum",[_modifyDict objectForKey:@"price1"],@"price1",[_modifyDict objectForKey:@"price2"],@"price2",[_modifyDict objectForKey:@"coach_state"],@"coach_state",nil];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    [arr addObject:dict];
    param[@"content"] = [LLUtils jsonStrWithJSONObject:arr];
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    [HJHttpManager PostRequestWithUrl:editXueshiUrl param:param finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        NSString *msg = dict[@"msg"];
        int code = [dict[@"code"] intValue];
        if (1 == code) {
            [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:2.0 animaton:YES];
            [self.grayBackBtn removeFromSuperview];
            [self loadData];
        }else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
        
    } failed:^(NSError *error) {
//        [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
    }];
}

- (void)deleteXUESHI
{
    NSString *timestr = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"id"] = xueshiID;
    param[@"time"] = timestr;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/appointment/del" time:timestr];
    [self.hudManager showNormalStateSVHudWithTitle:@"加载中..." hideAfterDelay:100.0];
    [HJHttpManager PostRequestWithUrl:delXueshiUrl param:param finish:^(NSData *data) {
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"%@",dict);
        NSString *msg = dict[@"msg"];
        int code = [dict[@"code"] intValue];
        if (1 == code) {
            [self.hudManager showSuccessSVHudWithTitle:msg hideAfterDelay:2.0 animaton:YES];
            [self loadData];
        }else
        {
            [self.hudManager showErrorSVHudWithTitle:msg hideAfterDelay:1.0];
        }
    } failed:^(NSError *error) {
    }];
}

- (void)initWithData
{
    
}

- (void)rightBtnAction:(UIButton *)sender
{
//    AppendHoursViewController * vc = [[AppendHoursViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    EarnExtraMoneyController * vc = [[EarnExtraMoneyController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)pressPayBtn:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if(100 == tag)
    {
        [_payFirstBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payFirstBtn setBackgroundColor:[UIColor colorWithHexString:@"fe9a33"]];
        
        [_paySecondBtn setTitleColor:[UIColor colorWithHexString:@"fe9a33"] forState:UIControlStateNormal];
        [_paySecondBtn setBackgroundColor:[UIColor whiteColor]];
        sub = 2;
    }else
    {
        [_payFirstBtn setTitleColor:[UIColor colorWithHexString:@"fe9a33"] forState:UIControlStateNormal];
        [_payFirstBtn setBackgroundColor:[UIColor whiteColor]];
        
        [_paySecondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_paySecondBtn setBackgroundColor:[UIColor colorWithHexString:@"fe9a33"]];
        sub = 3;
    }
    [self loadData];
}

#pragma mark -- ManagerTableCellDelegate
- (void)clickManagerTableCellModifyBtn:(NSString *)modify withListModel:(listModel *)model
{
    NSLog(@"点击了修改按钮");
    _clickListModel = model;
    _xueshiModifyID = modify;
    [_modifyDict setObject:model.nums forKey:@"carNum"];
    [_modifyDict setObject:model.price1 forKey:@"price1"];
    [_modifyDict setObject:model.price2 forKey:@"price2"];
    [_modifyDict setObject:model.coach_state forKey:@"coach_state"];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIButton *grayBackBtn = [[UIButton alloc] init];
    grayBackBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    grayBackBtn.backgroundColor = [UIColor colorWithRed:25/255.0 green: 25/255.0 blue:25/255.0 alpha:0.5];
    //    clearBtn.backgroundColor = [UIColor brownColor];
    [window addSubview:grayBackBtn];
    [grayBackBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.grayBackBtn = grayBackBtn;
    
    
//    _customTable = [[UITableView alloc]initWithFrame:CGRectMake(32, (kScreenHeight-370)/2, kScreenWidth-32*2, 318) style:UITableViewStylePlain];
    _customTable = [[UITableView alloc]initWithFrame:CGRectMake((kScreenWidth-292)/2, (kScreenHeight-318)/2, 292, 318) style:UITableViewStylePlain];
//    CGRectMake((kScreenWidth-292)/2, (kScreenHeight-390)/2, 292, 390) style:UITableViewStylePlain];
    _customTable.delegate = self;
    _customTable.dataSource = self;
    _customTable.layer.cornerRadius = 8.0;
    _customTable.scrollEnabled = NO;
    _customTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [grayBackBtn addSubview:_customTable];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _customTable.frame.size.width, 32)];
    topView.backgroundColor = RGBCOLOR(255, 246, 235);
    _customTable.tableHeaderView = topView;
    
    UIButton * cancelBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(topView.frame.size.width-30-16, 8, 16, 16);
//    cancelBtn.backgroundColor = [UIColor redColor];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"Close-icon"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _customTable.frame.size.width, 76)];
    downView.backgroundColor = [UIColor whiteColor];
    _customTable.tableFooterView = downView;
    
    UIButton * saveBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake((_customTable.frame.size.width-193)/2, 76-42-16, 193, 42);
    saveBtn.layer.cornerRadius = 21.0;
    saveBtn.titleLabel.font = Font18;
    saveBtn.backgroundColor = [UIColor colorWithHexString:@"fe9a33"];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(pressSaveBtn) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:saveBtn];
    
}

- (void)clickManagerTableCellDeleteBtn:(NSString *)deleteID
{
    xueshiID = deleteID;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否删除该学时" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%lu",buttonIndex);
    if (1 == buttonIndex) {
        [self deleteXUESHI];
    }
}

- (void)cancelBtnClick
{
    [self.grayBackBtn removeFromSuperview];
}



#pragma mark -- MHSecondTableCellDelegate                //车辆
- (void)MHSecondTableCellClickBtn:(NSString *)str
{
    if ([str isEqualToString:@"提供"]) {
        NSLog(@"提供");
    }else if ([str isEqualToString:@"不提供"]){
        NSLog(@"不提供");
    }
}
- (void)MHSecondTableCellcarNumTF:(UITextField *)field
{
    NSLog(@"车辆：%@",field.text);
    
    [_modifyDict setObject:field.text forKey:@"carNum"];
    
//    if ([_type isEqualToString:@"1"]) {
//        _firstTypeModel.carNum = field.text;
//    }else if ([_type isEqualToString:@"2"]){
//        [_secondCustomDict setObject:field.text forKey:@"carNum"];
//    }else if ([_type isEqualToString:@"3"]){
//        [_customDict setObject:field.text forKey:@"carNum"];
//    }
    
}

#pragma mark -- MHThirdTableCellDelegate                       /教练
- (void)MHThirdTableCellClickBtn:(NSString *)str
{
    if ([str isEqualToString:@"提供"]) {
        NSLog(@"提供 教练");
        
        [_modifyDict setObject:@"1" forKey:@"coach_state"];
    }else if ([str isEqualToString:@"不提供"]){
        NSLog(@"不提供 教练");
        [_modifyDict setObject:@"0" forKey:@"coach_state"];
    }
}

#pragma mark -- MHFourthTableCellDelegate                     //费用
- (void)MHFourthTableCellClickBtn:(NSString *)str
{
    if ([str isEqualToString:@"按时收费"]) {
        NSLog(@"按时收费");
    }else if ([str isEqualToString:@"按圈收费"]){
        NSLog(@"按圈收费");
    }
}

- (void)MHFourthTableCellTF:(NSString *)str withTextfield:(UITextField *)field
{
    if ([str isEqualToString:@"按时收费"]) {
        
    [_modifyDict setObject:field.text forKey:@"price1"];
        
    }else if ([str isEqualToString:@"按圈收费"]){
        
    [_modifyDict setObject:field.text forKey:@"price2"];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _managerTable) {
//        return 195;
        return 157;
    }else if (tableView == _customTable){
        if (indexPath.row == 3) {
            return 78;
        }else{
            return 44;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _managerTable) {
        return xueshiArr.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _managerTable){
        AppointmentModel *model = [xueshiArr objectAtIndex:section];
        return model.list.count;
    }else if(tableView == _customTable){
        return 4;
    }
    return 0;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
     if (tableView == _managerTable) {
         return 25;
     }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _managerTable) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 0, kWidth - 40, 25)];
        view.backgroundColor = [UIColor colorWithHexString:@"#d9d9d9"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kWidth - 40, 25)];
        
        AppointmentModel *model = [xueshiArr objectAtIndex:section];
        label.textColor = [UIColor colorWithHexString:@"#888888"];
        label.text = model.day;
        [view addSubview:label];
        return view;
     }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger sec = [indexPath section];
    
    if (tableView == _managerTable) {
        static NSString * string = @"cellManager";
        ManagerTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ManagerTableCell" owner:self options:nil] lastObject];
        }
        AppointmentModel *model = [xueshiArr objectAtIndex:sec];
        cell.model = model.list[row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGBCOLOR(236, 237, 236);
        return cell;
        
    }else if (tableView == _customTable){
        if (indexPath.row == 0) {
            static NSString * string = @"cellone";                   //时段
            MHFisrtTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MHFisrtTableCell" owner:self options:nil]lastObject];
            }
//            cell.backgroundColor = [UIColor brownColor];
            cell.model = _clickListModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 1){
            static NSString * string = @"celltwo";                   //车辆
            MHSecondTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MHSecondTableCell" owner:self options:nil]lastObject];
            }
//            cell.backgroundColor = [UIColor brownColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            AppointmentModel *model = [xueshiArr objectAtIndex:sec];
//            cell.model = model.list[row];
            cell.model = _clickListModel;
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 2){                                //教练
            static NSString * string = @"cellthree";
            MHThirdTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MHThirdTableCell" owner:self options:nil]lastObject];
            }
//            cell.backgroundColor = [UIColor brownColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _clickListModel;
            cell.delegate = self;
            return cell;
        }else if (indexPath.row == 3){                               //费用
            static NSString * string = @"cellfour";
            MHFourthTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle]loadNibNamed:@"MHFourthTableCell" owner:self options:nil]lastObject];
            }
//            cell.backgroundColor = [UIColor brownColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = _clickListModel;
            cell.delegate = self;
//            cell.lineLabel.hidden = YES;
            return cell;
        }
//        else if (indexPath.row == 4){
//            static NSString * string = @"cellfive";
//            MHFifthTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
//            if (cell == nil) {
//                cell = [[[NSBundle mainBundle]loadNibNamed:@"MHFifthTableCell" owner:self options:nil]lastObject];
//            }
//            cell.backgroundColor = [UIColor brownColor];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
    }
    return nil;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    AppointmentModel *model = [xueshiArr objectAtIndex:indexPath.section];
//    curmodel = model.list[indexPath.row];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CYLTableViewPlaceHolderDelegate

- (UIView *)makePlaceHolderView;
{
    /*
    UIView *bgView = [UIView new];
    
    UILabel *promptLbl = [UILabel new];
    [bgView addSubview:promptLbl];
    NSMutableAttributedString *attStr = [NSMutableAttributedString attributeStringWithImg:[UIImage imageNamed:@"null"] bounds:CGRectMake(0, 0, 100, 100)];
    [attStr appendBreakLineWithInterval:20];
//    [attStr appendText:@"暂无数据" withAttributesArr:@[rgb(249, 117, 43)]];
    //    [attStr appendBreakLineWithInterval:3];
    //    [attStr appendText:@"可出租的教练车资源" withAttributesArr:@[rgb(249, 117, 43)]];
    promptLbl.attributedText = attStr;
    promptLbl.textAlignment = NSTextAlignmentCenter;
    promptLbl.numberOfLines = 0;
    
    //    UIButton *goPublicbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [bgView addSubview:goPublicbtn];
    //    [goPublicbtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.bottom.equalTo(bgView.mas_centerY);
    //        make.centerX.equalTo(promptLbl);
    //        make.width.offset(0.8*kScreenWidth);
    //        make.height.offset(40);
    //    }];
    //    goPublicbtn.layer.cornerRadius = 20;
    //    goPublicbtn.layer.masksToBounds = YES;
    //    [goPublicbtn setBackgroundColor:kAppThemeColor];
    //    [goPublicbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [goPublicbtn setTitle:segmentedControl.selectedSegmentIndex==1?@"去发布":@"刷新" forState:UIControlStateNormal];
    //    [goPublicbtn addTarget:self action:@selector(clickGoPublicBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [promptLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(-self.view.bounds.size.height/4);
    }];
    
    return bgView;
     */
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无数据"]];
}

//- (BOOL)enableScrollWhenPlaceHolderViewShowing;
//{
//    return YES;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
