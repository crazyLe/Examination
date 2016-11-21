//
//  TestAreaSubmitCell.h
//  Examination
//
//  Created by gaobin on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestAreaSubmitCell;

@protocol TestAreaSubmitCell <NSObject>

- (void)TestAreaSubmitCell:(TestAreaSubmitCell *)cell clickBtn:(UIButton *)btn;

@end

@interface TestAreaSubmitCell : UITableViewCell

@property (nonatomic, strong) UIButton * loginBtn;

@property (nonatomic,assign) id delegate;

@end
