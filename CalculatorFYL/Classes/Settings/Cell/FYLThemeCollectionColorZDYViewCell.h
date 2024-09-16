//
//  FYLThemeCollectionColorZDYViewCell.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import <UIKit/UIKit.h>
#import "RSColorPickerView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol FYLThemeCollectionColorZDYViewCelldelegate <NSObject>

-(void)fyl_ColorZDYViewCellRefresh:(UIColor *)color;

@end
@interface FYLThemeCollectionColorZDYViewCell : UICollectionViewCell
<RSColorPickerViewDelegate>
@property (nonatomic, strong) RSColorPickerView *colorPicker;//色板
@property(nonatomic,weak)id<FYLThemeCollectionColorZDYViewCelldelegate>delegate;

@end

NS_ASSUME_NONNULL_END
