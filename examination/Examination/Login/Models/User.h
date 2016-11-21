//
//  User.h
//  KZXC_Headmaster
//
//  Created by 翁昌青 on 16/8/9.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

 + (instancetype)sharedUser;

@property(strong,nonatomic)NSString *token;
@property(strong,nonatomic)NSString *uid;
@property(strong,nonatomic)NSString *face;
@property(strong,nonatomic)NSString *nickName;

@property(strong,nonatomic)NSString * phone;
@property(assign,nonatomic)int state;



+(instancetype)userWithDict:(NSDictionary *)dict;

@end
