//
//  FYLAddRemarksViewController.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/10.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    AddRemarksType_remark,//备注
    AddRemarksType_OnFile,//存档
} AddRemarksType;
@interface FYLAddRemarksViewController : BaseViewController
@property(nonatomic,strong)FYLHistoryModel * Model;
/// 1 编辑  0添加
@property(nonatomic,assign)NSInteger fyl_edit;
@property(nonatomic,assign)AddRemarksType type;


@end

NS_ASSUME_NONNULL_END
