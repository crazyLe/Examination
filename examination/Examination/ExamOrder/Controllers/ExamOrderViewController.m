//
//  ExamOrderViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "ExamOrderModel.h"
#import "ExamOrderViewController.h"
#import "ExamOrderTableCell.h"

#define CUSTOM 10
#define PartitionNum 3.0
#define TopLineColor            [UIColor colorWithHexString:@"#817dfe"]

@interface ExamOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *topButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) ExamOrderType type ;

@property (nonatomic, strong) NSArray <ExamOrderModel*> *examOrderModelArr;


@property (nonatomic,strong) UITableView * orderTable;

@end

@implementation ExamOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"考场订单";

    [self createTopBtn];
    [self createTableView];
    
//    [self getOrderRequest];
}

- (void)createTopBtn
{
    
    if (self.numString == nil) {
        self.numString = @"0";
        _type = ExamOrderUntreated;
    }else if([self.numString isEqualToString:@"0"]){
        //        self.numString = @"0";
        _type = ExamOrderUntreated;
        //        _goodsType = 3;
    }else if([self.numString isEqualToString:@"1"]){
        //        self.numString = @"1";
        _type = ExamOrderAccepted;
        //        _goodsType = 6;
    }else if ([self.numString isEqualToString:@"2"]){
        //        self.numString = @"2";
        _type = ExamOrderCost;
        //        _goodsType = 7;
    }
    
    NSArray * imageArray = [NSArray arrayWithObjects:@"order_orangerUntreat",@"order_grayAccepted",@"order_grayCost", nil];
    NSArray *titleArray = [NSArray arrayWithObjects:@"未处理", @"已接受", @"已消费", nil];
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 4 * CUSTOM)];
    //    self.topView.backgroundColor = [UIColor redColor];
    for (int i = 0; i < 3; i++) {
        self.topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.topButton.frame = CGRectMake(kScreenWidth * i / PartitionNum, 0, kScreenWidth / PartitionNum, 4 * CUSTOM);
        [self.topButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.topButton setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        self.topButton.tag = 1000 + i;
        
        //        self.topButton.userInteractionEnabled = NO;
        self.topButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.topButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [self.topButton addTarget:self action:@selector(topButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
        self.topButton.backgroundColor = [UIColor whiteColor];
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 3.7 * CUSTOM, kScreenWidth / PartitionNum, 3.0)];
        if (self.topButton.tag == 1000 + [_numString integerValue]) {
            self.lineView.backgroundColor = TopLineColor;
        }
        //        if(self.topButton.tag == 1000 + ){
        //            self.lineView.backgroundColor = ECJiaDominantHue;
        //        }
        self.lineView.tag = 1100 + i;
        [self.topButton addSubview:_lineView];
        [self.topView addSubview:_topButton];
    }
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 3.9 * CUSTOM, kScreenWidth, 1.0)];
    colorView.backgroundColor = TopLineColor;
    [self.topView addSubview:colorView];
    [self.view addSubview:_topView];
    
}

//顶部按钮触发事件
- (void)topButtonTouch:(UIButton *)aButton {
    
    //    self.tableView.tag = 3000 + aButton.tag - 1000;
    //    NSInteger count = aButton.tag - 1000;
    //    [self getNetWorkData:[NSString stringWithFormat:@"%ld", (long)count]];
    
    //    if(_orderArray.count != 0){
    //        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    //    }
    
    for (UIButton *button in self.topView.subviews) {
        if (button.tag == aButton.tag) {
            //            [button setTitleColor:ECJiaDominantHue forState:UIControlStateNormal];
            for (UIView *view in button.subviews) {
                if (view.tag == button.tag + 100) {
                    view.backgroundColor = TopLineColor;
                }
            }
        } else {
            //            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            for (UIView *view in button.subviews) {
                if (view.tag > 1090 && view.tag < 1200) {
                    view.backgroundColor = [UIColor clearColor];
                }
            }
        }
        //        button.userInteractionEnabled = NO;
    }
    
//    [self getOrderRequest];
}

- (void)createTableView
{
    _orderTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 4*CUSTOM+64, kScreenWidth, kScreenHeight-64-4*CUSTOM-49) style:UITableViewStylePlain];
    _orderTable.delegate = self;
    _orderTable.dataSource = self;
    _orderTable.showsVerticalScrollIndicator = NO;
//    _orderTable.backgroundColor = RGBCOLOR(236, 237, 236);
//    _orderTable.backgroundColor = [UIColor cyanColor];
    _orderTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_orderTable];
    
    if (!kBeansShow) {
        UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无数据"]];
        _orderTable.backgroundView = bgImgView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 196;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kBeansShow?4:0;
//    return _examOrderModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"cell";
    ExamOrderTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ExamOrderTableCell" owner:self options:nil] lastObject];
    }
//    cell.backgroundColor = RGBCOLOR(236, 237, 236);
//    cell.backgroundColor = [UIColor cyanColor];
   
    /*
    ExamOrderModel *model = _examOrderModelArr[indexPath.row];
    
    cell.numberLabel.text = model.appointment_id;
    
    cell.priceLabel.text = model.total;
    
    cell.drivingSchoolLabel.text = model.pay_user;
    
    cell.remainTimeLabel.text = [NSString stringWithFormat:@"该时段剩余:%@",model.car_num];
    
    cell.orderTimeLabel.text = [NSString stringWithFormat:@"订单时间:%@",model.addtime];
    
    cell.fourthBtn.selected = model.coach_state;
    
    cell.thirdBtn.selected = [model.car_num intValue]>0;
    
    if ([model.price_type intValue]==1) {
        //按时
        cell.firstBtn.hidden = YES;
        cell.secondBtn.hidden = NO;
    }
    else
    {
        //按圈
        cell.firstBtn.hidden = NO;
        cell.secondBtn.hidden = YES;
    }
     */
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getOrderRequest
{
    NSString *relativeAdd = @"/appointment/order";
    NSDictionary *paraDic = @{@"uid":kUid,@"state":@(_type),@"time":kTimeStamp,@"sign":kSignWithIdentify(relativeAdd)};
    [NetworkEngine postRequestWithRelativeAdd:relativeAdd paraDic:paraDic completeBlock:^(BOOL isSuccess, id jsonObj) {
        if (isSuccess) {
            if (isEqualValue(jsonObj[@"code"], 1)) {
                //成功
                _examOrderModelArr = [ExamOrderModel mj_objectArrayWithKeyValuesArray:jsonObj[@"info"][@"order"]];
                [_orderTable reloadData];
            }
            else
            {
                [LLUtils showErrorHudWithStatus:jsonObj[@"msg"]];
            }
        }
        else
        {
            [LLUtils showErrorHudWithStatus:@"数据异常，请稍后重试"];
        }
    }];
}



@end
