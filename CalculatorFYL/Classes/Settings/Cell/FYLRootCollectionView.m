//
//  FYLRootCollectionView.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import "FYLRootCollectionView.h"
#import "RSColorPickerView.h"

@implementation FYLRootCollectionView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if([view isKindOfClass:[RSColorPickerView class]]) {
        //如果接收事件view是UISlider,则scrollview禁止响应滑动
        self.scrollEnabled = NO;
    }
    else {   //如果不是,则恢复滑动
        self.scrollEnabled = YES;

    }

    return view;

}


@end
