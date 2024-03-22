//
//  PublicHelpers.h
//  Thunder
//
//  Created by 56832357 on 16/5/5.
//  Copyright © 2016年 h. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PublicHelpers : NSObject


+ (instancetype)shareManager;
//截取字符串
- (NSString *)substringWithString:(NSString *)string first:(NSString *)first second:(NSString *)second;

//判断是否为空
- (BOOL)isBlankString:(NSString *)string;

//判断文字宽高
- (CGSize)labelAutoCalculateRectWithText:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

//给一段文字中的某些字设置不同颜色
- (NSMutableAttributedString *)labelWithText:(NSString *)text arrString:(NSArray *)arrString;

//转变颜色为Image
- (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

//生成渐变色图片
- (UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize;

//秒转成时:分:秒格式
- (NSString *)TimeformatFromSeconds:(NSInteger)seconds;

//获取当前时间 yyyy-MM-dd
- (NSString *)getCurrentDate;

//获取当前时间 hour
- (NSInteger)getCurrentHour;
//获取手机WiFi网络IP地址
- (NSString *)getIPAddress;
#pragma mark - 进制转换
//十六进制转换为二进制
+ (NSString *)getBinaryByHex:(NSString *)hex;
//二进制转换为十进制
+ (NSInteger)getDecimalByBinary:(NSString *)binary;
//data转十六进制字符串
+(NSString *)convertDataToHexStr:(NSData *)data;
//把普通的字符串转换成十六进制字符串
+(NSString*)changeStringToHex:(NSString*)string;
//把12位字符串转换成mac地址
+(NSString*)changeStringToMac:(NSString*)string;


+ (NSString*)dictionaryToJson:(NSDictionary*)dic;
//获取当前试图
+ (UIViewController *)lz_getCurrentViewController;
//压缩图片（压缩尺寸）
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
//diy 坐标转换 纵向坐标转横向坐标
-(NSInteger)yl_CoordinateTransformation:(NSInteger)index;
@end
