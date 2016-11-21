//
//  AddressManager.m
//  学员端
//
//  Created by zuweizhong  on 16/8/6.
//  Copyright © 2016年 Anhui Shengshi Kangzhuang Network Technology Development Co., Ltd. All rights reserved.
//

#import "AddressManager.h"
#import "ChineseToPinyin.h"
#import "ProvinceModel.h"

@implementation AddressManager

singletonImplementation(AddressManager)

-(NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;

}


-(void)updateAddressInfo
{
 
    //已开通的市
    [self loadKaitongCity];
    
    NSArray *cityDicArr = [curDefaults objectForKey:@"cityDict"];
    
    if (cityDicArr==nil)
    {
        //加载市
        [self loadCity];
    
        //加载省
        [self loadProvince];
    
        //加载县
        [self loadCountry];
    }
    

}
-(void)loadKaitongCity
{
    NSString *url = getAddressUrl;
    NSString *time = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = time;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/getAddress" time:time];
    param[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    param[@"levelid"] = @(2);
    param[@"isopen"] = @(1);
    
    [HJHttpManager PostRequestWithUrl:url param:param finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dict);
        NSInteger code = [dict[@"code"] integerValue];
        if (code == 1) {
            
            NSArray *arr1 = dict[@"info"][@"address"];
            
            NSMutableArray *cityarray =[NSMutableArray array];
            
            for (NSDictionary *dic in arr1) {
                [cityarray addObject:dic[@"title"]];
            }
            
            
            NSMutableDictionary*cityDic=[[NSMutableDictionary alloc]init];
            NSString * pinyin=nil;
            
            NSMutableArray *tempArr=[NSMutableArray array];
            
            for (NSString * city in cityarray) {
                
                pinyin=[[ChineseToPinyin pinyinFromChiniseString:city] substringToIndex:1];
                
                //如果包含key
                if([[cityDic allKeys]containsObject:pinyin]){
                    
                    tempArr=[cityDic objectForKey:pinyin];
                    [tempArr addObject:city];
                    [cityDic setObject:tempArr forKey:pinyin];
                    
                }else{
                    
                    tempArr= [[NSMutableArray alloc]initWithObjects:city, nil];
                    [cityDic setObject:tempArr forKey:pinyin];
                }
            }
            
            //要往沙盒中写数据当然要先取的沙盒目录啦
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPaht=[paths objectAtIndex:0];
            //取得完整的文件名
            NSString *fileName=[plistPaht stringByAppendingPathComponent:@"cityKaiTong.plist"];
            //            NSLog(@"fileName is%@",fileName);
            //创建并写入文件
            [cityDic writeToFile:fileName atomically:YES];
            //检查是否写入
            NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:fileName];
            //            NSLog(@"write data is :%@",writeData);
            
        }
    } failed:^(NSError *error) {
        
    }];
    
    
    
}
-(void)loadCity
{
    NSString *url = getAddressUrl;
    NSString *time = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = time;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/getAddress" time:time];
    param[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    param[@"levelid"] = @(2);

    [HJHttpManager PostRequestWithUrl:url param:param finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSInteger code = [dict[@"code"] integerValue];
        if (code == 1) {
            
            NSArray *arr1 = dict[@"info"][@"address"];
            
            
            [curDefaults setObject:arr1 forKey:@"cityDict"];
            
            NSMutableArray *cityarray =[NSMutableArray array];
            
            for (NSDictionary *dic in arr1) {
                [cityarray addObject:dic[@"title"]];
            }
            
            
            NSMutableDictionary*cityDic=[[NSMutableDictionary alloc]init];
            NSString * pinyin=nil;
            
            NSMutableArray *tempArr=[NSMutableArray array];
            
            for (NSString * city in cityarray) {
                
                pinyin=[[ChineseToPinyin pinyinFromChiniseString:city] substringToIndex:1];
                
                //如果包含key
                if([[cityDic allKeys]containsObject:pinyin]){
                    
                    tempArr=[cityDic objectForKey:pinyin];
                    [tempArr addObject:city];
                    [cityDic setObject:tempArr forKey:pinyin];
                    
                }else{
                    
                    tempArr= [[NSMutableArray alloc]initWithObjects:city, nil];
                    [cityDic setObject:tempArr forKey:pinyin];
                }
            }
            
            //要往沙盒中写数据当然要先取的沙盒目录啦
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPaht=[paths objectAtIndex:0];
            //取得完整的文件名
            NSString *fileName=[plistPaht stringByAppendingPathComponent:@"city.plist"];
//            NSLog(@"fileName is%@",fileName);
            //创建并写入文件
            [cityDic writeToFile:fileName atomically:YES];
            //检查是否写入
            NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:fileName];
//            NSLog(@"write data is :%@",writeData);
            
        }
    } failed:^(NSError *error) {
        
    }];

}
-(void)loadCountry
{

    NSString *url = getAddressUrl;
    NSString *time = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = time;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/getAddress" time:time];
    param[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    param[@"levelid"] = @(3);
    
    [HJHttpManager PostRequestWithUrl:url param:param finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSInteger code = [dict[@"code"] integerValue];
        
        if (code == 1) {
            
            NSArray *arr1 = dict[@"info"][@"address"];
            
//            [curDefaults setObject:arr1 forKey:@"countryDict"];
            
        }
    } failed:^(NSError *error) {
        
    }];


}
-(void)loadProvince
{

    NSString *url = getAddressUrl;
    NSString *time = [HttpParamManager getTime];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = kUid;
    param[@"time"] = time;
    param[@"sign"] = [HttpParamManager getSignWithIdentify:@"/getAddress" time:time];
    param[@"deviceInfo"] = [HttpParamManager getDeviceInfo];
    param[@"levelid"] = @(1);
    
    [HJHttpManager PostRequestWithUrl:url param:param finish:^(NSData *data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSInteger code = [dict[@"code"] integerValue];
        if (code == 1) {
            
            NSArray *arr1 = dict[@"info"][@"address"];
            
            [curDefaults setObject:arr1 forKey:@"provinceDict"];
            
            [self loadAddress];
            

        }
    } failed:^(NSError *error) {
        
    }];

}

-(void)loadAddress
{
    
    NSData *data = [NSData dataNamed:@"krsys_area.json"];
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSArray *cityDicArr = kProvinceDict;
    
    for (NSDictionary *dic in cityDicArr) {
        NSString *idNum = dic[@"id"];
        for (int i = 0; i<dataArray.count; i++) {
            NSString *idNum2 = dataArray[i][@"id"];
            if ([idNum2 isEqualToString:idNum]) {
                ProvinceModel *model = [ProvinceModel mj_objectWithKeyValues:dataArray[i]];
                model.citys = [NSMutableArray array];
                for (int j = 0; j<dataArray.count; j++) {
                    NSDictionary *dict2=dataArray[j];
                    if ([dict2[@"parent_id"] integerValue] == model.idNum) {
                        CityModel *cityModel = [CityModel mj_objectWithKeyValues:dict2];
                        [model.citys addObject:cityModel];
                        cityModel.countrys = [NSMutableArray array];
                        for (int m = 0; m<dataArray.count; m++) {
                            NSDictionary *dict3=dataArray[m];
                            if ([dict3[@"parent_id"] integerValue] == cityModel.idNum) {
                                CountryModel *countryModel = [CountryModel mj_objectWithKeyValues:dict3];
                                [cityModel.countrys addObject:countryModel];
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
                //将student类型变为NSData类型
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
                
                [self.addressArray addObject:data];
                
                
                
            }
            
        }
        
    }

    
    [curDefaults setObject:self.addressArray forKey:@"addressArray"];
    
}



@end
