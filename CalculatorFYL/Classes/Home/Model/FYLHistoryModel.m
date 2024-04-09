//
//  FYLHistoryModel.m
//  DayBetter
//
//  Created by 张震 on 2022/8/9.
//

#import "FYLHistoryModel.h"
@implementation FYLHistoryModel
+ (LKDBHelper *)getUsingLKDBHelper{
    static LKDBHelper *db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[LKDBHelper alloc]init];
    });
    return db;
}


// 将要插入数据库
+ (BOOL)dbWillInsert:(NSObject *)entity {
    LKErrorLog(@"will insert : %@", NSStringFromClass(self));
    return YES;
}
//已经插入数据库
+ (void)dbDidInserted:(NSObject *)entity result:(BOOL)result {
    LKErrorLog(@"did insert : %@", NSStringFromClass(self));
}
// 表名
+ (NSString *)getTableName {
    return @"FYLHistoryModel";
}



- (id)copyWithZone:(NSZone *)zone {
    typeof(self) one = [[[self class] allocWithZone:zone] init];
    one.ID = self.rowid;
    one.time = self.time;
    one.text = self.text;
    one.userName = self.userName;
    one.resultStr = self.resultStr;
    one.state = self.state;
    one.textHeight = self.textHeight;
    return one;
}
- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    FYLHistoryModel *other = (FYLHistoryModel *)object;
    NSLog(@"self.rowid == %ld",self.rowid);
    NSLog(@"other.rowid == %ld",other.rowid);
    return [[NSString stringWithFormat:@"%ld",self.rowid] isEqualToString:[NSString stringWithFormat:@"%ld",other.rowid]];
}

- (NSUInteger)hash {
    
    return [[NSString stringWithFormat:@"%ld",self.rowid] hash];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    [self yy_modelInitWithCoder:aDecoder];
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}
+(NSArray <FYLHistoryModel *>*)getAll{
    NSArray *result = [FYLHistoryModel searchWithWhere:nil orderBy:@"rowid" offset:0 count:0];
    return result;
}

+(void)insert:(FYLHistoryModel *)device{
    if (!device) {
        return;
    }
    NSString *querySql = [NSString stringWithFormat:@"userName = '%@'",device.userName];
    NSArray *result = [FYLHistoryModel searchWithWhere:querySql orderBy:nil offset:0 count:0];
    if (result.count<=0) {
        [FYLHistoryModel insertWhenNotExists:device];
    }else{
        for (FYLHistoryModel *m in result) {
            m.time = device.time;
            m.text = device.text;
            m.resultStr = device.resultStr;
            m.state = device.state;
            m.textHeight = device.textHeight;
            [FYLHistoryModel updateToDB:m where:querySql];
        }
    }
}


+(BOOL)updataSelectionStateWithUserName:(NSString *)userName text:(NSString *)text model:(FYLHistoryModel *)model{
    BOOL isUpdate2 = [[FYLHistoryModel getUsingLKDBHelper] updateToDBWithTableName:@"FYLHistoryModel" set:[NSString stringWithFormat:@"text = '%@'",text] where:[NSString stringWithFormat:@"uuid = '%@'",model.userName]];
    return isUpdate2;
}

+(BOOL)updataSelectionStateWithDeviceModel:(FYLHistoryModel *)model parameterName:(NSString *)name content:(id )content{
    NSString * whereSQL = [NSString stringWithFormat:@"userName = '%@'",model.userName];
    if([content isKindOfClass:[NSString class]]&&IS_VALID_STRING(content)){
        BOOL isUpdate2 = [[FYLHistoryModel getUsingLKDBHelper] updateToDBWithTableName:@"FYLHistoryModel" set:[NSString stringWithFormat:@"%@ = '%@'",name,content] where:whereSQL];
        
        return isUpdate2;
    }else if([content isKindOfClass:[NSNumber class]]){
        NSNumber * number = (NSNumber *)content;
        BOOL isUpdate2 = [[FYLHistoryModel getUsingLKDBHelper] updateToDBWithTableName:@"FYLHistoryModel" set:[NSString stringWithFormat:@"%@ = %ld",name,number.integerValue] where:whereSQL];
        return isUpdate2;
    }
   
    return NO;
}

+(BOOL)updataModel:(FYLHistoryModel *)model{
    NSString * whereSQL = @"";
    whereSQL = [NSString stringWithFormat:@"userName = '%@'",model.userName];
    
    if(!IS_VALID_STRING(whereSQL)){return NO;}
    BOOL isSuccess =[[FYLHistoryModel getUsingLKDBHelper] updateToDBWithTableName:@"FYLHistoryModel" set:[NSString stringWithFormat:@"text = '%@',time = '%@',userName = '%@',resultStr = '%@',state = %ld,textHeight = %ld",model.text,model.time,model.userName,model.resultStr,model.state,model.textHeight] where:whereSQL];
    
    return isSuccess;
    
}

// 删
+(BOOL)delStorage:(FYLHistoryModel *)model

{
    return [model deleteToDB];
}
// 获取所有设备的UUID
+(NSArray *)obtainTheUUIDOfAllStoredDevices{
    return [FYLHistoryModel searchColumn:@"uuid" where:@"" orderBy:@"" offset:0 count:0];
}

// 根据deviceMac获取某个model
+(FYLHistoryModel *)obtainTheModelBasedOnTheDeviceMac:(NSString *)mac{
    if(!IS_VALID_STRING(mac)){return [[FYLHistoryModel alloc]init];}
    NSArray *result = [FYLHistoryModel searchWithWhere:@{@"deviceMac":mac} orderBy:@"" offset:0 count:0];
    if(!IS_VALID_ARRAY(result)){
        return nil;
    }
    return result.firstObject;
}


// 根据deviceMac获取某个model
+(NSArray *)obtainTheModelUserHistory:(NSString *)userName{
    NSArray *result = [FYLHistoryModel searchWithWhere:@{@"userName":userName} orderBy:@"" offset:0 count:0];
    if(!IS_VALID_ARRAY(result)){
        return nil;
    }
    return result;
}

+(BOOL)removeUserWifiDevice{
   BOOL isSeccess = [FYLHistoryModel deleteWithWhere:@{@"userName":IS_VALID_STRING(ZJ_UserLoginInfomation.getUsername)?ZJ_UserLoginInfomation.getUsername:@"123"}];
    return isSeccess;
}
+(NSArray *)searchLocalMyWifiDeviceModel{
//    NSArray *result = [FYLHistoryModel searchWithWhere:@{@"deviceSubclass":@[@14,@15,@16,@17,@18,@29,@30,@31,@32,@33],@"userName":IS_VALID_STRING(ZJ_UserLoginInfomation.getUsername)?ZJ_UserLoginInfomation.getUsername:@""} orderBy:@"name" offset:0 count:0];
    NSArray *result = [FYLHistoryModel searchWithWhere:@{@"userName":IS_VALID_STRING(ZJ_UserLoginInfomation.getUsername)?ZJ_UserLoginInfomation.getUsername:@""} orderBy:@"name" offset:0 count:0];
    if(!IS_VALID_ARRAY(result)){
        return nil;
    }
    return result;
}

// 根据time获取某个model
+(FYLHistoryModel *)obtainTheModelBasedOnTheTime:(NSString *)time{
    if(!IS_VALID_STRING(time)){return [[FYLHistoryModel alloc]init];}
    NSArray *result = [FYLHistoryModel searchWithWhere:@{@"time":time} orderBy:@"name" offset:0 count:0];
    if(!IS_VALID_ARRAY(result)){
        return nil;
    }
    return result.firstObject;
}



@end
