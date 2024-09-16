//
//  FYLOnFileModel.h
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/19.
//

#import <Foundation/Foundation.h>
#import "ZXClassArchived.h"
NS_ASSUME_NONNULL_BEGIN

@interface FYLOnFileModel : NSObject

@property(nonatomic, assign)double IDs;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * listCount;
@property(nonatomic,copy)NSString * resArrJson;

@end

NS_ASSUME_NONNULL_END
