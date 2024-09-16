//
//  FYLThemeCollectionColorZDYViewCell.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import "FYLThemeCollectionColorZDYViewCell.h"



@implementation FYLThemeCollectionColorZDYViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configeUI];
    }
    
    return self;
}
- (void)colorPickerDidChangeSelection:(RSColorPickerView *)colorPicker{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fyl_ColorZDYViewCellRefresh:)]) {
        [self.delegate fyl_ColorZDYViewCellRefresh:colorPicker.selectionColor];
    }

}

-(void)configeUI{
    [self.contentView addSubview:self.colorPicker];
    
    
}
- (RSColorPickerView *)colorPicker{
    if (!_colorPicker) {
        NSInteger height = 200;
        _colorPicker = [[RSColorPickerView alloc]initWithFrame:CGRectMake(((kScreenWidth-30)/2)-(height/2), 10, height, height)];
        [_colorPicker setDelegate:self];
//        [_colorPicker setSelectionColor:UIColor.redColor];
        _colorPicker.cropToCircle = YES;
//        _colorPicker.brightness = 1;
    }
    return _colorPicker;
}



@end
