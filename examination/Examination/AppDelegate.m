//
//  AppDelegate.m
//  Examination
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "CheckVersionManager.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <IQKeyboardManager.h>
#import "JPUSHService.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RootViewController.h"
#import "AddressManager.h"
#import <Bugtags/Bugtags.h>

@interface AppDelegate () <BMKLocationServiceDelegate,JPUSHRegisterDelegate>

@end

@implementation AppDelegate
{
    BMKMapManager* _mapManager;
    BMKLocationService *_locService;
}

+ (AppDelegate *)sharedApplicationDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self.window makeKeyAndVisible];
    
    _launchOptions = launchOptions;
    
    if (isLogin) {
        
        RootViewController * rootVC = [[RootViewController alloc]init];
        self.window.rootViewController= rootVC;
        
    }else {
        
        LoginViewController * loginVC = [[LoginViewController alloc]init];
        self.window.rootViewController = loginVC;
    }

    [self configNavigationBar];
    
    //地区
    NSArray *cityDicArr = [curDefaults objectForKey:@"cityDict"];
    if (cityDicArr==nil)
    {
        [[AddressManager sharedAddressManager] updateAddressInfo];
    }
    
    [self initJPush];
    
    [self initWithBMK];
    
    [self initWithIQKeyboardManage];
    
    [self initWithLocation];
    
    [self initWithBugTags];
    
    //默认不展示赚豆
    [kUserDefault setObject:@(NO) forKey:@"BeansShow"];
    [kUserDefault synchronize];
    
    return YES;
}

#pragma mark 配置全局navigationBar样式
- (void)configNavigationBar
{
    //配置状态栏为白色
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
    // 配置全局navigationbar的样式
    [UINavigationBar appearance].barTintColor = RGBCOLOR(253, 153, 20);// 背景色
    [UINavigationBar appearance].tintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];// 字体色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];// 标题色
    //    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
    //        [UINavigationBar appearance].translucent = NO;
    //    }
    
    // 配置全局UIBarButtonItem样式
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateHighlighted];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateDisabled];
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)forBarMetrics:UIBarMetricsDefault]; 
    
    // 配置全局UITabBarItem样式
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:234/255.0 green:181/255.0 blue:28/255.0 alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
}

- (void)initJPush
{
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //Required
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:_launchOptions appKey:@"b758b54e7395c216f1881156"
                          channel:@"Publish channel"
                 apsForProduction:YES];
}

- (void)initWithBMK
{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:kBMK_AK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

- (void)initWithIQKeyboardManage
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.toolbarDoneBarButtonItemText = @"完成";
}

- (void)initWithLocation
{
    if (_locService==nil) {
        
        _locService = [[BMKLocationService alloc]init];
        
        [_locService setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    _locService.delegate = self;
    [_locService startUserLocationService];
}

- (void)initWithBugTags
{
    //崩溃日志收集
    BugtagsOptions *options = [[BugtagsOptions alloc] init];
    options.trackingCrashes = YES;
    options.trackingNetwork = YES;
    [Bugtags startWithAppKey:kBugTag_KEY invocationEvent:BTGInvocationEventNone options:options];
}

#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [kUserDefault setObject:floatToStr(userLocation.location.coordinate.latitude) forKey:@"CoachUserLocationLatitude"];
    [kUserDefault setObject:floatToStr(userLocation.location.coordinate.longitude) forKey:@"CoachUserLocationLongitude"];
    
#warning  测试address:117.662926,32.572815 上线后更改
    //        [kUserDefault setObject:floatToStr(32.572815) forKey:@"CoachUserLocationLatitude"];
    //        [kUserDefault setObject:floatToStr(117.662926) forKey:@"CoachUserLocationLongitude"];
    
    
    //反向地理编码
    
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    
    CLLocation *cl = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    
    [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        for (CLPlacemark *placeMark in placemarks) {
            
            NSDictionary *addressDic = placeMark.addressDictionary;
            
            NSString *state=[addressDic objectForKey:@"State"];
            
            NSString *city=[addressDic objectForKey:@"City"];
            
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            
            NSString *street=[addressDic objectForKey:@"Street"];
            
            NSLog(@"所在城市====%@ %@ %@ %@", state, city, subLocality, street);
            
//            [self.leftBtn setTitle:city forState:UIControlStateNormal];
//            
//            CGSize locationSize = [city sizeWithFont:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, 20)];
//            
//            self.leftBtn.width = ((float)locationSize.width+10)*4/3;
//            
//            [self.leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.leftBtn.frame.size.width/1.5+5/2.0, 0, -self.leftBtn.frame.size.width/1.5-5/2.0)];
            
            [kUserDefault setObject:city forKey:@"CoachAreaName"];
            
            
//            [LLAddress getCityId:city completeBlock:^(BOOL isSuccess, NSString *areaName, NSString *areaID) {
//                if (isSuccess) {
//                    NSLog(@"2222=====>countyID : %@\n 2222==>countyName : %@",areaID,areaName);
//                    [kUserDefault setObject:areaName forKey:@"CoachAreaName"]; //全称
//                    [kUserDefault setObject:areaID forKey:@"CoachAreaID"];     //地区ID
//                }
//            }];
            
            [_locService stopUserLocationService];
            
        }
        
    }];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate


// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
 


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //检查版本
    [[CheckVersionManager sharedCheckVersionManager] checkVersion];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
