//
//  MHFourthTableCell.h
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"

@protocol MHFourthTableCellDelegate <NSObject>

- (void)MHFourthTableCellClickBtn:(NSString *)str;
- (void)MHFourthTableCellTF:(NSString *)str withTextfield:(UITextField *)field;

@end

@interface MHFourthTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UITextField *field1;
@property (weak, nonatomic) IBOutlet UITextField *field2;

@property(strong,nonatomic)listModel *model;

@property (nonatomic, assign) id<MHFourthTableCellDelegate>delegate;

@end
