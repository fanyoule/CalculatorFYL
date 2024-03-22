//
//  YLTabBarViewController.h
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import <UIKit/UIKit.h>
#import "YLTabbar_View.h"
NS_ASSUME_NONNULL_BEGIN

@interface YLTabBarViewController : UITabBarController

@property(nonatomic,strong)YLTabbar_View * tabbars;
-(void)changeIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
