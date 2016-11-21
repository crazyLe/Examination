//
//  AttentionViewCell.h
//  Examination
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionViewCell : UITableViewCell


- (NSMutableAttributedString *)getAttentionViewCellStrWithString1:(NSString *)numStr1 string2:(NSString *)numStr2 string2Color:(UIColor *)color;

@property (weak, nonatomic) IBOutlet UILabel *attentionLabel1;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel3;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel4;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel5;
@property (weak, nonatomic) IBOutlet UILabel *attentionLabel6;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
