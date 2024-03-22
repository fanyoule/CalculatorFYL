//
//  ZZLabel.m
//  yueYue
//
//  Created by 张震 on 2020/7/3.
//  Copyright © 2020 张震. All rights reserved.
//

#import "ZZLabel.h"

@implementation ZZLabel

- (instancetype)initWithTextColor:(UIColor *)Color Font:(UIFont *)Font TextString:(NSString *)string{
    if (self = [super init]) {
        self.text = NSLocalizedString(string,nil);
        self.textColor = Color;
        self.font = Font;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
