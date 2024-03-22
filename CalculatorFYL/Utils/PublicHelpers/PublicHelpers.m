//
//  PublicHelpers.m
//  Thunder
//
//  Created by 56832357 on 16/5/5.
//  Copyright © 2016年 h. All rights reserved.
//

#import "PublicHelpers.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@interface PublicHelpers()

@end

static PublicHelpers *manager = nil;

@implementation PublicHelpers

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

//截取字符串
- (NSString *)substringWithString:(NSString *)string first:(NSString *)first second:(NSString *)second{
    NSRange startRange = [string rangeOfString:first];
    
    NSRange endRange = [string rangeOfString:second];
    
    NSRange range = NSMakeRange(startRange.location
                                + startRange.length,
                                endRange.location
                                - startRange.location
                                - startRange.length);
    
    NSString *result = [string substringWithRange:range];
    return result;
}

//判断是否为空
- (BOOL)isBlankString:(NSString *)string {

    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@" "]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

//判断文字宽高
- (CGSize)labelAutoCalculateRectWithText:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}

//给一段文字中的某些字设置不同颜色
- (NSMutableAttributedString *)labelWithText:(NSString *)text arrString:(NSArray *)arrString{
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSDictionary * dic in arrString) {
        NSRange range = NSMakeRange([[str string] rangeOfString:dic[@"text"]].location,[[str string] rangeOfString:dic[@"text"]].length);
        //设置字号
        [str addAttribute:NSFontAttributeName value:dic[@"font"] range:range];
        //设置文字颜色
        [str addAttribute:NSForegroundColorAttributeName value:dic[@"color"] range:range];
    }
    return str;
}

//转变颜色为Image
- (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *ColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ColorImg;
}

//生成渐变色图片
- (UIImage *)getGradientImageWithColors:(NSArray*)colors imgSize:(CGSize)imgSize{
    NSMutableArray *arRef = [NSMutableArray array];
    for(UIColor *ref in colors) {
        [arRef addObject:(id)ref.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)arRef, NULL);
    CGPoint start = CGPointMake(0.0, 0.0);
    CGPoint end = CGPointMake(imgSize.width, imgSize.height);
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

//秒转成时:分:秒格式
- (NSString *)TimeformatFromSeconds:(NSInteger)seconds{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    if ([str_hour isEqualToString: @"00"]) { //如果小时数为0，只显示分和秒
        return [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    } else {
        return [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
}

//获取当前时间 yyyy-MM-dd
- (NSString *)getCurrentDate{
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}

//获取当前时间 hour
- (NSInteger)getCurrentHour{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger hour = [gregorian component:NSCalendarUnitHour fromDate:[NSDate date]];
    if (hour % 2 == 1) {//奇数
        hour -= 1;
    }
    return hour;
}

//获取手机WiFi网络IP地址
- (NSString *)getIPAddress {
    NSString *address = @"127.0.0.1";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/**
十六进制转换为二进制
           
@param hex 十六进制数
@return 二进制数
*/
+ (NSString *)getBinaryByHex:(NSString *)hex {
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}

/**
 二进制转换为十进制
  
 @param binary 二进制数
 @return 十进制数
 */
+ (NSInteger)getDecimalByBinary:(NSString *)binary {
    NSInteger decimal = 0;
    for (int i=0; i<binary.length; i++) {
        NSString *number = [binary substringWithRange:NSMakeRange(binary.length - i - 1, 1)];
        if ([number isEqualToString:@"1"]) {
            decimal += pow(2, i);
        }
    }
    return decimal;
}

//将NSData转换成十六进制的字符串则可使用如下方式:
+(NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr= [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if([hexStr length] == 2){
                [string appendString:hexStr];
            } else{
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

+(NSString*)changeStringToHex:(NSString*)string
{
    NSLog(@"转换之前————%@",string);
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSString *dataStr = [PublicHelpers convertDataToHexStr:data];
    NSLog(@"转换之后————%@",dataStr);
    NSString *outStr = [NSString stringWithFormat:@"%02lx%@",dataStr.length/2+3,dataStr];
    NSLog(@"加上长度之后——%@",outStr);
    return outStr;
}

+(NSString*)changeStringToMac:(NSString*)string
{
    if (string.length<12) {
        return string;
    }
//    NSMutableArray *muArr = [[NSMutableArray alloc]init];
    NSString *endStr = @"";
    for (int i=0; i<6; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i*2, 2)];
        if (i == 0) {
            endStr = str;
        }else{
            endStr = [NSString stringWithFormat:@"%@:%@",endStr,str];
        }
    }
//    NSString *endStr = [muArr stringByAppendingString:":"];
    return endStr;
}
+ (NSString*)dictionaryToJson:(NSDictionary*)dic {

    NSError * error;
    if (!dic||![dic isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonString;
    if (!jsonData) {
        NSLog(@"jsonDataError:%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    /*
     NSMutableString * mutStr = [NSMutableString stringWithString:jsonString];
     NSRange range = {0,jsonString.length};
     //过滤字符串中的空格
     [mutStr replaceOccurrencesOfString:@"\/\/" withString:@"//" options:NSLiteralSearch range:range];
    NSRange range1 = {0,mutStr.length};
    //过滤字符串中的空格
    [mutStr replaceOccurrencesOfString:@"\/" withString:@"/" options:NSLiteralSearch range:range1];
     */
     
    return jsonString;
}
+ (UIViewController *)lz_getCurrentViewController{
    UIViewController* currentViewController = [self lz_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
        
    }
    return currentViewController;
}
+ (UIViewController *)lz_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}
-(NSInteger)yl_CoordinateTransformation:(NSInteger)index{
    switch (index) {
        case 0:
            return 0;
            break;
        case 20:
            return 1;
            break;
        case 40:
            return 2;
            break;
        case 60:
            return 3;
            break;
        case 80:
            return 4;
            break;
        case 100:
            return 5;
            break;
        case 120:
            return 6;
            break;
        case 140:
            return 7;
            break;
        case 160:
            return 8;
            break;
        case 180:
            return 9;
            break;
        case 200:
            return 10;
            break;
        case 220:
            return 11;
            break;
        case 240:
            return 12;
            break;
        case 260:
            return 13;
            break;
        case 280:
            return 14;
            break;
        case 300:
            return 15;
            break;
        case 320:
            return 16;
            break;
        case 340:
            return 17;
            break;
        case 360:
            return 18;
            break;
        case 380:
            return 19;
            break;
        case 1:
            return 20;
            break;
        case 21:
            return 21;
            break;
        case 41:
            return 22;
            break;
        case 61:
            return 23;
            break;
        case 81:
            return 24;
            break;
        case 101:
            return 25;
            break;
        case 121:
            return 26;
            break;
        case 141:
            return 27;
            break;
        case 161:
            return 28;
            break;
        case 181:
            return 29;
            break;
        case 201:
            return 30;
            break;
        case 221:
            return 31;
            break;
        case 241:
            return 32;
            break;
        case 261:
            return 33;
            break;
        case 281:
            return 34;
            break;
        case 301:
            return 35;
            break;
        case 321:
            return 36;
            break;
        case 341:
            return 37;
            break;
        case 361:
            return 38;
            break;
        case 381:
            return 39;
            break;
        case 2:
            return 40;
            break;
        case 22:
            return 41;
            break;
        case 42:
            return 42;
            break;
        case 62:
            return 43;
            break;
        case 82:
            return 44;
            break;
        case 102:
            return 45;
            break;
        case 122:
            return 46;
            break;
        case 142:
            return 47;
            break;
        case 162:
            return 48;
            break;
        case 182:
            return 49;
            break;
        case 202:
            return 50;
            break;
        case 222:
            return 51;
            break;
        case 242:
            return 52;
            break;
        case 262:
            return 53;
            break;
        case 282:
            return 54;
            break;
        case 302:
            return 55;
            break;
        case 322:
            return 56;
            break;
        case 342:
            return 57;
            break;
        case 362:
            return 58;
            break;
        case 382:
            return 59;
            break;
        case 3:
            return 60;
            break;
        case 23:
            return 61;
            break;
        case 43:
            return 62;
            break;
        case 63:
            return 63;
            break;
        case 83:
            return 64;
            break;
        case 103:
            return 65;
            break;
        case 123:
            return 66;
            break;
        case 143:
            return 67;
            break;
        case 163:
            return 68;
            break;
        case 183:
            return 69;
            break;
        case 203:
            return 70;
            break;
        case 223:
            return 71;
            break;
        case 243:
            return 72;
            break;
        case 263:
            return 73;
            break;
        case 283:
            return 74;
            break;
        case 303:
            return 75;
            break;
        case 323:
            return 76;
            break;
        case 343:
            return 77;
            break;
        case 363:
            return 78;
            break;
        case 383:
            return 79;
            break;
        case 4:
            return 80;
            break;
        case 24:
            return 81;
            break;
        case 44:
            return 82;
            break;
        case 64:
            return 83;
            break;
        case 84:
            return 84;
            break;
        case 104:
            return 85;
            break;
        case 124:
            return 86;
            break;
        case 144:
            return 87;
            break;
        case 164:
            return 88;
            break;
        case 184:
            return 89;
            break;
        case 204:
            return 90;
            break;
        case 224:
            return 91;
            break;
        case 244:
            return 92;
            break;
        case 264:
            return 93;
            break;
        case 284:
            return 94;
            break;
        case 304:
            return 95;
            break;
        case 324:
            return 96;
            break;
        case 344:
            return 97;
            break;
        case 364:
            return 98;
            break;
        case 384:
            return 99;
            break;
        case 5:
            return 100;
            break;
        case 25:
            return 101;
            break;
        case 45:
            return 102;
            break;
        case 65:
            return 103;
            break;
        case 85:
            return 104;
            break;
        case 105:
            return 105;
            break;
        case 125:
            return 106;
            break;
        case 145:
            return 107;
            break;
        case 165:
            return 108;
            break;
        case 185:
            return 109;
            break;
        case 205:
            return 110;
            break;
        case 225:
            return 111;
            break;
        case 245:
            return 112;
            break;
        case 265:
            return 113;
            break;
        case 285:
            return 114;
            break;
        case 305:
            return 115;
            break;
        case 325:
            return 116;
            break;
        case 345:
            return 117;
            break;
        case 365:
            return 118;
            break;
        case 385:
            return 119;
            break;
        case 6:
            return 120;
            break;
        case 26:
            return 121;
            break;
        case 46:
            return 122;
            break;
        case 66:
            return 123;
            break;
        case 86:
            return 124;
            break;
        case 106:
            return 125;
            break;
        case 126:
            return 126;
            break;
        case 146:
            return 127;
            break;
        case 166:
            return 128;
            break;
        case 186:
            return 129;
            break;
        case 206:
            return 130;
            break;
        case 226:
            return 131;
            break;
        case 246:
            return 132;
            break;
        case 266:
            return 133;
            break;
        case 286:
            return 134;
            break;
        case 306:
            return 135;
            break;
        case 326:
            return 136;
            break;
        case 346:
            return 137;
            break;
        case 366:
            return 138;
            break;
        case 386:
            return 139;
            break;
        case 7:
            return 140;
            break;
        case 27:
            return 141;
            break;
        case 47:
            return 142;
            break;
        case 67:
            return 143;
            break;
        case 87:
            return 144;
            break;
        case 107:
            return 145;
            break;
        case 127:
            return 146;
            break;
        case 147:
            return 147;
            break;
        case 167:
            return 148;
            break;
        case 187:
            return 149;
            break;
        case 207:
            return 150;
            break;
        case 227:
            return 151;
            break;
        case 247:
            return 152;
            break;
        case 267:
            return 153;
            break;
        case 287:
            return 154;
            break;
        case 307:
            return 155;
            break;
        case 327:
            return 156;
            break;
        case 347:
            return 157;
            break;
        case 367:
            return 158;
            break;
        case 387:
            return 159;
            break;
        case 8:
            return 160;
            break;
        case 28:
            return 161;
            break;
        case 48:
            return 162;
            break;
        case 68:
            return 163;
            break;
        case 88:
            return 164;
            break;
        case 108:
            return 165;
            break;
        case 128:
            return 166;
            break;
        case 148:
            return 167;
            break;
        case 168:
            return 168;
            break;
        case 188:
            return 169;
            break;
        case 208:
            return 170;
            break;
        case 228:
            return 171;
            break;
        case 248:
            return 172;
            break;
        case 268:
            return 173;
            break;
        case 288:
            return 174;
            break;
        case 308:
            return 175;
            break;
        case 328:
            return 176;
            break;
        case 348:
            return 177;
            break;
        case 368:
            return 178;
            break;
        case 388:
            return 179;
            break;
        case 9:
            return 180;
            break;
        case 29:
            return 181;
            break;
        case 49:
            return 182;
            break;
        case 69:
            return 183;
            break;
        case 89:
            return 184;
            break;
        case 109:
            return 185;
            break;
        case 129:
            return 186;
            break;
        case 149:
            return 187;
            break;
        case 169:
            return 188;
            break;
        case 189:
            return 189;
            break;
        case 209:
            return 190;
            break;
        case 229:
            return 191;
            break;
        case 249:
            return 192;
            break;
        case 269:
            return 193;
            break;
        case 289:
            return 194;
            break;
        case 309:
            return 195;
            break;
        case 329:
            return 196;
            break;
        case 349:
            return 197;
            break;
        case 369:
            return 198;
            break;
        case 389:
            return 199;
            break;
        case 10:
            return 200;
            break;
        case 30:
            return 201;
            break;
        case 50:
            return 202;
            break;
        case 70:
            return 203;
            break;
        case 90:
            return 204;
            break;
        case 110:
            return 205;
            break;
        case 130:
            return 206;
            break;
        case 150:
            return 207;
            break;
        case 170:
            return 208;
            break;
        case 190:
            return 209;
            break;
        case 210:
            return 210;
            break;
        case 230:
            return 211;
            break;
        case 250:
            return 212;
            break;
        case 270:
            return 213;
            break;
        case 290:
            return 214;
            break;
        case 310:
            return 215;
            break;
        case 330:
            return 216;
            break;
        case 350:
            return 217;
            break;
        case 370:
            return 218;
            break;
        case 390:
            return 219;
            break;
        case 11:
            return 220;
            break;
        case 31:
            return 221;
            break;
        case 51:
            return 222;
            break;
        case 71:
            return 223;
            break;
        case 91:
            return 224;
            break;
        case 111:
            return 225;
            break;
        case 131:
            return 226;
            break;
        case 151:
            return 227;
            break;
        case 171:
            return 228;
            break;
        case 191:
            return 229;
            break;
        case 211:
            return 230;
            break;
        case 231:
            return 231;
            break;
        case 251:
            return 232;
            break;
        case 271:
            return 233;
            break;
        case 291:
            return 234;
            break;
        case 311:
            return 235;
            break;
        case 331:
            return 236;
            break;
        case 351:
            return 237;
            break;
        case 371:
            return 238;
            break;
        case 391:
            return 239;
            break;
        case 12:
            return 240;
            break;
        case 32:
            return 241;
            break;
        case 52:
            return 242;
            break;
        case 72:
            return 243;
            break;
        case 92:
            return 244;
            break;
        case 112:
            return 245;
            break;
        case 132:
            return 246;
            break;
        case 152:
            return 247;
            break;
        case 172:
            return 248;
            break;
        case 192:
            return 249;
            break;
        case 212:
            return 250;
            break;
        case 232:
            return 251;
            break;
        case 252:
            return 252;
            break;
        case 272:
            return 253;
            break;
        case 292:
            return 254;
            break;
        case 312:
            return 255;
            break;
        case 332:
            return 256;
            break;
        case 352:
            return 257;
            break;
        case 372:
            return 258;
            break;
        case 392:
            return 259;
            break;
        case 13:
            return 260;
            break;
        case 33:
            return 261;
            break;
        case 53:
            return 262;
            break;
        case 73:
            return 263;
            break;
        case 93:
            return 264;
            break;
        case 113:
            return 265;
            break;
        case 133:
            return 266;
            break;
        case 153:
            return 267;
            break;
        case 173:
            return 268;
            break;
        case 193:
            return 269;
            break;
        case 213:
            return 270;
            break;
        case 233:
            return 271;
            break;
        case 253:
            return 272;
            break;
        case 273:
            return 273;
            break;
        case 293:
            return 274;
            break;
        case 313:
            return 275;
            break;
        case 333:
            return 276;
            break;
        case 353:
            return 277;
            break;
        case 373:
            return 278;
            break;
        case 393:
            return 279;
            break;
        case 14:
            return 280;
            break;
        case 34:
            return 281;
            break;
        case 54:
            return 282;
            break;
        case 74:
            return 283;
            break;
        case 94:
            return 284;
            break;
        case 114:
            return 285;
            break;
        case 134:
            return 286;
            break;
        case 154:
            return 287;
            break;
        case 174:
            return 288;
            break;
        case 194:
            return 289;
            break;
        case 214:
            return 290;
            break;
        case 234:
            return 291;
            break;
        case 254:
            return 292;
            break;
        case 274:
            return 293;
            break;
        case 294:
            return 294;
            break;
        case 314:
            return 295;
            break;
        case 334:
            return 296;
            break;
        case 354:
            return 297;
            break;
        case 374:
            return 298;
            break;
        case 394:
            return 299;
            break;
        case 15:
            return 300;
            break;
        case 35:
            return 301;
            break;
        case 55:
            return 302;
            break;
        case 75:
            return 303;
            break;
        case 95:
            return 304;
            break;
        case 115:
            return 305;
            break;
        case 135:
            return 306;
            break;
        case 155:
            return 307;
            break;
        case 175:
            return 308;
            break;
        case 195:
            return 309;
            break;
        case 215:
            return 310;
            break;
        case 235:
            return 311;
            break;
        case 255:
            return 312;
            break;
        case 275:
            return 313;
            break;
        case 295:
            return 314;
            break;
        case 315:
            return 315;
            break;
        case 335:
            return 316;
            break;
        case 355:
            return 317;
            break;
        case 375:
            return 318;
            break;
        case 395:
            return 319;
            break;
        case 16:
            return 320;
            break;
        case 36:
            return 321;
            break;
        case 56:
            return 322;
            break;
        case 76:
            return 323;
            break;
        case 96:
            return 324;
            break;
        case 116:
            return 325;
            break;
        case 136:
            return 326;
            break;
        case 156:
            return 327;
            break;
        case 176:
            return 328;
            break;
        case 196:
            return 329;
            break;
        case 216:
            return 330;
            break;
        case 236:
            return 331;
            break;
        case 256:
            return 332;
            break;
        case 276:
            return 333;
            break;
        case 296:
            return 334;
            break;
        case 316:
            return 335;
            break;
        case 336:
            return 336;
            break;
        case 356:
            return 337;
            break;
        case 376:
            return 338;
            break;
        case 396:
            return 339;
            break;
        case 17:
            return 340;
            break;
        case 37:
            return 341;
            break;
        case 57:
            return 342;
            break;
        case 77:
            return 343;
            break;
        case 97:
            return 344;
            break;
        case 117:
            return 345;
            break;
        case 137:
            return 346;
            break;
        case 157:
            return 347;
            break;
        case 177:
            return 348;
            break;
        case 197:
            return 349;
            break;
        case 217:
            return 350;
            break;
        case 237:
            return 351;
            break;
        case 257:
            return 352;
            break;
        case 277:
            return 353;
            break;
        case 297:
            return 354;
            break;
        case 317:
            return 355;
            break;
        case 337:
            return 356;
            break;
        case 357:
            return 357;
            break;
        case 377:
            return 358;
            break;
        case 397:
            return 359;
            break;
        case 18:
            return 360;
            break;
        case 38:
            return 361;
            break;
        case 58:
            return 362;
            break;
        case 78:
            return 363;
            break;
        case 98:
            return 364;
            break;
        case 118:
            return 365;
            break;
        case 138:
            return 366;
            break;
        case 158:
            return 367;
            break;
        case 178:
            return 368;
            break;
        case 198:
            return 369;
            break;
        case 218:
            return 370;
            break;
        case 238:
            return 371;
            break;
        case 258:
            return 372;
            break;
        case 278:
            return 373;
            break;
        case 298:
            return 374;
            break;
        case 318:
            return 375;
            break;
        case 338:
            return 376;
            break;
        case 358:
            return 377;
            break;
        case 378:
            return 378;
            break;
        case 398:
            return 379;
            break;
        case 19:
            return 380;
            break;
        case 39:
            return 381;
            break;
        case 59:
            return 382;
            break;
        case 79:
            return 383;
            break;
        case 99:
            return 384;
            break;
        case 119:
            return 385;
            break;
        case 139:
            return 386;
            break;
        case 159:
            return 387;
            break;
        case 179:
            return 388;
            break;
        case 199:
            return 389;
            break;
        case 219:
            return 390;
            break;
        case 239:
            return 391;
            break;
        case 259:
            return 392;
            break;
        case 279:
            return 393;
            break;
        case 299:
            return 394;
            break;
        case 319:
            return 395;
            break;
        case 339:
            return 396;
            break;
        case 359:
            return 397;
            break;
        case 379:
            return 398;
            break;
        case 399:
            return 399;
            break;
        default:
            break;
    }
    
    return 0;
}


@end
