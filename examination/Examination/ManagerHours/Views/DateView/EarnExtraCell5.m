//
//  EarnExtraCell5.m
//  Examination
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "EarnExtraCell5.h"

@implementation EarnExtraCell5

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_firstBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,10.0 , 0.0, 0)];
    [_secondBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10.0, 0.0, 0)];
    
    _field1.tag = 100;
    _field2.tag = 200;
    
    UIView *leftVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 12, _field1.frame.size.height-4)];
    leftVeiw.backgroundColor = [UIColor clearColor];
    
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftVeiw.frame.size.width, leftVeiw.frame.size.height)];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.text = @"¥";
    leftLabel.font = Font15;
    leftLabel.textAlignment = NSTextAlignmentRight;
    leftLabel.textColor = [UIColor colorWithHexString:@"#ff9933"];
    [leftVeiw addSubview:leftLabel];
    _field1.leftView = leftVeiw;
    _field1.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 20, _field1.frame.size.height-4)];
    rightVeiw.backgroundColor = [UIColor clearColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightVeiw.frame.size.width, rightVeiw.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"/时";
    label.font = Font12;
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    [rightVeiw addSubview:label];
    _field1.rightView = rightVeiw;
    _field1.rightViewMode = UITextFieldViewModeAlways;
    [_field1 addTarget:self action:@selector(fieldEditChange:) forControlEvents:UIControlEventEditingChanged];
    
    
    UIView *leftVeiw2 = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 12, _field2.frame.size.height-4)];
    leftVeiw2.backgroundColor = [UIColor clearColor];
    
    UILabel * leftLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, leftVeiw2.frame.size.width, leftVeiw2.frame.size.height)];
    leftLabel2.backgroundColor = [UIColor clearColor];
    leftLabel2.text = @"¥";
    leftLabel2.font = Font15;
    leftLabel2.textAlignment = NSTextAlignmentRight;
    leftLabel2.textColor = [UIColor colorWithHexString:@"#ff9933"];
    [leftVeiw2 addSubview:leftLabel2];
    _field2.leftView = leftVeiw2;
    _field2.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightVeiw2 = [[UIView alloc] initWithFrame:CGRectMake(0, 2, 20, _field2.frame.size.height-4)];
    rightVeiw2.backgroundColor = [UIColor clearColor];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rightVeiw2.frame.size.width, rightVeiw2.frame.size.height)];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"/圈";
    label2.font = Font12;
    label2.textColor = [UIColor colorWithHexString:@"#666666"];
    [rightVeiw2 addSubview:label2];
    _field2.rightView = rightVeiw2;
    _field2.rightViewMode = UITextFieldViewModeAlways;
    [_field2 addTarget:self action:@selector(fieldEditChange:) forControlEvents:UIControlEventEditingChanged];
    
    
}

- (void)fieldEditChange:(UITextField *)field
{
    if (field.tag == 100) {
        if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell5TF:withTextfield:)]) {
            [_delegate EarnExtraCell5TF:@"按时收费" withTextfield:field];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell5TF:withTextfield:)]) {
            [_delegate EarnExtraCell5TF:@"按圈收费" withTextfield:field];
        }
    }
}

- (void)setModel:(EarnAppointModel *)model
{
    _model = model;
    if ([model.price1 floatValue] > 0) {
        [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        _field1.text = @"";
        _field2.text = [NSString stringWithFormat:@"%d",[model.price1 intValue]];
    }else if ([model.price2 floatValue] >0){
        [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
        [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
        _field1.text = [NSString stringWithFormat:@"%d",[model.price2 intValue]];
        _field2.text = @"";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickFirstBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    _field2.text = @"";
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell5ClickBtn:)]) {
        [_delegate EarnExtraCell5ClickBtn:@"按时收费"];
    }
}
- (IBAction)clickSecondBtn:(id)sender {
    [_firstBtn setImage:[UIImage imageNamed:@"manager_gray1.png"] forState:UIControlStateNormal];
    [_secondBtn setImage:[UIImage imageNamed:@"manager_orange1.png"] forState:UIControlStateNormal];
    _field1.text = @"";
    if (_delegate && [_delegate respondsToSelector:@selector(EarnExtraCell5ClickBtn:)]) {
        [_delegate EarnExtraCell5ClickBtn:@"按圈收费"];
    }
}

@end
