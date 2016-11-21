//
//  BillViewController.m
//  Examination
//
//  Created by gaobin on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "BillViewController.h"
#import "BillCell.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}
- (void)initWithUI {
    
    [super initWithUI];
    self.title = @"账单";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"BillCell" bundle:nil] forCellReuseIdentifier:@"BillCell"];
    
    if (!kBeansShow) {
        UIImageView *bgImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无数据"]];
        _tableView.backgroundView = bgImgView;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return kBeansShow?2:0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 3;
    }else {
        
        return 1;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    
    if (indexPath.section == 0) {
        
        static NSString * identifier = @"BillCell";
        BillCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//        if (indexPath == 数组的个数-1) {
//            
//            cell.bottomLineView.hidden = YES;
//        }
        
        return cell;
    }else {
        
        static NSString * identifier = @"BillCell";
        BillCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//        if (indexPath == 数组的个数-1) {
//
//            cell.bottomLineView.hidden = YES;
//        }
        return cell;
        
    }
        
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 55;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    UIView * orangeView = [[UIView alloc] init];
    orangeView.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    orangeView.layer.cornerRadius = 3;
    orangeView.clipsToBounds = YES;
    [bgView addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.offset(10);
        make.width.offset(4);
        make.height.offset(14);
    }];
    
    UILabel * monthLab = [[UILabel alloc] init];
    monthLab.text = @"本月";
    monthLab.textColor = [UIColor colorWithHexString:@"#333333"];
    monthLab.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:monthLab];
    [monthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.equalTo(orangeView.mas_right).offset(14);
    }];
    
    return bgView;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}
-(void)initWithData {
    
    [super initWithData];
    
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
