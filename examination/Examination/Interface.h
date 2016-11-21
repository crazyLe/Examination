//
//  Interface.h
//  KZXC_Headmaster
//
//  Created by gaobin on 16/9/8.
//  Copyright © 2016年 cqingw. All rights reserved.
//

#ifndef Interface_h
#define Interface_h

//https环境
//开发环境
//#define basicUrl @"http://192.168.5.216:81/index.php/place"
//生产环境
#define basicUrl @"https://www.kangzhuangxueche.com/index.php/place"

//校长端的
#define getAddressUrl @"https://www.kangzhuangxueche.com/index.php/school/getAddress"

//首页学时
#define getXueshiUrl basicUrl@"/appointment"

//编辑学时
#define editXueshiUrl basicUrl@"/appointment/edit"

//删除学时
#define delXueshiUrl basicUrl@"/appointment/del"

//获取考场列表
#define getExamRoomUrl basicUrl@"/getPlace"

//获取验证码
#define getValidateCode basicUrl@"/user/sendCode"

//注册
#define registerUrl basicUrl@"/user/register"

//用户是否注册检测
#define registerCheck basicUrl@"/user/exist"

//登录
#define loginUrl basicUrl@"/user/login"


#define HOST_ADDR basicUrl

//获取验证码
#define  getCode HOST_ADDR@"/user/sendCode"

//修改密码
#define modifyPassword HOST_ADDR@"/editPassword"

//修改手机号
#define modifyPhone HOST_ADDR@"/editPhone"

//助手账号设置
#define assistantSetting basicUrl@"/member/setassistant"

#endif /* Interface_h */
