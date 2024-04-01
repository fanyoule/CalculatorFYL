//
//  YLShareDeviceOuterModel.h
//  DayBetter
//
//  Created by tianhao on 2023/11/30.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLShareDeviceOuterModel : BaseModel
///日期
@property (copy, nonatomic) NSString *Date;
///数量
@property (assign, nonatomic) NSInteger TCount;
///数据arr
@property (strong, nonatomic) NSMutableArray *detailModelArr;



@end

NS_ASSUME_NONNULL_END
