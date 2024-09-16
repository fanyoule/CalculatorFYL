//
//  FYLZZOneDetailView.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/26.
//

#import "FYLZZOneDetailViews.h"

@implementation FYLZZOneDetailViews

- (IBAction)didSelectedOneClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_OneDetailViewDidSelectedButtonClicked:)]) {
        [self.delegate fyl_OneDetailViewDidSelectedButtonClicked:sender];
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
