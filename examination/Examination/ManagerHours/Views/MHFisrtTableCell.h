//
//  MHFisrtTableCell.h
//  Examination
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentModel.h"

@interface MHFisrtTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(strong,nonatomic)listModel *model;

@end
