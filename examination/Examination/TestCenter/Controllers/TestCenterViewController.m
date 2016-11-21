//
//  TestCenterViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AboutKZController.h"
#import "TestCenterViewController.h"
#import "TestCenterTableCell.h"
#import "WithdrawViewController.h"
//待删除
#import "LoginViewController.h"
#import "TestAreaSetViewController.h"
#import "BillViewController.h"

#import "SecurityAccountController.h"
#import "AssistantViewController.h"
#import "SystemMessagesVC.h"

@interface TestCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _dataInfoArr;
    NSMutableArray * _dataImageArr;
}
//@property (nonatomic,strong)UIScrollView * backScrollView;
@property (nonatomic,strong) UITableView * centerTable;


@end

@implementation TestCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"考场中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kBackgroundColor;
    [self initWithUI];
    [self initWithData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableReresh) name:kRefreshBeansShowNotification object:nil];
}

- (void)initWithUI
{
//    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _backScrollView.backgroundColor = RGBCOLOR(244, 243, 244);
//    //    _backScrollView.backgroundColor = [UIColor whiteColor];
//    _backScrollView.delegate = self;
//    _backScrollView.showsVerticalScrollIndicator =  NO;
//    _backScrollView.contentSize = CGSizeMake(kScreenWidth, 667);
//    [self.view addSubview:_backScrollView];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 217)];
    backView.backgroundColor = RGBCOLOR(244, 243, 244);
    
    
    UIImageView * topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, kScreenWidth-5*2, 175)];
//    topImageView.backgroundColor = [UIColor redColor];
    topImageView.image = [UIImage imageNamed:@"icon_gearImage"];
    topImageView.userInteractionEnabled = YES;
    [backView addSubview:topImageView];
    
    UILabel * amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(50-5, 46, 45, 17)];
//    amountLabel.backgroundColor = [UIColor cyanColor];
    amountLabel.text = @"余额:";
    amountLabel.font = Font16;
    amountLabel.textColor = [UIColor colorWithHexString:@"333333"];
    [topImageView addSubview:amountLabel];
    
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-173)/2-5, CGRectGetMaxY(amountLabel.frame)+19, 173, 30)];
    NSMutableAttributedString * priceStr = nil;
    priceStr = [[NSMutableAttributedString alloc]initWithString:@"0" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffa017"],NSFontAttributeName:[UIFont systemFontOfSize:36]}];
    [priceStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"元" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"],NSFontAttributeName:[UIFont systemFontOfSize:15]}]];
    priceLabel.attributedText = priceStr;
    priceLabel.textAlignment = NSTextAlignmentCenter;
//    priceLabel.backgroundColor = [UIColor orangeColor];
    [backView addSubview:priceLabel];
    
    UILabel * withDrawLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-44)/2-5, CGRectGetMaxY(priceLabel.frame)+38, 44, 20)];
    withDrawLabel.textAlignment = NSTextAlignmentCenter;
    withDrawLabel.text = @"提现";
    withDrawLabel.font = Font20;
    withDrawLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapWithDrawLabel:)];
    [withDrawLabel addGestureRecognizer:tap];
//    withDrawLabel.backgroundColor = [UIColor yellowColor];
    [backView addSubview:withDrawLabel];
    
    _centerTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    _centerTable.delegate = self;
    _centerTable.dataSource = self;
    _centerTable.showsVerticalScrollIndicator = NO;
    _centerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_centerTable];
    
    if (kBeansShow) {
        _centerTable.tableHeaderView = backView;
    }
}

- (void)initWithData
{
    _dataInfoArr = [[NSMutableArray alloc]initWithObjects:@"新消息",@"助理设置",@"考场设置",@"账单",@"账号安全",@"关于康庄", nil];
    _dataImageArr = [[NSMutableArray alloc]initWithObjects:@"text_news",@"text_zhuli",@"text_set",@"text_check",@"text_acount",@"text_about", nil];
}

- (void)tapWithDrawLabel:(UITapGestureRecognizer *)tap
{
    NSLog(@"提现");
    WithdrawViewController * vc = [[WithdrawViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"cell";
    TestCenterTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"TestCenterTableCell" owner:self options:nil]lastObject];
    }
    
    if (indexPath.row==6) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = [UIColor clearColor];
        UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cell.contentView addSubview:exitBtn];
        [exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(10, 20, 10, 20));
        }];
        exitBtn.backgroundColor = [UIColor colorWithHexString:@"ff5d5d"];
        exitBtn.layer.masksToBounds = YES;
        exitBtn.layer.cornerRadius = 19;
        [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [exitBtn setTitle:isLogin?@"退出登录":@"登录" forState:UIControlStateNormal];
        exitBtn.titleLabel.font = Font15;
        [exitBtn addTarget:self action:@selector(clickLogoutBtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        //    cell.backgroundColor = [UIColor magentaColor];
        cell.infoLabel.text = _dataInfoArr[indexPath.row];
        cell.avatorImageView.image = [UIImage imageNamed:_dataImageArr[indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            //新消息
            SystemMessagesVC * vc = [[SystemMessagesVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //助理设置
            AssistantViewController * vc = [[AssistantViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //进入考场设置界面
            TestAreaSetViewController * vc = [[TestAreaSetViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            //进入账单界面
            BillViewController * vc = [[BillViewController alloc] init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            SecurityAccountController * vc = [[SecurityAccountController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 5:
        {
            AboutKZController *aboutVC = [[AboutKZController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)clickLogoutBtn:(UIButton *)logoutBtn
{
//    if (isLogin) {
        //退出登录
        [kUserDefault setObject:@"0" forKey:@"isLogin"];
        //[_centerTable reloadRow:6 inSection:0 withRowAnimation:UITableViewRowAnimationFade];
        LoginViewController * vc = [[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
//    }
//    else
//    {
//        //登录
//        LoginViewController * vc = [[LoginViewController alloc]init];
//        [self presentViewController:vc animated:YES completion:nil];
//    }
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
