//
//  BaseModel.m
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import "BaseModel.h"

@implementation BaseModel
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSNumber class]]) {
        [self setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
    }else if ([value isEqual:[NSNull null]]||value == nil){
        [self setValue:@"" forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
    
}
//当value为nil时，将调用
-(void)setNilValueForKey:(NSString *)key{
    [self setValue:@"" forKey:key];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self =[super init]) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setValuesForKeysWithDictionary:dic];
            self.data = dic;
        }
        
    }
    
    return self;
}
+(instancetype)loadModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}

#pragma mark 自定义模型  cope操作时调用
- (id)copyWithZone:(nullable NSZone *)zone {
    
    id obj = [[[self class] allocWithZone:zone] init];
    Class class = [self class];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [[self valueForKey:strName] copy];//如果还套了模型也要copy
            [obj setValue:value forKey:strName];
        }
        free(ivar);
        
        class = class_getSuperclass(class);//遍历父类属性
    }
    
    return obj;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    
    id obj = [[[self class] allocWithZone:zone] init];
    Class class = [self class];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            //利用KVC取值
            id value = [[self valueForKey:strName] copy];//如果还套了模型也要copy
            [obj setValue:value forKey:strName];
        }
        free(ivar);
        
        class = class_getSuperclass(class);//遍历父类的属性
    }
    
    return obj;
}

#pragma mark po或者打印时打出内部信息  NSLog时调用
- (NSString *)description {
    NSMutableString *text = [NSMutableString stringWithFormat:@"<%@> \n", [self class]];
    NSArray *properties = [self filterPropertys];
    [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = (NSString*)obj;
        id value = [self valueForKey:key];
        NSString *valueDescription = (value)?[value description]:@"(null)";
        if (![value respondsToSelector:@selector(count)] && [valueDescription length] > 60 ) {
            valueDescription = [NSString stringWithFormat:@"%@...", [valueDescription substringToIndex:59]];
        }
        valueDescription = [valueDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"\n   "];
        [text appendFormat:@"   %@ : %@\n", key, valueDescription];
    }];
    [text appendFormat:@"</%@>", [self class]];;
    return text;
}

#pragma mark 获取一个类的属性列表
- (NSArray *)filterPropertys {
    NSMutableArray *props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char *char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
//        NSLog(@"keyname:%s",property_getName(property));
//        NSLog(@"attributes:%s",property_getAttributes(property));
    }
    free(properties);
    return props;
}



@end
