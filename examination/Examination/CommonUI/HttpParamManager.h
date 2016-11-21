//
//  HttpParamManager.h
//  学员端
//
//  Created by zuweizhong  on 16/8/2.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParamManager : NSObject

+(NSString *)getCodeSignWithIdentify:(NSString *)identify time:(NSString *)time phone:(NSString *)phone;

+(NSString *)getSignWithIdentify:(NSString *)identify time:(NSString *)time;
//学时模块sign
+ (NSString *)getSignWithXUESHIIdentify:(NSString *)identify time:(NSString *)time;

+(NSString *)getUUID;

+(NSString *)getTime;

+(NSString *)getDeviceInfo;

+(NSInteger)getCurrentCityID;

+(NSInteger)getCurrentProvinceID;

/**
 *  经度
 */
+(NSString *)getLongitude;
/**
 *  纬度
 */
+(NSString *)getLatitude;


+(NSString *)getSignWithIdentify:(NSString *)identify time:(NSString *)time addExtraStr:(NSString *)extraStr;

@end
