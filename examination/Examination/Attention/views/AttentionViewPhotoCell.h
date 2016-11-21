//
//  AttentionViewPhotoCell.h
//  Examination
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSLineChart.h"
@interface AttentionViewPhotoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet FSLineChart *chartView;

@property (strong, nonatomic)NSMutableArray *chatData;

@end
