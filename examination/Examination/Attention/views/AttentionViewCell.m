//
//  AttentionViewCell.m
//  Examination
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AttentionViewCell.h"

@implementation AttentionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSMutableAttributedString *)getAttentionViewCellStrWithString1:(NSString *)numStr1 string2:(NSString *)numStr2 string2Color:(UIColor *)color {
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:numStr1];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, str.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0, str.length)];
    
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:numStr2];

    [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, str2.length)];
    [str2 addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str2.length)];

    
    [str appendAttributedString:str2];
    
    return str;

}

@end
