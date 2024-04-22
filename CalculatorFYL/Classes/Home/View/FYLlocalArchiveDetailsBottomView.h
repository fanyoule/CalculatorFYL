//
//  FYLlocalArchiveDetailsBottomView.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FYLlocalArchiveDetailsBottomViewdelegate <NSObject>

-(void)fyl_didSelectedlocalArchiveDetailsBottomViewButtonTag:(NSInteger)tag;

@end
@interface FYLlocalArchiveDetailsBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *B_huifu;

@property (weak, nonatomic) IBOutlet UIButton *B_shanchu;
@property(nonatomic,weak)id<FYLlocalArchiveDetailsBottomViewdelegate>delegate;

@end

NS_ASSUME_NONNULL_END
