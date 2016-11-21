//
//  ProgressViewController.m
//  Examination
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "ProgressViewController.h"
#import "ProgressTableCell.h"
#import "ProgressRejectTableCell.h"

@interface ProgressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * progressTable;

@end

@implementation ProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI
{
    [super initWithUI];
    self.title = @"提现进度";
    
    _progressTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    _progressTable.delegate = self;
    _progressTable.dataSource = self;
    _progressTable.showsVerticalScrollIndicator = NO;
    _progressTable.backgroundColor = RGBCOLOR(243, 242, 243);
    _progressTable.separatorColor = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_progressTable];
}

- (void)initWithData
{
    [super initWithData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 131;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString * string = @"cell";
        ProgressTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProgressTableCell" owner:self options:nil]lastObject];
        }
//        cell.backgroundColor = [UIColor cyanColor];
        return cell;
    }else if (indexPath.row == 1){

        static NSString * string = @"cellReject";
        ProgressRejectTableCell * cell = [tableView dequeueReusableCellWithIdentifier:string];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ProgressRejectTableCell" owner:self options:nil]lastObject];
        }
//        cell.backgroundColor = [UIColor cyanColor];
        return cell;
    }
    
    return nil;
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
