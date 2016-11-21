//
//  ManagerTableCell.h
//  Examination
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"

@protocol ManagerTableCellDelegate <NSObject>

- (void)clickManagerTableCellModifyBtn:(NSString *)modify withListModel:(listModel *)model;
- (void)clickManagerTableCellDeleteBtn:(NSString *)deleteID;

@end

@interface ManagerTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatorImageView;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;
@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (nonatomic,assign) id<ManagerTableCellDelegate>delegate;

@property(strong,nonatomic)listModel *model;
@end
