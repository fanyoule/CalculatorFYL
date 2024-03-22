//
//  WXUserProtocolTipView.h
//
//  Created by 吴西 on 2023/10/7.
//

#import <UIKit/UIKit.h>
#import "NSMutableAttributedString+WY_Extension.h"
#import "NSMutableParagraphStyle+WY_Extension.h"
#import "UILabel+WY_RichText.h"
NS_ASSUME_NONNULL_BEGIN

@interface FYLUserProtocolTipView : UIView<WY_RichTextDelegate>
@property (nonatomic, copy) void (^cancelAction)(void);
@property (nonatomic, copy) void (^confirmAction)(void);
@property (nonatomic, copy) void (^selectAction)(NSInteger);
- (instancetype)initWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
