//
//  TestSettingModel.m
//  Examination
//
//  Created by LL on 16/9/14.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "TestSettingModel.h"

@implementation TestSettingModel

//检测存储的车型(placeCar)是否有效
- (BOOL)isValidCarType
{
    if (isEmptyArr(_carTypeModelArr)) {
        return NO;
    }
    else
    {
        BOOL isValid = NO;
        for (CarTypeModel *model in _carTypeModelArr) {
            if ([model.carId integerValue]==[_placeCar integerValue]) {
                isValid = YES;
            }
        }
        return isValid;
    }
}

//通过车名设置车型
- (void)setCarTypeWithCarName:(NSString *)carName
{
    for (CarTypeModel *model in _carTypeModelArr) {
        if ([model.carName rangeOfString:carName].location != NSNotFound) {
            _placeCar = model.carId;
            return;
        }
    }
}

@end
