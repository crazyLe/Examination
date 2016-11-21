//
//  MHFisrtTableCell.m
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "MHFisrtTableCell.h"

@implementation MHFisrtTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(listModel *)model
{
    _model = model;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"HH:mm"];
    NSString *dateString1 = [dateFormat1 stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.begin_time doubleValue]]];
    
    NSString * dateString2 = [dateFormat1 stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.end_time doubleValue]]];
    _timeLabel .text = [NSString stringWithFormat:@"%@~%@",dateString1,dateString2];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
