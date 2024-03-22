//
//  UITextField+LimitLength.h
//  输入内容长度限制Demo
//
//  Created by wangxiang on 16/1/19.
//  Copyright © 2016年 HZYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)

/**
 *  设置限制的字符串中的字符
 *
 *  @param limitString 限制字符组成的字符串
 */
- (void)limitCharactersInString:(NSString *)limitString;

/**
 *  限制输入内容只能是数字
 *
 *  @param onlyNumber 限制数字
 */
- (void)limitOnlyNumber:(BOOL)onlyNumber;

/**
 *  长度限制
 *
 *  @param length 限制长度
 */
- (void)limitTextLength:(NSInteger)length;

/**
 *  uitextField 抖动效果
 */
- (void)shake;
@end
