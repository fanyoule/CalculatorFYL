//
//  NetworkRequestAPI.h
//  HIBEX
//
//  Created by zhangzhen on 2018/5/30.
//  Copyright © 2018年 zhangzhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequestAPI : NSObject

#ifdef DEBUG

#define APIHEAD_Foreign @"http://local.calculator.com/" // 外网  线上
//#define APIHEAD_Foreign @"https://cloud.v2.dbiot.link/" // 国网  线下
#define APIHEAD_local @"http://192.168.0.77:34415/" // 本地 联调

//#define APIHEAD_Foreign @"https://joylight.dbiot.org/" // 外网  线上
//#define APIHEAD_local @"http://192.168.2.223:34415/" // 本地 联调

#else

#define APIHEAD_Foreign @"https://joylight.dbiot.org/" // 外网  线上
#define APIHEAD_local @"http://192.168.2.223:34415/" // 本地 联调


#endif

// 获取反馈列表
#define API_feedbacklist [NSString stringWithFormat:@"%@",@"api/feedback/list"]
// 添加反馈列表   content反馈内容  uniqueld
#define API_feedbackadd [NSString stringWithFormat:@"%@",@"api/feedback/add"]




@end

