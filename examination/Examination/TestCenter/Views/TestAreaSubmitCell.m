//
//  TestAreaSubmitCell.m
//  Examination
//
//  Created by gaobin on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "TestAreaSubmitCell.h"

@implementation TestAreaSubmitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
;
        _loginBtn.layer.cornerRadius = 20.0;
        _loginBtn.backgroundColor = [UIColor colorWithHexString:@"#fe9a33"];
        [_loginBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[_loginBtn addTarget:self action:@selector(pressLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(.8);
            make.height.offset(50);
        }];
        
        [_loginBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
    
}

- (void)clickBtn:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(TestAreaSubmitCell:clickBtn:)]) {
        [_delegate TestAreaSubmitCell:self clickBtn:btn];
    }
}

@end
