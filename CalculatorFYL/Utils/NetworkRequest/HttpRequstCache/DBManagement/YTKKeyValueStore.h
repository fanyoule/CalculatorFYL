//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface YTKKeyValueStore : NSObject
///创建数据库
- (id)initDBWithName:(NSString *)dbName;
///数据库地址
- (id)initWithDBWithPath:(NSString *)dbPath;
///表名,如果已存在，则忽略该操作
- (void)createTableWithName:(NSString *)tableName;

- (BOOL)isTableExists:(NSString *)tableName;
/// 清除数据表中所有数据
- (void)clearTable:(NSString *)tableName;

- (void)dropTable:(NSString *)tableName;
/* *
 *  关闭数据库
  */ 
- (void)close;

///************************ Put&Get methods *****************************************
///存储id类型的数据
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
///读取id类型的数据
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
/// 获得指定key的数据
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
///存储字符串类型的数据
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;
///读取字符串类型的数据
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
///存储number类型的数据
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;
///读取number类型的数据
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
/// 获得所有数据
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;
/// 获得所有数据数量
- (NSUInteger)getCountFromTable:(NSString *)tableName;
/// 删除指定key的数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
/// 批量删除一组key数组的数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
/// 批量删除所有带指定前缀的数据
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;


@end
