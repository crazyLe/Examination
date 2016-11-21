//
//  TestAreaSettingCell.m
//  Examination
//
//  Created by gaobin on 16/7/28.
//  Copyright © 2016年 sskz. All rights reserved.
//

#import "MMPickerView.h"
#import "TestAreaSettingCell.h"

@implementation TestAreaSettingCell
{
    UIButton * _licenseBtn;
    UIButton * _approvalBtn;
    UILabel * _licenseDetailLab;
    UILabel * _approvalDetailLab;
    

    UIButton * _mainDoorBtn;
    UIButton * _carBtn;
    UIButton * _fullViewBtn;
    UIButton * _subjectTwoBtn;
    UIButton * _subjectThreeBtn;
    
    UILabel * _mainDoorLab;
    UILabel * _carLab;
    UILabel * _fullViewLab;
    UILabel * _subjectTwoLab;
    UILabel * _subjectThreeLab;

    UILabel * _uploadAreaLab;
    
    
    UIButton * _lastBtn;
    
    UIButton *clickedBtn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   

   //self.mainDoorWidth.constant = (kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3;
    
    
    _mainDoorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_mainDoorBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_mainDoorBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mainDoorBtn];
    _mainDoorBtn.tag = 12;
    _carBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_carBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_carBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_carBtn];
    _carBtn.tag = 13;
    _fullViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fullViewBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_fullViewBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fullViewBtn];
    _fullViewBtn.tag = 14;
    _subjectTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_subjectTwoBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_subjectTwoBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_subjectTwoBtn];
    _subjectTwoBtn.tag = 15;
    _subjectThreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_subjectThreeBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_subjectThreeBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_subjectThreeBtn];
    _subjectThreeBtn.tag = 16;
    
    _mainDoorLab = [[UILabel alloc] init];
    _mainDoorLab.text = @"考场正门";
    _mainDoorLab.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    _mainDoorLab.font = [UIFont systemFontOfSize:11];
    [self addSubview:_mainDoorLab];
    _carLab = [[UILabel alloc] init];
    _carLab.text = @"车辆照片";
    _carLab.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    _carLab.font = [UIFont systemFontOfSize:11];
    [self addSubview:_carLab];
    _fullViewLab = [[UILabel alloc] init];
    _fullViewLab.text = @"考场全景";
    _fullViewLab.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    _fullViewLab.font = [UIFont systemFontOfSize:11];
    [self addSubview:_fullViewLab];
    _subjectTwoLab = [[UILabel alloc] init];
    _subjectTwoLab.text = @"科二监考设备";
    _subjectTwoLab.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    _subjectTwoLab.font = [UIFont systemFontOfSize:11];
    [self addSubview:_subjectTwoLab];
    _subjectThreeLab = [[UILabel alloc] init];
    _subjectThreeLab.text = @"科三监考设备";
    _subjectThreeLab.textColor = [UIColor colorWithHexString:@"#c8c8c8"];
    _subjectThreeLab.font = [UIFont systemFontOfSize:11];
    [self addSubview:_subjectThreeLab];
    _uploadAreaLab = [[UILabel alloc] init];
    _uploadAreaLab.text = @"上传场地照片,大小不超过2M";
    _uploadAreaLab.textColor = [UIColor colorWithHexString:@"#b1b1b1"];
    _uploadAreaLab.font = [UIFont systemFontOfSize:12];
    _uploadAreaLab.numberOfLines = 2;
    [self addSubview:_uploadAreaLab];
    
    _licenseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Utilities drawDashLineWithRect:CGRectMake(0, 0, (kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3, 60) WithColor:[UIColor colorWithHexString:@"cdd7e1"] parentView:_licenseBtn];

    
    
    

    

    [_licenseBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_licenseBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_licenseBtn];
    _licenseBtn.tag = 10;
    _licenseDetailLab = [[UILabel alloc] init];
    _licenseDetailLab.text = @"上传营业执照照片,大小不超过2M";
    _licenseDetailLab.textColor = [UIColor colorWithHexString:@"#b1b1b1"];
    _licenseDetailLab.font = [UIFont systemFontOfSize:12];
    _licenseDetailLab.numberOfLines = 2;
    [self addSubview:_licenseDetailLab];
    _approvalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_approvalBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
    [_approvalBtn addTarget:self action:@selector(uploadPicture:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_approvalBtn];
    _approvalBtn.tag = 11;
    _approvalDetailLab = [[UILabel alloc] init];
    _approvalDetailLab.text = @"上传审批资质照片,大小不超过2M";
    _approvalDetailLab.textColor = [UIColor colorWithHexString:@"#b1b1b1"];
    _approvalDetailLab.font = [UIFont systemFontOfSize:12];
    _approvalDetailLab.numberOfLines = 2;
    [self addSubview:_approvalDetailLab];
    
    
    _oneRoundView.layer.cornerRadius = 4;
    _oneRoundView.clipsToBounds = YES;
    _twoRoundView.layer.cornerRadius = 4;
    _twoRoundView.clipsToBounds = YES;
    _threeRoundView.layer.cornerRadius = 4;
    _threeRoundView.clipsToBounds = YES;
    _fourRoundView.layer.cornerRadius = 4;
    _fourRoundView.clipsToBounds = YES;
    _fiveRoundView.layer.cornerRadius = 4;
    _fiveRoundView.clipsToBounds = YES;
    _carRoundView.layer.cornerRadius = 4;
    _carRoundView.layer.masksToBounds = YES;
    
    UIView *bgView = [UIView new];
    UIImageView *accessoryImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou1"]];
    [bgView addSubview:accessoryImgView];
    bgView.backgroundColor = [UIColor colorWithHexString:@"cbd7e0"];
    accessoryImgView.frame = CGRectMake(0, 0, 25, _carTypeTF.bounds.size.height);
    accessoryImgView.contentMode = UIViewContentModeCenter;
    bgView.bounds = CGRectMake(0, 0, 25, _carTypeTF.bounds.size.height);
    _carTypeTF.rightView = bgView;
    _carTypeTF.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *tapView = [UIView new];
    [self addSubview:tapView];
    WeakObj(_carTypeTF)
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(_carTypeTFWeak);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCarTypeTF:)];
    [tapView addGestureRecognizer:tap];
    
}
- (void)clickCarTypeTF:(UITapGestureRecognizer *)tap
{
    [self endEditing:YES];
    UITextField *textField = _carTypeTF;
    if (_settingModel.carTypeModelArr.count>0) {
        //选择车型
        NSMutableArray *arr = [NSMutableArray array];
        
        for (CarTypeModel *model in _settingModel.carTypeModelArr) {
            [arr addObject:model.carName];
        }
        
        [MMPickerView showPickerViewInView:_delegate.view
                               withStrings:arr
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor whiteColor],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:18],
                                             MMvalueY: @3,
                                             MMselectedObject:isEmptyStr(textField.text)||![arr containsObject:textField.text]?arr[0]:textField.text,
                                             }
                                completion:^(NSString *selectedString) {
                                    //                                    NSLog(@"selectStr==>%@",selectedString);
                                    textField.text = selectedString;
                                    [_settingModel setCarTypeWithCarName:selectedString];
                                }];
        
    }
}

- (void)layoutSubviews {
    
    [_licenseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_licenseLab.mas_right).offset(10);
        make.top.equalTo(_licenseLab.mas_top);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];

    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithHexString:@"cdd7e1"].CGColor;
    border.fillColor = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_licenseBtn.bounds cornerRadius:5];
    border.path = path.CGPath;
    border.frame = _licenseBtn.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [_licenseBtn.layer addSublayer:border];
    
    [_licenseDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_licenseBtn);
        make.left.equalTo(_licenseBtn.mas_right).offset(5);
        make.width.offset(100);
    }];
    [_approvalBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_approvalLab.mas_right).offset(10);
        make.top.equalTo(_approvalLab.mas_top);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];
    
    [_approvalDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_approvalBtn);
        make.left.equalTo(_approvalBtn.mas_right).offset(5);
        make.width.offset(100);
    }];
    
    
    [_mainDoorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_areaPhotoLab.mas_top);
        make.left.equalTo(_areaPhotoLab.mas_right).offset(10);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];
    [_mainDoorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_mainDoorBtn);
        make.top.equalTo(_mainDoorBtn.mas_bottom).offset(6);
    }];
    
    [_carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_areaPhotoLab.mas_top);
        make.left.equalTo(_mainDoorBtn.mas_right).offset(5);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];
    [_carLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_carBtn);
        make.top.equalTo(_carBtn.mas_bottom).offset(6);
    }];
    [_fullViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_areaPhotoLab.mas_top);
        make.left.equalTo(_carBtn.mas_right).offset(5);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];
    [_fullViewLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_fullViewBtn);
        make.top.equalTo(_fullViewBtn.mas_bottom).offset(6);
    }];
    [_subjectTwoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_mainDoorBtn);
        make.top.equalTo(_mainDoorLab.mas_bottom).offset(11);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];
    [_subjectTwoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_subjectTwoBtn);
        make.top.equalTo(_subjectTwoBtn.mas_bottom).offset(6);
    }];
    [_subjectThreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_carBtn);
        make.top.equalTo(_carLab.mas_bottom).offset(11);
        make.width.offset((kScreenWidth - 12 -8 -8 -60 -20 -5 -5 -10)/3);
        make.height.offset(60);
    }];
    [_subjectThreeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_subjectThreeBtn);
        make.top.equalTo(_subjectThreeBtn.mas_bottom).offset(6);
    }];
    
    [_uploadAreaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_subjectThreeBtn);
        make.left.equalTo(_subjectThreeBtn.mas_right).offset(5);
        make.width.offset(80);
    }];
}
- (void)uploadPicture:(UIButton *)btn {
  
    _lastBtn = btn;
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取",@"拍照", nil];
    
    
    [actionSheet showInView:self];
    
    clickedBtn = btn;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 1:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 0:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else
        {
            if (buttonIndex == 2) {
                return;
            }
            else
            {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self.delegate presentViewController:imagePickerController animated:YES completion:^{
            
        }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [_lastBtn setImage:image forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *img = (NSString *)image;
    
    switch (clickedBtn.tag) {
        case 10:
            _settingModel.pic1 = img;
            break;
        case 11:
            _settingModel.pic2 = img;
            break;
        case 12:
            _settingModel.placePic1 = img;
            break;
        case 13:
            _settingModel.placePic2 = img;
            break;
        case 14:
            _settingModel.placePic3 = img;
            break;
        case 15:
            _settingModel.placePic4 = img;
            break;
        case 16:
            _settingModel.placePic5 = img;
            break;
            
        default:
            break;
    }
}
- (void)setSettingModel:(TestSettingModel *)settingModel
{
    if (_settingModel != settingModel) {
        _settingModel = settingModel;
        
        
        _textNameTF.text = _settingModel.placeName;
        
        _textAddTF.text = _settingModel.placeAddress;
        
        NSArray *controlArr = @[_licenseBtn,_approvalBtn,_mainDoorBtn,_carBtn,_fullViewBtn,_subjectTwoBtn,_subjectThreeBtn];
        NSArray *imgArr = @[_settingModel.pic1,_settingModel.pic2,_settingModel.placePic1,_settingModel.placePic2,_settingModel.placePic3,_settingModel.placePic4,_settingModel.placePic5];
        
        for (int i = 0; i < controlArr.count; i++) {
            UIButton *btn = controlArr[i];
            NSString *img = imgArr[i];
            if ([img isKindOfClass:[NSString class]]) {
                [btn sd_setImageWithURL:[NSURL URLWithString:img] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (error) {
                        [btn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                    }
                }];
            }
            else if([img isKindOfClass:[UIImage class]])
            {
                [btn setImage:(UIImage *)img forState:UIControlStateNormal];
            }
        }
        
        /*
        if ([_settingModel.pic1 isKindOfClass:[NSString class]]) {
            [_licenseBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.pic1] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_licenseBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if([_settingModel.pic1 isKindOfClass:[UIImage class]])
        {
            [_licenseBtn setImage:(UIImage *)_settingModel.pic1 forState:UIControlStateNormal];
        }
        
        if ([_settingModel.pic2 isKindOfClass:[NSString class]]) {
            [_approvalBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.pic2] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_approvalBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if ([_settingModel.pic2 isKindOfClass:[UIImage class]])
        {
            [_approvalBtn setImage:(UIImage *)_settingModel.pic2 forState:UIControlStateNormal];
        }
        
        if ([_settingModel.placePic1 isKindOfClass:[NSString class]]) {
            [_mainDoorBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.placePic1] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_mainDoorBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if ([_settingModel.placePic1 isKindOfClass:[UIImage class]])
        {
            [_mainDoorBtn setImage:(UIImage *)_settingModel.placePic1 forState:UIControlStateNormal];
        }
        
        if ([_settingModel.placePic2 isKindOfClass:[NSString class]]) {
            [_carBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.placePic2] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_carBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if ([_settingModel.placePic2 isKindOfClass:[UIImage class]])
        {
            [_carBtn setImage:(UIImage *)_settingModel.placePic2 forState:UIControlStateNormal];
        }
        
        if ([_settingModel.placePic3 isKindOfClass:[NSString class]]) {
            [_fullViewBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.placePic3] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_fullViewBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if ([_settingModel.placePic3 isKindOfClass:[UIImage class]])
        {
            [_fullViewBtn setImage:(UIImage *)_settingModel.placePic3 forState:UIControlStateNormal];
        }
        
        if ([_settingModel.placePic4 isKindOfClass:[NSString class]]) {
            [_subjectTwoBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.placePic4] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_subjectTwoBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if ([_settingModel.placePic4 isKindOfClass:[UIImage class]])
        {
            [_subjectTwoBtn setImage:(UIImage *)_settingModel.placePic4 forState:UIControlStateNormal];
        }
        
        if ([_settingModel.placePic5 isKindOfClass:[NSString class]]) {
            [_subjectThreeBtn sd_setImageWithURL:[NSURL URLWithString:_settingModel.placePic5] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [_subjectThreeBtn setImage:[UIImage imageNamed:@"矢量智能对象12"] forState:UIControlStateNormal];
                }
            }];
        }
        else if ([_settingModel.placePic5 isKindOfClass:[UIImage class]])
        {
            [_subjectThreeBtn setImage:(UIImage *)_settingModel.placePic5 forState:UIControlStateNormal];
        }
         
         */
    }
    
    if (_settingModel.carTypeModelArr.count>0) {
        for (CarTypeModel *model in _settingModel.carTypeModelArr) {
            if ([model.carId intValue] == [settingModel.placeCar intValue]) {
                _carTypeTF.text = model.carName;
                break;
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
