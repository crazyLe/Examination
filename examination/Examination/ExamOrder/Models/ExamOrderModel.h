//
//  ExamOrderModel.h
//  Examination
//
//  Created by LL on 16/9/18.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExamOrderModel : NSObject

@property (nonatomic,copy) NSString *order_id;

@property (nonatomic,copy) NSString *appointment_id;

@property (nonatomic,copy) NSString *total;

@property (nonatomic,copy) NSString *pay_user;

@property (nonatomic,copy) NSString *appointment_time;

@property (nonatomic,copy) NSString *price_type;

@property (nonatomic,copy) NSString *car_num;

@property (nonatomic,copy) NSString *coach_state;

@property (nonatomic,copy) NSString *addtime;

@end
