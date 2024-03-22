//
//  UITextField+LimitLength.m
//  输入内容长度限制Demo
//
//  Created by wangxiang on 16/1/19.
//  Copyright © 2016年 HZYX. All rights reserved.
//

#import "UITextField+LimitLength.h"
#import <objc/runtime.h>

@implementation UITextField (LimitLength)

static NSString *kLimitTextOnlyNumberKey = @"kLimitTextOnlyNumberKey";
static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";
static NSString *kLimitCharactersStringKey = @"kLimitCharactersStringKey";

#pragma mark - 限制文本输入框输入的是否只能是数字
// 包含小数点
- (void)limitOnlyNumber:(BOOL)onlyNumber{
//    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextOnlyNumberKey), [NSNumber numberWithBool:onlyNumber], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (onlyNumber) {
        objc_setAssociatedObject(self, (__bridge const void *)(kLimitCharactersStringKey), @"0123456789.", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(textFieldTextContentLimit:) forControlEvents:UIControlEventEditingChanged];
}

// 设置限制的字符串中的字符
- (void)limitCharactersInString:(NSString *)limitString{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitCharactersStringKey), limitString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldTextContentLimit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextContentLimit:(id)sender{
    NSString *limitString = objc_getAssociatedObject(self, (__bridge const void *)(kLimitCharactersStringKey));
    
//    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextOnlyNumberKey));
//    BOOL onlyNumber = [lengthNumber boolValue];
    
    if(sender == self) {
        if (!IS_VALID_STRING(limitString)) {
            return;
        }
        
        //so easy
        NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:limitString];
        
        // 去掉输入文本中的空格
        NSString *myStr = [[self text] stringByReplacingOccurrencesOfString:@" " withString:@""];
        int i = 0;
        while (i < myStr.length) {
            NSString *string = [myStr substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0) {
                //                    res = NO;
                [self shake];
                NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
                NSString *strNew = [str substringWithRange:NSMakeRange(0, i)];;
                [self setText:strNew];
                break;
            }
            i++;
        }
    }
}

#pragma mark - 限制文本输入框输入的长度
- (void)limitTextLength:(NSInteger)length{
    objc_setAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey), [NSNumber numberWithInteger:length], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(textFieldTextLengthLimit:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldTextLengthLimit:(id)sender{
    NSNumber *lengthNumber = objc_getAssociatedObject(self, (__bridge const void *)(kLimitTextLengthKey));
    int length = [lengthNumber intValue];
    //下面是修改部分
    BOOL isChinese;//判断当前输入法是否是中文
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *current = [currentar firstObject];
    //[[UITextInputMode currentInputMode] primaryLanguage]，废弃的方法
    if ([current.primaryLanguage containsString: @"en-US"]) {
        isChinese = false;
    }else{
        isChinese = true;
    }
    
    if(sender == self) {
        // length是自己设置的位数
        NSString *str = [[self text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
        if (isChinese) { //中文输入法下
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if ( str.length>length) {
                    [self shake];
                    NSString *strNew = [NSString stringWithString:str];
                    [self setText:[strNew substringToIndex:length]];
                }
            }
            else{
                // NSLog(@"输入的");
                
            }
        }else{
            if ([str length]>length) {
                [self shake];
                NSString *strNew = [NSString stringWithString:str];
                [self setText:[strNew substringToIndex:length]];
            }
        }
    }
}

- (void)shake{
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.5f];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [keyAn setValues:array];
    
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
    
    [self.layer addAnimation:keyAn forKey:@"TextAnim"];
}
@end
