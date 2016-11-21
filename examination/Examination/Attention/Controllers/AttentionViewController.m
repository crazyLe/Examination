//
//  AttentionViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AttentionViewController.h"
#import "AttentionViewCell.h"
#import "AttentionViewPhotoCell.h"
@interface AttentionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end


@implementation AttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGBCOLOR(236, 237, 236);
    self.title = @"关注度";
    [self createUI];
}

- (void)createUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight -64-49) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor colorWithHexString:@"ececec"];
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"SystemMsgCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SystemMsgCell"];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    else
    {
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kBeansShow?345:0.01f;
    }
    return 178;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identify = @"AttentionViewPhotoCell";
        
        if (!kBeansShow) {
            UITableViewCell *cell = [UITableViewCell new];
            return cell;
        }
        
        AttentionViewPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AttentionViewPhotoCell" owner:nil options:nil]lastObject];
        }
        
        return cell;
        
    }
    static NSString *identify = @"AttentionViewCell";
    
    AttentionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AttentionViewCell" owner:nil options:nil]lastObject];
    }
    if (indexPath.section == 1) {
        cell.titleLabel.text = @"考场主页浏览量";
    }
    else
    {
        cell.titleLabel.text = @"订单量统计";
    }
    cell.attentionLabel1.attributedText = [cell getAttentionViewCellStrWithString1:@"昨日:   " string2:@"258" string2Color:[UIColor colorWithHexString:@"666666"]];

    cell.attentionLabel2.attributedText = [cell getAttentionViewCellStrWithString1:@"上周:   " string2:@"188" string2Color:[UIColor colorWithHexString:@"666666"]];

    cell.attentionLabel3.attributedText = [cell getAttentionViewCellStrWithString1:@"上月:   " string2:@"2978" string2Color:[UIColor colorWithHexString:@"666666"]];


    cell.attentionLabel4.attributedText = [cell getAttentionViewCellStrWithString1:@"今日:   " string2:@"290" string2Color:[UIColor colorWithHexString:@"fe9133"]];
    
    cell.attentionLabel5.attributedText = [cell getAttentionViewCellStrWithString1:@"本周:   " string2:@"312" string2Color:[UIColor colorWithHexString:@"666666"]];
    
    cell.attentionLabel6.attributedText = [cell getAttentionViewCellStrWithString1:@"本月:   " string2:@"1245" string2Color:[UIColor colorWithHexString:@"666666"]];

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
