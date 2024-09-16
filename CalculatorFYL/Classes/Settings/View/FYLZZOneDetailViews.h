//
//  FYLZZOneDetailView.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FYLZZOneDetailViewdelegate <NSObject>

-(void)fyl_OneDetailViewDidSelectedButtonClicked:(UIButton *)btn;

@end
@interface FYLZZOneDetailViews : UIView
@property (weak, nonatomic) IBOutlet UIButton *B_one;
@property (weak, nonatomic) IBOutlet UIButton *B_two;
@property (weak, nonatomic) IBOutlet UIButton *B_three;
@property (weak, nonatomic) IBOutlet UILabel *L_contectTip;


@property(nonatomic,weak)id<FYLZZOneDetailViewdelegate>delegate;

@end

NS_ASSUME_NONNULL_END
