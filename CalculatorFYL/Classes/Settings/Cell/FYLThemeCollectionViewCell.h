//
//  FYLThemeCollectionViewCell.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYLThemeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *V_bg;
@property (weak, nonatomic) IBOutlet UIImageView *M_sel;
///自定义
@property (weak, nonatomic) IBOutlet UIImageView *M_zdy;

@end

NS_ASSUME_NONNULL_END
