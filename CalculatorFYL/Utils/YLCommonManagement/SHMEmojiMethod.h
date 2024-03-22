//
//  SHMEmojiMethod.h
//  MinSu
//
//  Created by apple on 2018/11/28.
//  Copyright © 2018年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface SHMEmojiMethod : NSObject
+ (BOOL)stringContainsEmoji:(NSString *)string;
+(BOOL)yl_stringContainsEmojis:(NSString *)string;
+ (BOOL) containEmoji:(NSString *)str;
+(BOOL)yl_stringContainsEmoji:(NSString *)string;
+ (BOOL)iosStringContainsEmoji;
+ (BOOL)iosCurrentKeyType;
//判断第三方键盘中的表情
+ (BOOL)hasEmoji:(NSString*)string;
//过滤表情
+ (NSString *)filterEmoji:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
