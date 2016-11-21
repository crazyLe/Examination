//
//  AppointmentModel.m
//  Examination
//
//  Created by 翁昌青 on 16/9/18.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "AppointmentModel.h"

@implementation AppointmentModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"list":[listModel class]};
}
@end

@implementation listModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"car_id":@"id"};
}
@end
