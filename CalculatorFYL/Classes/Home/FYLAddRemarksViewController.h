//
//  FYLAddRemarksViewController.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/10.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FYLAddRemarksViewController : BaseViewController
@property(nonatomic,strong)FYLHistoryModel * Model;
/// 1 编辑  0添加
@property(nonatomic,assign)NSInteger fyl_edit;

@end

NS_ASSUME_NONNULL_END
