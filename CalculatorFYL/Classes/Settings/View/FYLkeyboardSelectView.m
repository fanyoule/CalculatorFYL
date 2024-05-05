//
//  FYLkeyboardSelectView.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLkeyboardSelectView.h"

@implementation FYLkeyboardSelectView

- (IBAction)didSelectedPuTongClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_keyboardSelectViewDidSelectedButton:withType:)]) {
        [self.delegate fyl_keyboardSelectViewDidSelectedButton:sender withType:@"0"];
    }
    self.B_putong.selected = YES;
    self.B_guibin.selected = NO;
}

- (IBAction)didSelectedGuiBinClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_keyboardSelectViewDidSelectedButton:withType:)]) {
        [self.delegate fyl_keyboardSelectViewDidSelectedButton:sender withType:@"1"];
    }
    self.B_putong.selected = NO;
    self.B_guibin.selected = YES;
}



@end
