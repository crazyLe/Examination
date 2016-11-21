//
//  EarnExtraCell3.m
//  Examination
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "EarnExtraCell3.h"

@implementation EarnExtraCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_firstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10.0, 0.0, 0)];
    
    UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(-5, 2, 15, _carNumTF.frame.size.height-4)];
    rightVeiw.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightVeiw.frame.size.width, rightVeiw.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"辆";
    label.font = Font12;
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    [rightVeiw addSubview:label];
    
    _carNumTF.rightView = rightVeiw;
    _carNumTF.rightViewMode = UITextFieldViewModeAlways;
    [_carNumTF addTarget:self action:@selector(carNumTFValueChange) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)setModel:(EarnAppointModel *)model
{
    _model = model;
    
    if ([model.carNum isEqualToString:@"0"] || [model.carNum isEqualToString:@"-1"]) {
        [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        _carNumTF.text = @"";
    }else{
        [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        _carNumTF.text = _model.carNum;
    }
}

- (void)carNumTFValueChange{
    NSLog(@"点击了车辆输入");
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell3carNumTF:)]) {
        [_delegate EarnExtraCell3carNumTF:_carNumTF];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickFirstBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell3ClickBtn:)]) {
        [_delegate EarnExtraCell3ClickBtn:@"提供"];
    }
}

- (IBAction)clickSecondBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    _carNumTF.text = @"";
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell3ClickBtn:)]) {
        [_delegate EarnExtraCell3ClickBtn:@"不提供"];
    }
}
@end
