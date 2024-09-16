//
//  FYLkeyboardSelectView.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FYLkeyboardSelectViewDelegate <NSObject>

-(void)fyl_keyboardSelectViewDidSelectedButton:(UIButton *)btn withType:(NSString *)type;

@end
@interface FYLkeyboardSelectView : UIView

@property (weak, nonatomic) IBOutlet UIButton *B_putong;

@property (weak, nonatomic) IBOutlet UIButton *B_guibin;
@property(nonatomic,weak)id<FYLkeyboardSelectViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
