//
//  EarnExtraCell3.h
//  Examination
//
//  Created by apple on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarnAppointModel.h"

@protocol EarnExtraCell3Delegate <NSObject>

- (void)EarnExtraCell3ClickBtn:(NSString *)str;
- (void)EarnExtraCell3carNumTF:(UITextField *)field;

@end

@interface EarnExtraCell3 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UITextField *carNumTF;
- (IBAction)clickFirstBtn:(id)sender;
- (IBAction)clickSecondBtn:(id)sender;

@property (nonatomic, copy) EarnAppointModel * model;

@property (nonatomic, assign) id<EarnExtraCell3Delegate>delegate;

@end
