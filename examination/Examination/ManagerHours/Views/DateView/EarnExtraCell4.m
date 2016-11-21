//
//  EarnExtraCell4.m
//  Examination
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "EarnExtraCell4.h"

@implementation EarnExtraCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_firstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10.0, 0.0, 0)];
    
}

- (void)setModel:(EarnAppointModel *)model
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
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell4ClickBtn:)]) {
        [_delegate EarnExtraCell4ClickBtn:@"提供"];
    }
}
- (IBAction)clickSecondBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell4ClickBtn:)]) {
        [_delegate EarnExtraCell4ClickBtn:@"不提供"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
