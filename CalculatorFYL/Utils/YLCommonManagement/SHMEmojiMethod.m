//
//  SHMEmojiMethod.m
//  MinSu
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 GXT. All rights reserved.
//

#import "SHMEmojiMethod.h"

@implementation SHMEmojiMethod
//判断是否输入了emoji 表情
+(BOOL)yl_stringContainsEmoji:(NSString *)string{
    __block BOOL containsEmoji = NO;
        [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
            
            const unichar hs = [substring characterAtIndex:0];
            // surrogate pair
            
            if (0xd800 <= hs &&
                hs <= 0xdbff)
            {
                if (substring.length > 1)
                {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc &&
                        uc <= 0x1f9c0)
                    {
                        containsEmoji = YES;
                    }
                }
            }
            else if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3 ||
                    ls == 0xfe0f ||
                    ls == 0xd83c)
                {
                    containsEmoji = YES;
                }
            }
            else
            {
                // non surrogate
                if (0x2100 <= hs &&
                    hs <= 0x27ff)
                {
                    containsEmoji = YES;
                }
                else if (0x2B05 <= hs &&
                         hs <= 0x2b07)
                {
                    containsEmoji = YES;
                }
                else if (0x2934 <= hs &&
                         hs <= 0x2935)
                {
                    containsEmoji = YES;
                }
                else if (0x3297 <= hs &&
                         hs <= 0x3299)
                {
                    containsEmoji = YES;
                }
                else if (hs == 0xa9 ||
                         hs == 0xae ||
                         hs == 0x303d ||
                         hs == 0x3030 ||
                         hs == 0x2b55 ||
                         hs == 0x2b1c ||
                         hs == 0x2b1b ||
                         hs == 0x2b50)
                {
                    containsEmoji = YES;
                }
            }
            if ([self isNineKeyBoard:substring]) {//九宫格输入
                    containsEmoji = NO;
            }
            if (containsEmoji)
            {
                *stop = YES;
            }
        }];
    
        return containsEmoji;
}
//判断是否含有表情符号 yes-有 no-没有
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue =NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800) {
            if (0xd800 <= hs && hs <= 0xdbff) {
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                    if (0x1d000 <= uc && uc <= 0x1f77f) {
                        returnValue =YES;
                    }
                }
            }else if (0x2100 <= hs && hs <= 0x27ff){
               returnValue =YES;
            }else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue =YES;
            }else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue =YES;
            }else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue =YES;
            }else{
                if (substring.length > 1) {
                    const unichar ls = [substring characterAtIndex:1];
                    if (ls == 0x20e3) {
                        returnValue =YES;
                    }
                }
            }
            if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e) {
                returnValue =YES;
            }
            
      }
    }];
    return returnValue;
}
//是否是系统自带九宫格输入 yes-是 no-不是
+ (BOOL)isNineKeyBoard:(NSString *)string {
    NSString *other = @"➋➌➍➎➏➐➑➒";
    int len = (int)string.length;
    for(int i=0;i<len;i++){
       if(!([other rangeOfString:string].location != NSNotFound))
          return NO;
    }
    return YES;
}
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}
//去除表情
+ (NSString *)disableEmoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

//   限制苹果系统输入法  禁止输入表情
+ (BOOL)iosStringContainsEmoji{
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
        
        return YES;
        
    }else{
        
        return NO;
    }
}
//  判断键盘是否为系统键盘
+ (BOOL)iosCurrentKeyType{
    NSString *currentKeyboardName = [[[[UITextInputMode activeInputModes] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"isDisplayed = YES"]] lastObject] valueForKey:@"extendedDisplayName"];
    if([currentKeyboardName isEqualToString:@"简体拼音"] || [currentKeyboardName isEqualToString:@"表情符号"] || [currentKeyboardName isEqualToString:@"English (US)"]||[currentKeyboardName isEqualToString:@"Emoji"]) {
            //系统自带键盘
            return YES;
        }else{
            //第三方键盘
            return NO;
            
            }
    
    
}
+ (BOOL) containEmoji:(NSString *)str
{
NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
if (len < 3) {// 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
return NO;
}// 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];Byte *bts = (Byte *)[data bytes];
Byte bt;
short v;
for (NSUInteger i = 0; i < len; i++) {
bt = bts[i];
 
if ((bt | 0x7F) == 0x7F) {// 0xxxxxxxASIIC编码
continue;
}
if ((bt | 0x1F) == 0xDF) {// 110xxxxx两个字节的字符
i += 1;
continue;
}
if ((bt | 0x0F) == 0xEF) {// 1110xxxx三个字节的字符(重点过滤项目)
// 计算Unicode下标
v = bt & 0x0F;
v = v << 6;
v |= bts[i + 1] & 0x3F;
v = v << 6;
v |= bts[i + 2] & 0x3F;
 
// NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
if ([SHMEmojiMethod emojiInSoftBankUnicode:v] || [SHMEmojiMethod emojiInUnicode:v]) {
return YES;
}
 
i += 2;
continue;
}
if ((bt | 0x3F) == 0xBF) {// 10xxxxxx10开头,为数据字节,直接过滤
continue;
}
 
return YES; // 不是以上情况的字符全部超过三个字节,做Emoji处理
}return NO;
}
+ (BOOL) emojiInUnicode:(short)code
{
if (code == 0x0023
|| code == 0x002A
|| (code >= 0x0030 && code <= 0x0039)
|| code == 0x00A9
|| code == 0x00AE
|| code == 0x203C
|| code == 0x2049
|| code == 0x2122
|| code == 0x2139
|| (code >= 0x2194 && code <= 0x2199)
|| code == 0x21A9 || code == 0x21AA
|| code == 0x231A || code == 0x231B
|| code == 0x2328
|| code == 0x23CF
|| (code >= 0x23E9 && code <= 0x23F3)
|| (code >= 0x23F8 && code <= 0x23FA)
|| code == 0x24C2
|| code == 0x25AA || code == 0x25AB
|| code == 0x25B6
|| code == 0x25C0
|| (code >= 0x25FB && code <= 0x25FE)
|| (code >= 0x2600 && code <= 0x2604)
|| code == 0x260E
|| code == 0x2611
|| code == 0x2614 || code == 0x2615
|| code == 0x2618
|| code == 0x261D
|| code == 0x2620
|| code == 0x2622 || code == 0x2623
|| code == 0x2626
|| code == 0x262A
|| code == 0x262E || code == 0x262F
|| (code >= 0x2638 && code <= 0x263A)
|| (code >= 0x2648 && code <= 0x2653)
|| code == 0x2660
|| code == 0x2663
|| code == 0x2665 || code == 0x2666
|| code == 0x2668
|| code == 0x267B
|| code == 0x267F
|| (code >= 0x2692 && code <= 0x2694)
|| code == 0x2696 || code == 0x2697
|| code == 0x2699
|| code == 0x269B || code == 0x269C
|| code == 0x26A0 || code == 0x26A1
|| code == 0x26AA || code == 0x26AB
|| code == 0x26B0 || code == 0x26B1
|| code == 0x26BD || code == 0x26BE
|| code == 0x26C4 || code == 0x26C5
|| code == 0x26C8
|| code == 0x26CE
|| code == 0x26CF
|| code == 0x26D1
|| code == 0x26D3 || code == 0x26D4
|| code == 0x26E9 || code == 0x26EA
|| (code >= 0x26F0 && code <= 0x26F5)
|| (code >= 0x26F7 && code <= 0x26FA)
|| code == 0x26FD
|| code == 0x2702
|| code == 0x2705
|| (code >= 0x2708 && code <= 0x270D)
|| code == 0x270F
|| code == 0x2712
|| code == 0x2714
|| code == 0x2716
|| code == 0x271D
|| code == 0x2721
|| code == 0x2728
|| code == 0x2733 || code == 0x2734
|| code == 0x2744
|| code == 0x2747
|| code == 0x274C
|| code == 0x274E
|| (code >= 0x2753 && code <= 0x2755)
|| code == 0x2757
|| code == 0x2763 || code == 0x2764
|| (code >= 0x2795 && code <= 0x2797)
|| code == 0x27A1
|| code == 0x27B0
|| code == 0x27BF
|| code == 0x2934 || code == 0x2935
|| (code >= 0x2B05 && code <= 0x2B07)
|| code == 0x2B1B || code == 0x2B1C
|| code == 0x2B50
|| code == 0x2B55
|| code == 0x3030
|| code == 0x303D
|| code == 0x3297
|| code == 0x3299
// 第二段
|| code == 0x23F0) {
return YES;
}
return NO;
}
+ (BOOL) emojiInSoftBankUnicode:(short)code
{
return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}




//
+(BOOL)yl_stringContainsEmojis:(NSString *)string{
   
    UILabel *characterRender = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    characterRender.text = string;
    characterRender.backgroundColor = [UIColor blackColor];//needed to remove subpixel rendering colors
    [characterRender sizeToFit];

    CGRect rect = [characterRender bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef contextSnap = UIGraphicsGetCurrentContext();
    [characterRender.layer renderInContext:contextSnap];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGImageRef imageRef = [capturedImage CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    BOOL colorPixelFound = NO;

    int x = 0;
    int y = 0;
    while (y < height && !colorPixelFound) {
        while (x < width && !colorPixelFound) {

            NSUInteger byteIndex = (bytesPerRow * y) + x * bytesPerPixel;

            CGFloat red = (CGFloat)rawData[byteIndex];
            CGFloat green = (CGFloat)rawData[byteIndex+1];
            CGFloat blue = (CGFloat)rawData[byteIndex+2];

            CGFloat h, s, b, a;
            UIColor *c = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
            [c getHue:&h saturation:&s brightness:&b alpha:&a];

            b /= 255.0f;

            if (b > 0) {
                colorPixelFound = YES;
            }

            x++;
        }
        x=0;
        y++;
    }

    return colorPixelFound;

}

@end
