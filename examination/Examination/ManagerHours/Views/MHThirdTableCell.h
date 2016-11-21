//
//  MHThirdTableCell.h
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"

@protocol MHThirdTableCellDelegate <NSObject>

- (void)MHThirdTableCellClickBtn:(NSString *)str;

@end

@interface MHThirdTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;

@property(strong,nonatomic)listModel *model;

@property (nonatomic, assign) id<MHThirdTableCellDelegate>delegate;

@end
