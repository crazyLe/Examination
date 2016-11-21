//
//  MHThirdTableCell.m
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "MHThirdTableCell.h"

@implementation MHThirdTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_firstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10.0, 0.0, 0)];
    
}

- (void)setModel:(listModel *)model
{
    _model = model;
    if ([model.coach_state isEqualToString:@"1"]) {
        [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    }else{
        [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)clickFirstBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(MHThirdTableCellClickBtn:)]) {
        [_delegate MHThirdTableCellClickBtn:@"提供"];
    }
}
- (IBAction)clickSecondBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(MHThirdTableCellClickBtn:)]) {
        [_delegate MHThirdTableCellClickBtn:@"不提供"];
    }
}


@end
