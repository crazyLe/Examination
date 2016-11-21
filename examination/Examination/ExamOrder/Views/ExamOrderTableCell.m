//
//  ExamOrderTableCell.m
//  Examination
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "ExamOrderTableCell.h"

@implementation ExamOrderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    [_timeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_firstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_thirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_fourthBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
