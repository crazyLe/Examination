//
//  CheckVersionManager.m
//  学员端
//
//  Created by zuweizhong  on 16/8/26.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

//通知中心
#define NOTIFICATION_CENTER [NSNotificationCenter defaultCenter]

#define USER_DEFAULT kUserDefault

#import "CheckVersionManager.h"
#import "XIAlertView.h"
@implementation CheckVersionManager

singletonImplementation(CheckVersionManager)

-(void)checkVersion
{
    [self loadVersion];
}
-(void)loadVersion
{
    NSString *url = @"/checkVersion";
    NSString *time = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    param[@"version"] = version;
    param[@"channel"] = @(1);
    param[@"time"] = time;
    
    [HJHttpManager PostRequestWithUrl:url param:param finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSInteger code = [dict[@"code"] integerValue];
        if (code == 1)
        {
            NSString *updateCode = dict[@"info"][@"updateCode"];
            NSString *updateInfo = dict[@"info"][@"updateInfo"];
            NSString *updateUrl = dict[@"info"][@"updateUrl"];

            BOOL beansShow = [dict[@"info"][@"beans_show"] boolValue];
            
            [USER_DEFAULT setObject:@(beansShow) forKey:@"BeansShow"];
            [USER_DEFAULT synchronize];
            NSLog(@"dsddcc-----%d",kBeansShow);
            
            [NOTIFICATION_CENTER postNotificationName:kRefreshBeansShowNotification object:nil];

            if ([updateCode isEqualToString:@"1"]) {//建议升级
                

                XIAlertView *alertView = [[XIAlertView alloc] initWithTitle:@"有新版本"
                                                                    message:updateInfo
                                                          cancelButtonTitle:@"取消"];

            
                [alertView addDefaultStyleButtonWithTitle:@"立即更新" handler:^(XIAlertView *alertView, XIAlertButtonItem *buttonItem) {
                    [alertView dismiss];
                    // 通过获取到的url打开应用在appstore，并跳转到应用下载页面
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateUrl]];
                }];
                
                [alertView show];
            }
            if ([updateCode isEqualToString:@"2"]) {//强制升级
                XIAlertView *alertView = [[XIAlertView alloc] initWithTitle:@"有新版本"
                                                                    message:updateInfo
                                                          cancelButtonTitle:@"立即更新"];
                
                alertView.customCancelBtnHandler = ^(XIAlertView *alertView,XIAlertButtonItem *buttonItem){
                    [alertView dismiss];
                    // 通过获取到的url打开应用在appstore，并跳转到应用下载页面
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:updateUrl]];
                    
                    
                };
                
                [alertView show];
            }

            
        }

    } failed:^(NSError *error) {
        
    }];

    
    
    
    
}
@end
