//
//  LastStepRegisterVC.h
//  Examination
//
//  Created by gaobin on 16/9/13.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterModel.h"
#import "cityModel.h"

@interface LastStepRegisterVC : UIViewController

@property (nonatomic, strong) cityModel * cityModel;
@property (strong, nonatomic) RegisterModel * registerModel;

@property (nonatomic, assign) BOOL isFromGroupMap;

@end
