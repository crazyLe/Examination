//
//  ExamOrderViewController.h
//  Examination
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ExamOrderType) {
    
    ExamOrderUntreated ,
    ExamOrderAccepted ,
    ExamOrderCost
};

@interface ExamOrderViewController : UIViewController

@property (nonatomic, strong) NSString *numString;

@end
