//
//  AppointmentModel.h
//  Examination
//
//  Created by 翁昌青 on 16/9/18.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class listModel;

@interface AppointmentModel : NSObject
@property(copy,nonatomic)NSString *day;
@property(strong,nonatomic)NSMutableArray <listModel *> *list;
@end

@interface listModel : NSObject
@property(copy,nonatomic)NSString *begin_time;
@property(copy,nonatomic)NSString *coach_state;
@property(copy,nonatomic)NSString *end_time;
@property(copy,nonatomic)NSString *car_id;
@property(copy,nonatomic)NSString *nums;
@property(copy,nonatomic)NSString *price1;
@property(copy,nonatomic)NSString *price2;
@property(copy,nonatomic)NSString *subjectId;

@end
