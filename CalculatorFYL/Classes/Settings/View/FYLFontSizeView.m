//
//  FYLFontSizeView.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLFontSizeView.h"
#import "FYLRegularKeyboardView.h"
@implementation FYLFontSizeView

-(void)creatUI{
    CGFloat width = (kScreenWidth - 40 - 5*4)/6;
    self.H_one.constant = width;
    self.H_two.constant = width;
    self.H_three.constant = width;
    self.H_four.constant = width;
    self.H_five.constant = width-4;
    FYLRegularKeyboardView * regularKey = [[[NSBundle mainBundle]loadNibNamed:@"FYLRegularKeyboardView" owner:self options:nil]lastObject];
    [self.V_bg addSubview:regularKey];
    [regularKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.V_bg);
    }];
    CGFloat height_cell = kScreenWidth/4;
    self.H_keyboard_height.constant = height_cell*5;
    [regularKey changeColor];
    
    
    self.V_slider.minimumValue = 0;
    self.V_slider.maximumValue = 6;
    [self.V_slider addTarget:self action:@selector(sliderValurChanged:forEvent:) forControlEvents:UIControlEventValueChanged];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    tapGesture.delegate = self;
    [self.V_slider addGestureRecognizer:tapGesture];
    self.L_title.text = @"1+1=2\n1×2+3=5\n16-3×2=10\n1+12+43=66";
    self.L_title.font = [YLUserToolManager getAppTitleFont];
    switch ([UserDefaultObjectForKey(FYL_TitleFont) intValue]) {
        case 15:
            {
                [self.V_slider setValue:0 animated:YES];
               
            }
            break;
        case 20:
            {
                [self.V_slider setValue:1 animated:YES];
                
            }
            break;
        case 25:
            {
                [self.V_slider setValue:2 animated:YES];
                
            }
            break;
        case 30:
            {
                [self.V_slider setValue:3 animated:YES];
                
            }
            break;
        case 35:
            {
                [self.V_slider setValue:4 animated:YES];
                
            }
            break;
        case 40:
            {
                [self.V_slider setValue:5 animated:YES];
    
            }
            break;
        case 45:
            {
                [self.V_slider setValue:6 animated:YES];
                self.L_title.font = [UIFont boldSystemFontOfSize:45];
            }
            break;
        default:
            break;
    }
}
#pragma mark -- le 滑块 改变及抬手
- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:self.V_slider];
    CGFloat value = (self.V_slider.maximumValue - self.V_slider.minimumValue) * (touchPoint.x / self.V_slider.frame.size.width);
    [self changeValue:value];
       
}
- (void)sliderValurChanged:(UISlider*)slider forEvent:(UIEvent*)event{
    UITouch*touchEvent = event.allTouches.allObjects[0];
    switch (touchEvent.phase) {
            case UITouchPhaseBegan:
                break;
            case UITouchPhaseMoved:
                break;
            case UITouchPhaseEnded:
        {
            [self changeValue:slider.value];
            
        }
                break;
            default:
                break;
        }
 
}
-(void)changeValue:(CGFloat)value{
    if (value<0.5) {
        [self.V_slider setValue:0 animated:YES];
        UserDefaultSetObjectForKey(@"15", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:15];
    }else if (value>=0.5&&value<1.5){
        [self.V_slider setValue:1 animated:YES];
        UserDefaultSetObjectForKey(@"20", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:20];
    }
    else if (value>=1.5&&value<2.5){
        [self.V_slider setValue:2 animated:YES];
        UserDefaultSetObjectForKey(@"25", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:25];
    }else if (value>=2.5&&value<3.5){
        [self.V_slider setValue:3 animated:YES];
        UserDefaultSetObjectForKey(@"30", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:30];
    }else if (value>=3.5&&value<4.5){
        [self.V_slider setValue:4 animated:YES];
        UserDefaultSetObjectForKey(@"35", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:35];
    }else if (value>=4.5&&value<5.5){
        [self.V_slider setValue:5 animated:YES];
        UserDefaultSetObjectForKey(@"40", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:40];
    }else if (value>=5.5&&value<6){
        [self.V_slider setValue:6 animated:YES];
        UserDefaultSetObjectForKey(@"45", FYL_TitleFont)
        self.L_title.font = [UIFont boldSystemFontOfSize:45];
    }
    
    
}



@end
