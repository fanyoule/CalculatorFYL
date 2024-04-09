//
//  FYLVIPKeyboardView.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FYLVIPKeyboardViewdelegate <NSObject>

-(void)fyl_RegularKeyboardDidSelectedButton:(UIButton *)btn;

@end
@interface FYLVIPKeyboardView : UIView
@property(nonatomic,weak)id<FYLVIPKeyboardViewdelegate>delegate;

@property(nonatomic,strong)NSMutableArray * itemArray;
///清空
@property (weak, nonatomic) IBOutlet UIButton *B_c;
///除
@property (weak, nonatomic) IBOutlet UIButton *B_chu;
///×
@property (weak, nonatomic) IBOutlet UIButton *B_cheng;
///删
@property (weak, nonatomic) IBOutlet UIButton *B_shan;

@property (weak, nonatomic) IBOutlet UIButton *B_4;
@property (weak, nonatomic) IBOutlet UIButton *B_5;
@property (weak, nonatomic) IBOutlet UIButton *B_6;

@property (weak, nonatomic) IBOutlet UIButton *B_1;
@property (weak, nonatomic) IBOutlet UIButton *B_2;
@property (weak, nonatomic) IBOutlet UIButton *B_3;

@property (weak, nonatomic) IBOutlet UIButton *B_7;
@property (weak, nonatomic) IBOutlet UIButton *B_8;
@property (weak, nonatomic) IBOutlet UIButton *B_9;

@property (weak, nonatomic) IBOutlet UIButton *B_0;
///－
@property (weak, nonatomic) IBOutlet UIButton *B_jian;
///+
@property (weak, nonatomic) IBOutlet UIButton *B_jia;
///=
@property (weak, nonatomic) IBOutlet UIButton *B_dengyu;
///.
@property (weak, nonatomic) IBOutlet UIButton *B_dian;
///()
@property (weak, nonatomic) IBOutlet UIButton *B_kh;
///百分比%
@property (weak, nonatomic) IBOutlet UIButton *B_bfbi;


@property(nonatomic,assign) CGPoint originPoint;
@property(nonatomic,assign) CGPoint startPoint;

-(void)initializeData;



@end

NS_ASSUME_NONNULL_END
