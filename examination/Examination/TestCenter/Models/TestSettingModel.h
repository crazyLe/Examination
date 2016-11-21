//
//  TestSettingModel.h
//  Examination
//
//  Created by LL on 16/9/14.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "CarTypeModel.h"
#import <Foundation/Foundation.h>

@interface TestSettingModel : NSObject

@property (nonatomic,strong) NSString *placeName;

@property (nonatomic,strong) NSString *placeAddress;

@property (nonatomic,strong) NSString *placeCar;

@property (nonatomic,strong) NSString *pic1;

@property (nonatomic,strong) NSString *pic2;

@property (nonatomic,strong) NSString *placePic1;

@property (nonatomic,strong) NSString *placePic2;

@property (nonatomic,strong) NSString *placePic3;

@property (nonatomic,strong) NSString *placePic4;

@property (nonatomic,strong) NSString *placePic5;

@property (nonatomic,strong) NSString *state;

@property (nonatomic,strong) NSArray <CarTypeModel *> *carTypeModelArr;

//检测存储的车型(placeCar)是否有效
- (BOOL)isValidCarType;
//通过车名设置车型
- (void)setCarTypeWithCarName:(NSString *)carName;

@end
