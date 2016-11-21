//
//  Header.h
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#ifndef Header_h
#define Header_h


#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//是否是iphone6以上设备
#define isUpIPhone6 ([UIScreen mainScreen].bounds.size.width > 320)

#define isIPhone6 ([UIScreen mainScreen].bounds.size.height == 667)

#define isIPhone5 ([UIScreen mainScreen].bounds.size.height == 568)

#define isIPhpne4 ([UIScreen mainScreen].bounds.size.height == 480)

#define kWidth kScreenWidth
#define kHeight kScreenHeight

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define rgb(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define NavBackColor RGBCOLOR(253, 153, 20)

#define CommonButtonBGColor RGBCOLOR(255,104,103)

#define ColorSix    RGBCOLOR(102,102,102)

#define ButtonH 44
//验证界面
#define validationPhoneNum @"400-800-6533"

//粗体
#define BoldFontWithSize(f) [UIFont fontWithName:@"Helvetica-Bold" size:f]

#define kBackgroundColor [UIColor colorWithHexString:@"f6f6f6"] //所有界面默认背景颜色
#define kAPPThemeColor [UIColor colorWithHexString:@"fe9a33"] //app橙色主题色
/************字体大小************/
#define Font10 [UIFont systemFontOfSize:10.0]
#define Font11 [UIFont systemFontOfSize:11.0]
#define Font12 [UIFont systemFontOfSize:12.0]
#define Font13 [UIFont systemFontOfSize:13.0]
#define Font14 [UIFont systemFontOfSize:14.0]
#define Font15 [UIFont systemFontOfSize:15.0]
#define Font16 [UIFont systemFontOfSize:16.0]
#define Font17 [UIFont systemFontOfSize:17.0]
#define Font18 [UIFont systemFontOfSize:18.0]
#define Font19 [UIFont systemFontOfSize:19.0]
#define Font20 [UIFont systemFontOfSize:20.0]
#define Font22 [UIFont systemFontOfSize:22.0]


#define kUserDefault [NSUserDefaults standardUserDefaults]

#define WeakObj(o) __weak typeof(o) o##Weak = o;

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO
/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certificate @"www.kangzhuangxueche.com"

//空判断相关
#define isEmptyStr(str) (!str||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@""]) //判断是否空字符串
#define isEmptyArr(arr) (!arr||((NSArray *)arr).count==0) //判断是否空数组
#define isNull(str)     (!str||[str isKindOfClass:[NSNull class]])

#define isEqualValue(String_Number,Integer) ([String_Number integerValue]==Integer) //判断参数1与参数2是否相等 适用于NSNumber,NSString类型与整型判断


/****************自定义日志输出****************/
#ifdef DEBUG
#define CGLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define CGLog(...)
#endif

//单例声明
#define singletonInterface(className) + (instancetype)shared##className;
//单例实现
#define singletonImplementation(className)\
static className *_instance;\
+ (id)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##className\
{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone\
{\
return _instance;\
}

#define pushID [[UIDevice currentDevice] identifierForVendor].UUIDString

#define curDefaults [NSUserDefaults standardUserDefaults]

//时间戳
#define kTimeStamp [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]]

//UUID设备唯一标示
#define kUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]
//设备信息
#define kDeviceInfo [NSString stringWithFormat:@"%@,%@",[UIDevice currentDevice].model,[[UIDevice currentDevice] systemVersion]]
//用户ID
#define kUid [kUserDefault objectForKey:@"kUid"]
//令牌
#define kToken [kUserDefault objectForKey:@"kToken"]
//签名
#define kSignWithIdentify(identifier) [[NSString stringWithFormat:@"%@%@%@%@%@",kUUID,identifier,kUid,kToken,kTimeStamp] md5String]
//#define kSignWithIdentify(identifier) [NSString get32BitMD5_lowercaseString:[NSString stringWithFormat:@"%@%@%@%@%@",kUUID,identifier,kUid,kToken,kTimeStamp]]

#define kSignIdentifyWithStr(identifier,string) [[NSString stringWithFormat:@"%@%@%@%@%@%@",kUUID,identifier,kUid,kToken,kTimeStamp,string] md5String]
//推送ID
#define kPushId kUUID
//#define kPushId @"ios"//暂用
//登录通道
#define kLoginChannel [kUserDefault objectForKey:@"kLoginChannel"]
//用户手机号
#define kPhone [kUserDefault objectForKey:@"kPhone"]
//用户真实姓名
#define kRealName [kUserDefault objectForKey:@"kRealName"]
//用户昵称
#define kNickName [kUserDefault objectForKey:@"kNickName"]
//用户头像
#define kFace [kUserDefault objectForKey:@"kFace"]
//用户认证状态
#define kAuthState [kUserDefault objectForKey:@"kState"]
//是否登录
#define isLogin [[kUserDefault objectForKey:@"isLogin"] isEqualToString:@"1"]
//是否首次启动APP
#define isFirstLaunch ![[kUserDefault objectForKey:@"isFirstLaunch"] isEqualToNumber:@(YES)]

//市字典
#define kCityDict [curDefaults objectForKey:@"cityDict"]
//省字典
#define kProvinceDict [curDefaults objectForKey:@"provinceDict"]
//县字典
#define kCountryDict [curDefaults objectForKey:@"countryDict"]
//
#define kProvinceData [curDefaults objectForKey:@"addressArray"]

//基本类型转String/Number
#define integerToStr(para) [NSString stringWithFormat:@"%ld",para]
#define intToStr(para)     [NSString stringWithFormat:@"%d",para]
#define floatToStr(para)   [NSString stringWithFormat:@"%f",para]
#define doubleToStr(para)  [NSString stringWithFormat:@"%f",para]
#define numToStr(para)     [NSString stringWithFormat:@"%@",para]
#define strToNum(para)     [NSNumber numberWithString:para]

//文件管理相关
#define kFileManager [NSFileManager defaultManager]
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory\
, NSUserDomainMask, YES)[0]

//城市相关
#define kCityName      [kUserDefault objectForKey:@"CoachAreaName"]      //城市名 全称
//#define kCityID        [kUserDefault objectForKey:@"CoachAreaID"]        //城市ID
//#define kCityShortName [kUserDefault objectForKey:@"CoachAreaShortName"] //城市名 简称

//定位相关
#define kLatitude      [kUserDefault objectForKey:@"CoachUserLocationLatitude"]  //纬度
#define kLongitude     [kUserDefault objectForKey:@"CoachUserLocationLongitude"] //经度
#define kAddress       [NSString stringWithFormat:@"%@,%@",kLongitude,kLatitude]

/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL NO

//百度地图KEY
#define kBMK_AK            @"Tb0Us8TaW1zNxSHI5Wr4g4O7OkoEwhnu"
#define kBugTag_KEY        @"1552deb496ca52c7a5d859e078100d78"

//beans——show
#define kBeansShow ([[kUserDefault objectForKey:@"BeansShow"] boolValue])

#define kRefreshBeansShowNotification @"kRefreshBeansShowNotification"

#endif /* Header_h */
