//
//  BaseModel.h
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject
//提示消息
@property(nonatomic,copy)NSString * msg;
@property(nonatomic,copy)NSString * code;

@property(nonatomic,strong)NSDictionary * data;


-(instancetype)initWithDictionary:(NSDictionary *)dic;
+(instancetype)loadModelWithDictionary:(NSDictionary *)dic;



@end

NS_ASSUME_NONNULL_END
