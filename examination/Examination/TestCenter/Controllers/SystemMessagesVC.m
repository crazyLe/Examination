//
//  SystemMessagesVC.m
//  Examination
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "SystemMessagesVC.h"
#import "SystemMessagesCell.h"

@interface SystemMessagesVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * systemTable;

@end

@implementation SystemMessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI
{
    [super initWithUI];
    self.title = @"系统消息";
//    self.view.backgroundColor = kBackgroundColor;
    [self createUI];
    
}

- (void)createUI
{
    _systemTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    _systemTable.backgroundColor = kBackgroundColor;
    _systemTable.dataSource = self;
    _systemTable.delegate =self;
    _systemTable.showsVerticalScrollIndicator = NO;
    _systemTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_systemTable];
    
    
}

- (void)initWithData
{
    [super initWithData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * string = @"systemCell";
    SystemMessagesCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"SystemMessagesCell" owner:self options:nil]lastObject];
    if (cell == nil) {
        cell = [[SystemMessagesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
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
