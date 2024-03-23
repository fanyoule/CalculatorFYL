//
//  FYLRegularKeyboardView.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/23.
//

#import "FYLRegularKeyboardView.h"

@implementation FYLRegularKeyboardView

-(instancetype)init{
    self = [super init];
    if (self) {
       
        
    }
    return self;
}
-(void)initializeData{
    [self.itemArray addObject:self.B_c];
    [self.itemArray addObject:self.B_chu];
    [self.itemArray addObject:self.B_cheng];
    [self.itemArray addObject:self.B_shan];
    [self.itemArray addObject:self.B_7];
    [self.itemArray addObject:self.B_8];
    [self.itemArray addObject:self.B_9];
    [self.itemArray addObject:self.B_jian];
    [self.itemArray addObject:self.B_4];
    [self.itemArray addObject:self.B_5];
    [self.itemArray addObject:self.B_6];
    [self.itemArray addObject:self.B_jia];
    [self.itemArray addObject:self.B_1];
    [self.itemArray addObject:self.B_2];
    [self.itemArray addObject:self.B_3];
    [self.itemArray addObject:self.B_dengyu];
    [self.itemArray addObject:self.B_0];
    [self.itemArray addObject:self.B_dian];
    
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_c addGestureRecognizer:longPressGesture];
    UILongPressGestureRecognizer *longPressGesture_B_chu = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_chu addGestureRecognizer:longPressGesture_B_chu];
    UILongPressGestureRecognizer *longPressGesture_B_cheng = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_cheng addGestureRecognizer:longPressGesture_B_cheng];
    UILongPressGestureRecognizer *longPressGesture_B_shan = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_shan addGestureRecognizer:longPressGesture_B_shan];
    UILongPressGestureRecognizer *longPressGesture_B_7 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_7 addGestureRecognizer:longPressGesture_B_7];
    UILongPressGestureRecognizer *longPressGesture_B_8 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_8 addGestureRecognizer:longPressGesture_B_8];
    UILongPressGestureRecognizer *longPressGesture_B_9 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_9 addGestureRecognizer:longPressGesture_B_9];
    UILongPressGestureRecognizer *longPressGesture_B_jian = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_jian addGestureRecognizer:longPressGesture_B_jian];
    UILongPressGestureRecognizer *longPressGesture_B_4 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_4 addGestureRecognizer:longPressGesture_B_4];
    UILongPressGestureRecognizer *longPressGesture_B_5 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_5 addGestureRecognizer:longPressGesture_B_5];
    UILongPressGestureRecognizer *longPressGesture_B_6 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_6 addGestureRecognizer:longPressGesture_B_6];
    UILongPressGestureRecognizer *longPressGesture_B_jia = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_jia addGestureRecognizer:longPressGesture_B_jia];
    UILongPressGestureRecognizer *longPressGesture_B_1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_1 addGestureRecognizer:longPressGesture_B_1];
    UILongPressGestureRecognizer *longPressGesture_B_2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_2 addGestureRecognizer:longPressGesture_B_2];
    UILongPressGestureRecognizer *longPressGesture_B_3 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_3 addGestureRecognizer:longPressGesture_B_3];
    UILongPressGestureRecognizer *longPressGesture_B_dengyu = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_dengyu addGestureRecognizer:longPressGesture_B_dengyu];
    UILongPressGestureRecognizer *longPressGesture_B_0 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_0 addGestureRecognizer:longPressGesture_B_0];
    UILongPressGestureRecognizer *longPressGesture_B_dian = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.B_dian addGestureRecognizer:longPressGesture_B_dian];
}
- (IBAction)buttonClickedSelected:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_RegularKeyboardDidSelectedButton:)]) {
        [self.delegate fyl_RegularKeyboardDidSelectedButton:sender];
    }
    
    
}

-(void)longPressAction:(UILongPressGestureRecognizer *)sender{
    UIButton * btn =(UIButton *) sender.view;
    ;
    
    
//    originPoint = btn.center;
//   __block BOOL contain;
    if (sender.state == UIGestureRecognizerStateBegan) {
        _startPoint = [sender locationInView:sender.view];
        _originPoint = CGPointMake(btn.center.x, btn.center.y);
        [UIView animateWithDuration:1 animations:^{
            btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
            btn.alpha = 1;
        }];
        
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGPoint newPoint = [sender locationInView:sender.view];
        CGFloat deltaX = newPoint.x - _startPoint.x;
        CGFloat deltaY = newPoint.y - _startPoint.y;
        btn.center = CGPointMake(btn.center.x+deltaX, btn.center.y+deltaY);
//        btn.center = newPoint;
        
    }else if (sender.state == UIGestureRecognizerStateEnded){
        UIButton * indexButton = [self indexOfPoint:btn.center withButton:btn];
        if(indexButton){
            NSString * title = indexButton.titleLabel.text;
            NSLog(@"移动结束选中的title%@",title);
            [indexButton setTitle:btn.titleLabel.text forState:UIControlStateNormal];
            [btn setTitle:title forState:UIControlStateNormal];
        }
        btn.center = _originPoint;
        [UIView animateWithDuration:1 animations:^{
            btn.transform = CGAffineTransformIdentity;
            btn.alpha = 1.0;
           
        }];
        
    }
  
    
}

-(UIButton *)indexOfPoint:(CGPoint )point withButton:(UIButton *)btn{
    for (NSInteger i = 0; i<self.itemArray.count; i++) {
        UIButton * button = self.itemArray[i];
        if (button != btn) {
            if (CGRectContainsPoint(button.frame, point)) {
                return button;
            }
        }
    }
    return nil;
}

-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end
