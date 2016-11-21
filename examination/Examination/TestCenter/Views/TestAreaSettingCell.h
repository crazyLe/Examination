//
//  TestAreaSettingCell.h
//  Examination
//
//  Created by gaobin on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "CarTypeModel.h"
#import "TestSettingModel.h"
#import <UIKit/UIKit.h>
#import "TestAreaSetViewController.h"

@interface TestAreaSettingCell : UITableViewCell<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *licenseLab;
@property (weak, nonatomic) IBOutlet UILabel *approvalLab;

@property (weak, nonatomic) IBOutlet UILabel *areaPhotoLab;

@property (weak, nonatomic) IBOutlet UIView *oneRoundView;
@property (weak, nonatomic) IBOutlet UIView *twoRoundView;
@property (weak, nonatomic) IBOutlet UIView *threeRoundView;
@property (weak, nonatomic) IBOutlet UIView *fourRoundView;
@property (weak, nonatomic) IBOutlet UIView *fiveRoundView;
@property (weak, nonatomic) IBOutlet UIView *carRoundView;
@property (weak, nonatomic) IBOutlet UITextField *textNameTF;
@property (weak, nonatomic) IBOutlet UITextField *textAddTF;

@property (weak, nonatomic) IBOutlet UITextField *carTypeTF;

//@property (nonatomic,strong) NSArray <CarTypeModel *> *carTypeArr;
@property (nonatomic,strong) TestSettingModel *settingModel;

@property (weak, nonatomic) TestAreaSetViewController * delegate;
@end
