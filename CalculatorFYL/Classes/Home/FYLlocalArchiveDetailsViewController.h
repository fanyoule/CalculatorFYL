//
//  FYLlocalArchiveDetailsViewController.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/22.
//

#import "BaseViewController.h"
@class FYLOnFileModel;
@class FYLRecycleBinModel;

NS_ASSUME_NONNULL_BEGIN

@interface FYLlocalArchiveDetailsViewController : BaseViewController
@property(nonatomic,strong)FYLOnFileModel * fileModle;
@property(nonatomic,strong)FYLRecycleBinModel * binModle;
/// 0 存档详情 1回收站详情
@property(nonatomic,assign)NSInteger type;

@end

NS_ASSUME_NONNULL_END
