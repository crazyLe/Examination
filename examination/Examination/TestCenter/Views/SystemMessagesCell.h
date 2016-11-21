//
//  SystemMessagesCell.h
//  Examination
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemMessagesCell : UITableViewCell

//@property (nonatomic,copy)NSString * titlelabel;
//
//@property (nonatomic,copy)NSString * contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *remindImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
