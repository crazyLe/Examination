//
//  EarnExtraCell5.h
//  Examination
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarnAppointModel.h"

@protocol EarnExtraCell5Delegate <NSObject>

- (void)EarnExtraCell5ClickBtn:(NSString *)str;
- (void)EarnExtraCell5TF:(NSString *)str withTextfield:(UITextField *)field;

@end

@interface EarnExtraCell5 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UITextField *field1;
@property (weak, nonatomic) IBOutlet UITextField *field2;

@property (nonatomic, strong) EarnAppointModel * model;

@property (nonatomic, assign) id<EarnExtraCell5Delegate>delegate;

@end
