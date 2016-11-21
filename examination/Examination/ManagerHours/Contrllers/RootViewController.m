//
//  RootViewController.m
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "RootViewController.h"
#import "ManagerHoursViewController.h"
#import "ExamOrderViewController.h"
#import "RichScanViewController.h"
#import "AttentionViewController.h"
#import "TestCenterViewController.h"

#import "SuperNavitionController.h"

#import <RDVTabBarController.h>
#import "RDVTabBarItem.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewControllers];
    
}

- (void)setViewControllers
{
    ManagerHoursViewController * managerHoursVC = [[ManagerHoursViewController alloc]init];
    SuperNavitionController * managerNav = [[SuperNavitionController alloc]initWithRootViewController:managerHoursVC];
    
    ExamOrderViewController * examOrderVC = [[ExamOrderViewController alloc]init];
    SuperNavitionController * examOrderNav = [[SuperNavitionController alloc]initWithRootViewController:examOrderVC];
    
    RichScanViewController * richScanNav = [[RichScanViewController alloc]init];
    richScanNav.view.backgroundColor = [UIColor whiteColor];
    
//    SuperNavitionController * richScanNav = [[SuperNavitionController alloc]initWithRootViewController:richScanVC];
    
    AttentionViewController * attentionVC = [[AttentionViewController alloc]init];
    SuperNavitionController * attentionNav = [[SuperNavitionController alloc]initWithRootViewController:attentionVC];
    
    TestCenterViewController * testCenterVC = [[TestCenterViewController alloc]init];
    SuperNavitionController * testCenterNav = [[SuperNavitionController alloc]initWithRootViewController:testCenterVC];
    
    [self setViewControllers:@[managerNav,examOrderNav,richScanNav,attentionNav,testCenterNav]];
    [self customizeTabBarForController:self];
    
    //选择初始的界面
    self.selectedIndex = 0;
}

-(void)customizeTabBarForController:(RDVTabBarController *)tabBarController
{
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"学时管理",@"考场订单", @"扫一扫",@"关注度",@"考场中心"];
    NSArray * tabBarSelectImages = @[@"学时管理-拷贝",@"考场订单-拷贝",@"扫一扫-拷贝",@"关注度-拷贝",@"考场中心-拷贝"];
    NSArray * titles = @[@"学时管理",@"考试订单",@"扫一扫",@"关注度",@"考场中心"];
    
    NSInteger index = 0;
    NSDictionary * textAttributes_normal = nil;
    NSDictionary * textAttributes_selected = nil;
    
    if (NSFoundationVersionNumber >NSFoundationVersionNumber_iOS_6_1) {
        textAttributes_normal = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:14],
                                  NSForegroundColorAttributeName:RGBCOLOR(124, 124, 127),
                                  };
        textAttributes_selected = @{
                                    NSFontAttributeName:[UIFont systemFontOfSize:14],
                                    NSForegroundColorAttributeName:RGBCOLOR(250, 137, 38),
                                    };
    }
    for (RDVTabBarItem * item in [[tabBarController tabBar]items]) {
        item.unselectedTitleAttributes = textAttributes_normal;
        item.selectedTitleAttributes = textAttributes_selected;
        
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage * selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tabBarSelectImages objectAtIndex:index]]];
        UIImage * unselectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:unselectedImage];
        item.title = titles[index];
        index++;
    }
//    tabBarController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    NSInteger sec = tabBarController.selectedIndex;
//    if (2 == sec) {
//        RichScanViewController *rich = [[RichScanViewController alloc]init];
//        [self presentViewController:rich animated:NO completion:nil];
//        return NO;
//    }
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
