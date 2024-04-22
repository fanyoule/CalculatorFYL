//
//  FYLlocalArchiveDetailsBottomView.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/22.
//

#import "FYLlocalArchiveDetailsBottomView.h"

@implementation FYLlocalArchiveDetailsBottomView
- (IBAction)huiFuDidSelectedClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_didSelectedlocalArchiveDetailsBottomViewButtonTag:)]) {
        [self.delegate fyl_didSelectedlocalArchiveDetailsBottomViewButtonTag:0];
    }
}


- (IBAction)shanChuDidSelectedClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_didSelectedlocalArchiveDetailsBottomViewButtonTag:)]) {
        [self.delegate fyl_didSelectedlocalArchiveDetailsBottomViewButtonTag:1];
    }
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
