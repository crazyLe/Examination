//
//  ManagerTableCell.m
//  Examination
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "ManagerTableCell.h"

@implementation ManagerTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_timeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_firstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_thirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_fourthBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    
    [_modifyBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,5.0 , 0.0, 0)];
    [_deleteBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,5.0 , 0.0, 0)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(listModel *)model
{
    _model = model;
    NSString *price;
    if ([model.price1 intValue]== 0) {
        price = model.price2;
        _secondBtn.selected = YES;

    }else
    {
        price = model.price1;
        _firstBtn.selected = YES;
    }
    
//    NSString *startime = [self getStamptimeWithString:model.begin_time andSec:1];
//    
//    NSString *endtime = [self getStamptimeWithString:model.end_time andSec:1];
    
    NSString * dateTime= [self getStamptimeWithString:model.begin_time andSec:4];
    NSString *startime = [self getStamptimeWithString:model.begin_time andSec:3];
    NSString *endtime = [self getStamptimeWithString:model.end_time andSec:3];
    
    [_timeBtn setTitle:[NSString stringWithFormat:@"%@ %@-%@",dateTime,startime,endtime] forState:UIControlStateNormal];
    
    _numberLabel.text = [NSString stringWithFormat:@"学时编号:%@",model.car_id];
    _price.text = [NSString stringWithFormat:@"¥%d",[price intValue]];
    
    BOOL isOwncar = (model.car_id == 0)?NO:YES;
    _thirdBtn.selected = isOwncar;
    
    _fourthBtn.selected = [model.coach_state boolValue];
    
}

- (IBAction)clickModifyBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickManagerTableCellModifyBtn:withListModel:)]) {
        [self.delegate clickManagerTableCellModifyBtn:_model.car_id withListModel:_model];
    }
}
- (IBAction)clickDeleteBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickManagerTableCellDeleteBtn:)]) {
        [self.delegate clickManagerTableCellDeleteBtn:_model.car_id];
    }
}




@end
