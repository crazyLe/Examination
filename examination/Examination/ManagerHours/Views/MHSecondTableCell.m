//
//  MHSecondTableCell.m
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "MHSecondTableCell.h"

@implementation MHSecondTableCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickFirstBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(MHSecondTableCellClickBtn:)]) {
        [_delegate MHSecondTableCellClickBtn:@"提供"];
    }
}
- (IBAction)clickSecondBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    _carNumTF.text = @"";
    if (_delegate && [_delegate respondsToSelector:@selector(MHSecondTableCellClickBtn:)]) {
        [_delegate MHSecondTableCellClickBtn:@"不提供"];
    }
}

- (void)setModel:(listModel *)model
{
    _model = model;
    if ([model.nums isEqualToString:@"-1"] || [model.nums isEqualToString:@"0"]) {
        [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        _carNumTF.text = @"";
    }else{
        [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        _carNumTF.text = _model.nums;
    }
}

- (void)carNumTFValueChange{
    NSLog(@"点击了车辆输入");
    if (_delegate && [_delegate respondsToSelector:@selector(MHSecondTableCellcarNumTF:)]) {
        [_delegate MHSecondTableCellcarNumTF:_carNumTF];
    }
}


@end
