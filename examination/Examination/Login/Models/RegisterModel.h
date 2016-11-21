//
//  RegisterModel.h
//  KKXC_Franchisee
//
//  Created by gaobin on 16/8/16.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

@property (nonatomic, copy) NSString * provinceId;
@property (nonatomic, copy) NSString * cityId;
@property (nonatomic, copy) NSString * areaId;
//@property (nonatomic, copy) NSString * examRoomId;      //考场id
@property (nonatomic, copy) NSString * realName;        //负责人真实姓名

@property (nonatomic, copy) NSString * placeId;         //考场编号 自定义请填0
@property (nonatomic, copy) NSString * placeName;       //考场名称


@end
