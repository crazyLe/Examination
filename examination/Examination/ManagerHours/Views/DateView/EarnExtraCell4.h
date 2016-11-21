//
//  EarnExtraCell4.h
//  Examination
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarnAppointModel.h"

@protocol EarnExtraCell4Delegate <NSObject>

- (void)EarnExtraCell4ClickBtn:(NSString *)str;

@end

@interface EarnExtraCell4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;

@property (nonatomic, copy) EarnAppointModel * model;

@property (nonatomic, assign) id<EarnExtraCell4Delegate>delegate;

@end
