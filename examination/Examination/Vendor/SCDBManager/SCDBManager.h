//
//  SCDBManager.h
//  SCGlobalProject
//
//  Created by user on 15/5/12.
//  Copyright (c) 2015年 tousan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SCDBManager : NSObject

+ (SCDBManager*)shareInstance;
- (void)createTableWithName:(NSString *)tableName keyArr:(NSArray *)keyArr;//新建一个表
- (void)dropTableWithName:(NSString*)tableName;//删除一个表
- (BOOL)insertIntoTable:(NSString*)tableName Values:(id)value,...;//向一个表内插入一行
- (void)updateTable:(NSString*)tableName setDic:(NSDictionary *)dic WhereItsKey:(NSString*)locateKey IsValue:(id)locateValue;  //向一个表中插入这一行
- (void)deleteFromTable:(NSString*)tableName TargetKey:(NSString*)targetKey TargetValue:(id)targetValue;//删除一个表内的一行
- (void)updateTable:(NSString*)tableName SetTargetKey:(NSString*)targetKey WithValue:(id)targetValue WhereItsKey:(NSString*)locateKey IsValue:(id)locateValue;//更新一个表内一行的某个元素

- (id)getValueInTable:(NSString*)tableName WhereItsKey:(NSString*)locateKey IsValue:(id)locateValue TargetKey:(NSString*)targetKey;//获取一个表内一行内容
- (NSArray*)getAllObjectsFromTable:(NSString*)table KeyArr:(NSArray*)keyArr;//获取一个表的所有内容
- (NSArray *)getAllNOValuesInTable:(NSString*)tableName KeyArr:(NSArray *)keyArr WhereItsKey:(NSString*)locateKey IsValue:(id)locateValue;     //获取一个表中对应非key值得所有内容

- (NSArray *)getAllValuesInTable:(NSString*)tableName KeyArr:(NSArray *)keyArr WhereItsKey:(NSString*)locateKey IsValue:(id)locateValue;      //获取一个表中对应key值得所有内容
- (NSArray*)getCrossAllObjectsFromTable:(NSString*)table KeyArr:(NSArray*)keyArr WhereItsKey:(NSString*)key1 IsValue:(id)value1 andkey:(NSString *)key2 value:(id)value2;
- (NSArray*)getNOCrossAllObjectsFromTable:(NSString*)table KeyArr:(NSArray*)keyArr WhereItsNOKey:(NSString*)key1 IsNOValue:(id)value1 andkey:(NSString *)key2 value:(id)value2;
- (NSArray*)submitGetAllObjectsFromTable:(NSString*)tableName KeyArr:(NSArray *)keyArr WhereItsKey:(NSString*)key1 IsValue:(id)value1 key:(NSString *)key2 value:(id)value2;
+ (id)stringToObject:(NSString*)string;

- (void)updateTable:(NSString*)tableName TargetKeys:(NSArray *)targetKeys TargetValues:(NSArray *)targetValues WhereItsKey:(NSString*)locateKey IsValue:(id)locateValue;
- (void)updateTableThree:(NSString*)tableName TargetKeys:(NSArray *)targetKeys TargetValues:(NSArray *)targetValues WhereItsKey:(NSString*)key1 IsValue:(id)value1 key:(NSString *)key2 values:(id)value2 key:(NSString *)key3 values:(id)value3;

@end
