//
//  AppendHoursViewController.m
//  Examination
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AppendHoursViewController.h"
#import <RDVTabBarController.h>

@interface AppendHoursViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * backScrollView;

@end

@implementation AppendHoursViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI
{
    [super initWithUI];
    self.title = @"新增学时";
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _backScrollView.backgroundColor = RGBCOLOR(244, 243, 244);
    _backScrollView.backgroundColor = [UIColor cyanColor];
    _backScrollView.delegate = self;
    _backScrollView.showsVerticalScrollIndicator =  NO;
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, 667);
    [self.view addSubview:_backScrollView];
    
    
    
}

- (void)initWithData
{
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
