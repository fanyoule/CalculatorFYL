//
//  CodeTextDemo
//
//  Created by 小侯爷 on 2018/9/20.
//  Copyright © 2018年 小侯爷. All rights reserved.
//

#import "HWTFCodeBView.h"

@interface HWTFCodeBView ()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat itemMargin;

@property (nonatomic, weak) UITextField *textField;

@property (nonatomic, weak) UIControl *maskView;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageBgs;
@end

@implementation HWTFCodeBView

#pragma mark - 初始化
- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin
{
    if (self = [super init]) {
        
        self.itemCount = count;
        self.itemMargin = margin;
        
        [self configTextField];
    }
    return self;
}

- (void)configTextField
{
    self.backgroundColor = [UIColor clearColor];
    
    self.labels = @[].mutableCopy;
    self.imageBgs = @[].mutableCopy;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(tfEditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
    textField.textColor = UIColor.clearColor;
    [self addSubview:textField];
    self.textField = textField;
    
    UIButton *maskView = [UIButton new];
//    maskView.backgroundColor = rgba(246, 246, 246, 1);
//    [maskView setBackgroundImage:[UIImage imageNamed:@"input_bg"] forState:UIControlStateNormal];
    [maskView addTarget:self action:@selector(clickMaskView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:maskView];
    self.maskView = maskView;
    
    for (NSInteger i = 0; i < self.itemCount; i++)
    {
        UIImageView * M_bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"input_bg"]];
        M_bg.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:M_bg];
        [self.imageBgs addObject:M_bg];
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:36];
//        label.layer.borderColor = [rgba(141, 141, 141, 1) CGColor];
//        label.layer.borderWidth = 1;
//        label.layer.cornerRadius = 4.0f;
//        label.layer.masksToBounds = YES;
        [self addSubview:label];
        [self.labels addObject:label];
    }
}
-(void)cancelText{
    for (NSInteger i = 0; i < self.itemCount; i++)
    {
        UILabel *label = self.labels[i];
        label.text = @"";
    }
    self.textField.text = @"";
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.labels.count != self.itemCount) return;
    
    CGFloat temp = self.bounds.size.width - (self.itemMargin * (self.itemCount - 1));
    CGFloat w = temp / self.itemCount;
    CGFloat x = 0;
    
    for (NSInteger i = 0; i < self.labels.count; i++)
    {
        x = i * (w + self.itemMargin);
        
        UILabel *label = self.labels[i];
        label.frame = CGRectMake(x, 0, w, self.bounds.size.height);
        UIImageView * M_bg = self.imageBgs[i];
        M_bg.frame = CGRectMake(x, 0, w, self.bounds.size.height);
    }
    
    self.textField.frame = self.bounds;
    self.maskView.frame = self.bounds;
}
-(void)EvocativeKeyboard{
    [self clickMaskView];
}
#pragma mark - 编辑改变
- (void)tfEditingChanged:(UITextField *)textField
{
    if (textField.text.length > self.itemCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.itemCount)];
    }
    
    for (int i = 0; i < self.itemCount; i++)
    {
        UILabel *label = [self.labels objectAtIndex:i];
        
        if (i < textField.text.length) {
            label.text = [textField.text substringWithRange:NSMakeRange(i, 1)];
        } else {
            label.text = nil;
        }
    }
    
    // 输入完毕后，自动隐藏键盘
    if (textField.text.length >= self.itemCount) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(HWTFCodeBView_endTextStr:)]) {
            [self.delegate HWTFCodeBView_endTextStr:textField.text];
        }
        [textField resignFirstResponder];
    }
}

- (void)clickMaskView
{
    [self.textField becomeFirstResponder];
}

- (BOOL)endEditing:(BOOL)force
{
    [self.textField endEditing:force];
    return [super endEditing:force];
}

- (NSString *)code
{
    return self.textField.text;
}

@end
