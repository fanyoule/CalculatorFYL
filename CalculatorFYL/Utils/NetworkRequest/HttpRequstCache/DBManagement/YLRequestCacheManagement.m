//
//  YLRequestCacheManagement.m
//  DayBetter
//
//  Created by 袁林 on 2023/12/15.
//

#import "YLRequestCacheManagement.h"

@interface YLRequestCacheManagement ()

/// 数据库文件的路径
@property (strong, nonatomic)NSString *fileName;

/// 数据库对象
@property (strong, nonatomic)FMDatabase *db;

@end

@implementation YLRequestCacheManagement

+ (YLRequestCacheManagement *)sharedDBManagement {
    static YLRequestCacheManagement *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[YLRequestCacheManagement alloc]init];
    });
    return helper;
}

- (instancetype)init {
    
    //数据库名称 requestCacheData.sqlite
    [self createDBWithName:@"ABRequestCacheData.sqlite"];
    
    return self;
}

#pragma mark 创建DB
- (void)createDBWithName:( NSString * _Nonnull )dbName {
    
    if (!IS_VALID_STRING(dbName)) {
        
        //是防止用户直接传值为nil或者NULL
        //**注意：当返回值为nil或者NULL的时候，表示会在临时目录下创建一个空的数据库，当FMDatabase连接关闭的时候，文件也会被删除**
        self.fileName = nil;
        NSLog(@"dbName不能为空，当返回值为nil或者NULL的时候，表示会在临时目录下创建一个空的数据库，当FMDatabase连接关闭的时候，文件也会被删除");
        
    } else {
        /**
         *  判断用户是否为数据库文件添加后缀名
         */
        if ([dbName hasSuffix:@".sqlite"]) {
            self.fileName = dbName;
        } else {
            self.fileName = [dbName stringByAppendingString:@".sqlite"];
        }
    }
    
    // 打开数据库
//    [self openOrCreateDB];
    
    //创建表，表名=y_requestCacheData
    [self createTable];
}

#pragma mark 创建表
- (void)createTable {
    
    if ([self openOrCreateDB]) {
        //y_requestCacheData 表名字， id=表id  data=请求到的数据，字典转json存储  url=接口请求路径  parameters=请求参数
        NSString *createTableSqlString = @"CREATE TABLE IF NOT EXISTS y_requestCacheData (id integer PRIMARY KEY AUTOINCREMENT, data longtext NOT NULL, url longtext NOT NULL, parameters longtext NOT NULL)";
        BOOL isSuc = [self.db executeUpdate:createTableSqlString];
        if (isSuc) {
            NSLog(@"y_requestCacheData 表创建成功");
        } else {
            NSLog(@"y_requestCacheData 已有此表 或 创建失败");
        }
        [self closeDB];
    }
}

#pragma mark 写入数据，有url标识，更新数据
- (void)writeData:(NSString *)data url:(NSString *)url parameters:(NSString *)parameters {
    
    if ([self openOrCreateDB]) {
        
        //精确查询,url与parameters，当两个条件同时满足，属于精确查询
        NSString *sqSql = [NSString stringWithFormat:@"select * from y_requestCacheData where url = '%@' and parameters = '%@'", url, parameters];
        FMResultSet *rs = [self.db executeQuery:sqSql];
        BOOL isQuery = [rs next];
        if (isQuery) {//有这个url，更新数据
            
            //更新数据
            NSString *dataJson = [CommonManagement verData:data style:1];
            NSString *url1 = [CommonManagement verData:url style:1];
            NSString *parameters1 = [CommonManagement verData:parameters style:1];
            NSString *sql = [NSString stringWithFormat:@"update y_requestCacheData set data = '%@' where url = '%@' and parameters = '%@'", dataJson, url1, parameters1];
            BOOL isa = [self.db executeUpdate:sql];
            if (isa) {
                
                NSLog(@"更新成功 -- %@", sql);
            } else {
                NSLog(@"更新失败 -- %@", sql);
            }
            
        } else {//写入数据
            
            //  - 不确定的参数用？来占位
            NSString *dataJson = [CommonManagement verData:data style:1];
            NSString *url1 = [CommonManagement verData:url style:1];
            NSString *parameters1 = [CommonManagement verData:parameters style:1];
            NSString *sql = [NSString stringWithFormat:@"insert into y_requestCacheData (data, url, parameters) values ('%@', '%@', '%@')", dataJson, url1, parameters1];
            BOOL isSuc = [self.db executeUpdate:sql];
            if (isSuc) {
                
                NSLog(@"写入成功 -- %@", sql);
            } else {
                NSLog(@"写入失败 -- %@", sql);
            }
        }
        
        [self closeDB];
    }
}

#pragma mark 查询数据
- (NSDictionary *)queryData:(NSString *)url parameters:(NSString *)parameters {
    
    NSDictionary *dataDic =  @{};
    if ([self openOrCreateDB]) {
        
        //精确查询
        NSString *sql = [NSString stringWithFormat:@"select * from y_requestCacheData where url = '%@' and parameters = '%@'", url, parameters];
        FMResultSet *rs = [self.db executeQuery:sql];
        BOOL isQuery = [rs next];
        if (isQuery) {
            
//            int userId = [rs intForColumn:@"id"];
            NSString *dataJson = [rs stringForColumn:@"data"];
//            NSString *url = [rs stringForColumn:@"url"];
            dataJson = [CommonManagement verData:dataJson style:1];
            dataDic = [CommonManagement toArrayOrNSDictionary:dataJson];
            NSLog(@"查询成功 -- %@ ", sql);
            
        } else {
            
            NSLog(@"查询失败 -- %@", sql);
            dataDic = @{};
        }
        [self closeDB];
    }
    return dataDic;
}

#pragma mark 删除数据
- (BOOL)deleteData:(NSString *)url {
     
    if ([self openOrCreateDB]) {
        
        NSString *sqSql = [NSString stringWithFormat:@"select * from y_requestCacheData where url = ?"];
        FMResultSet *rs = [self.db executeQuery:sqSql, url];
        BOOL isQuery = [rs next];
        if (isQuery) {//有这个url，更新数据
            
            NSString *deleteData = [NSString stringWithFormat:@"delete from y_requestCacheData where url = ?"];
            BOOL success = [self.db executeUpdate:deleteData, url];
            if (success) {
                NSLog(@"删除成功 -- %@", sqSql);
                return YES;
            }
        } else {
            
            NSLog(@"删除 %@ 没有找到", sqSql);
            return NO;
        }
        
        [self closeDB];
    }
    return NO;
}

#pragma mark 删除所有数据
- (BOOL)deleteAllData {
     
    if ([self openOrCreateDB]) {
        
        NSString *deleteData = @"delete from y_requestCacheData";
        BOOL success = [self.db executeUpdate:deleteData];
        if (success) {
            NSLog(@"所有删除成功");
            return YES;
        }
        
        [self closeDB];
    }
    return NO;
}

#pragma mark 获取db路径
- (NSString *)DBPath{
    
    if (IS_VALID_STRING(self.fileName)) {
        
        NSString *savePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",self.fileName]];
        NSLog(@"savePath = %@",savePath);
        
        return savePath;
        
    } else {
        
        return @"";
    }
}

#pragma mark 打开db
- (BOOL)openOrCreateDB {
    
    if ([self.db open]) {
        
        NSLog(@"数据库打开成功");
        return YES;
    } else {
        
        NSLog(@"打开数据库失败");
        return NO;
    }
}

#pragma mark 关闭db
- (void)closeDB {
    
    BOOL isClose = [self.db close];
    if (isClose) {
        NSLog(@"关闭成功");
    }else{
        NSLog(@"关闭失败");
    }
}

#pragma mark - lazy

#pragma mark db
- (FMDatabase *)db{
    if (!_db) {
        _db = [FMDatabase databaseWithPath:[self DBPath]];
    }
    return _db;
}

@end
