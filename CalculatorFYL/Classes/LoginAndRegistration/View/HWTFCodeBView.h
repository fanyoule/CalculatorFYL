//
//  CodeTextDemo
//
//  Created by 小侯爷 on 2018/9/20.
//  Copyright © 2018年 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HWTFCodeBViewDelegate <NSObject>

-(void)HWTFCodeBView_endTextStr:(NSString *)text;

@end
/**
 * 基础版 - 方块
 */
@interface HWTFCodeBView : UIView

/// 当前输入的内容
@property (nonatomic, copy, readonly) NSString *code;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
@property(nonatomic,weak)id<HWTFCodeBViewDelegate>delegate;
///唤起键盘
-(void)EvocativeKeyboard;
///清空文字
-(void)cancelText;
@end

NS_ASSUME_NONNULL_END
