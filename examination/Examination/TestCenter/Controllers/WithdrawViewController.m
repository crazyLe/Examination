//
//  WithdrawViewController.m
//  Examination
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "WithdrawViewController.h"
#import "ProgressViewController.h"

@interface WithdrawViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView * backScrollView;

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithUI
{
    [super initWithUI];
    self.title = @"提现";
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 5, 70, 20);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"提现进度" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font13;
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [self createUI];
}

- (void)initWithData
{
    [super initWithData];
}

- (void)createUI
{
    _backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    _backScrollView.backgroundColor = RGBCOLOR(244, 243, 244);
//    _backScrollView.backgroundColor = [UIColor cyanColor];
    _backScrollView.delegate = self;
    _backScrollView.showsVerticalScrollIndicator =  NO;
    _backScrollView.contentSize = CGSizeMake(kScreenWidth, 667);
    [self.view addSubview:_backScrollView];
    
    UIImageView * topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 16, kScreenWidth, 242)];
//    topImageView.backgroundColor = [UIColor brownColor];
    topImageView.image = [UIImage imageNamed:@"withDraw_backImage"];
    topImageView.userInteractionEnabled = YES;
    [_backScrollView addSubview:topImageView];
    
    UILabel * amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 18, 70, 14)];
//    amountLabel.backgroundColor = [UIColor redColor];
    amountLabel.text = @"余额:";
    amountLabel.textColor = RGBCOLOR(44, 44, 44);
    amountLabel.font = Font15;
    [topImageView addSubview:amountLabel];
    
    UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(amountLabel.frame)+20, 18, 253, 16)];
//    priceLabel.backgroundColor = [UIColor orangeColor];
    NSMutableAttributedString * priceStr = nil;
    priceStr = [[NSMutableAttributedString alloc]initWithString:@"2000.00 " attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ff9933"],NSFontAttributeName:Font18}];
    [priceStr appendAttributedString:[[NSAttributedString alloc]initWithString:@"元" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(94, 94, 94),NSFontAttributeName:Font15}]];
    priceLabel.attributedText = priceStr;
    [topImageView addSubview:priceLabel];
    
    NSArray * arr1 = @[@"提  现:",@"开户行:",@"银行卡号:",@"开 户 名:"];
    for (int i=0; i<4; i++) {
        UILabel * infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(amountLabel.frame)+21+40*i, 70, 14)];
        infoLabel.text = arr1[i];
        infoLabel.textColor = RGBCOLOR(44, 44, 44);
        infoLabel.font = Font15;
//        infoLabel.backgroundColor = [UIColor redColor];
        [topImageView addSubview:infoLabel];
        
        UITextField * field = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(infoLabel.frame)+20, CGRectGetMaxY(amountLabel.frame)+12+40*i, 253, 33)];
//        field.backgroundColor = [UIColor orangeColor];
        field.borderStyle = UITextBorderStyleRoundedRect;
        [topImageView addSubview:field];
        
        if (i == 1) {
            UIButton * arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            arrowBtn.frame = CGRectMake(field.frame.size.width-44, 0, 44, field.frame.size.height);
            arrowBtn.backgroundColor = RGBCOLOR(195, 205, 218);
            [arrowBtn setImage:[UIImage imageNamed:@"withDraw_arrow"] forState:UIControlStateNormal];
            arrowBtn.layer.cornerRadius = 5.0;
            [arrowBtn addTarget:self action:@selector(pressArrowBtn:) forControlEvents:UIControlEventTouchUpInside];
            [field addSubview:arrowBtn];
        }
    }
    
    
    UIButton * applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    applyBtn.frame = CGRectMake(38, CGRectGetMaxY(topImageView.frame)+23, kScreenWidth-38*2, 44);
    applyBtn.layer.cornerRadius = 20.0;
    applyBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
    [applyBtn setTitle:@"申请提现" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyBtn addTarget:self action:@selector(pressApplyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:applyBtn];
    
    UIView * downView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(applyBtn.frame)+23, kScreenWidth, 160)];
//    downView.backgroundColor = [UIColor brownColor];
    downView.backgroundColor = [UIColor whiteColor];
    [_backScrollView addSubview:downView];
    
    UILabel * explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 16, 80, 16)];
    explainLabel.text = @"提现说明：";
    explainLabel.textColor = RGBCOLOR(44, 44, 44);
    explainLabel.font = Font16;
//    explainLabel.backgroundColor = [UIColor blueColor];
    [downView addSubview:explainLabel];
    
    UIImageView * lineImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(explainLabel.frame)+16, kScreenWidth, 1)];
    lineImageV.image = [UIImage imageNamed:@"manager_lineBack"];
    [downView addSubview:lineImageV];
    
    NSArray * newsArr1 = @[@"1.",@"2.",@"3.",@"4."];
    NSArray * newsArr2 = @[@"提现金额限整数",@"提现申请提交后一般12小时内到账，遇节假日顺延",@"提现暂不收取任何手续费",@"若提现超过48小时未到账时，请联系客服"];
    for (int i=0; i<4; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(lineImageV.frame)+12+24*i, kScreenWidth-12*2, 12)];
        NSMutableAttributedString * labelStr = nil;
        labelStr = [[NSMutableAttributedString alloc]initWithString:newsArr1[i] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ff9933"],NSFontAttributeName:Font13}];
        [labelStr appendAttributedString:[[NSAttributedString alloc]initWithString:newsArr2[i] attributes:@{NSForegroundColorAttributeName:RGBCOLOR(111, 111, 111),NSFontAttributeName:Font13}]];
        label.attributedText = labelStr;
//        label.backgroundColor = [UIColor purpleColor];
        [downView addSubview:label];
        
    }
    
}

- (void)rightBtnAction:(UIButton *)sender
{
    ProgressViewController * vc = [[ProgressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)pressArrowBtn:(UIButton *)sender
{
    
}

- (void)pressApplyBtn:(UIButton *)sender
{
    
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
