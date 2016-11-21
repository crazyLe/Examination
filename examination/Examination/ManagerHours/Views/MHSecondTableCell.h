//
//  MHSecondTableCell.h
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "EarnAppointModel.h"
#import "AppointmentModel.h"

@protocol MHSecondTableCellDelegate <NSObject>

- (void)MHSecondTableCellClickBtn:(NSString *)str;
- (void)MHSecondTableCellcarNumTF:(UITextField *)field;

@end

@interface MHSecondTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UITextField *carNumTF;

@property(strong,nonatomic)listModel *model;

@property (nonatomic, assign) id<MHSecondTableCellDelegate>delegate;

@end
