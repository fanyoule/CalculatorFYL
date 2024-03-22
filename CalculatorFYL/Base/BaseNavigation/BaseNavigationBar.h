//
//  BaseNavigationBar.h
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationBar : UIView
@property(nonatomic,strong) UIImageView    *navBgView;

/**
 *  显示title属性，如果设置了titleView，则隐藏此标签
 */
@property(nonatomic,strong) UILabel *titleLab;

@property(nonatomic,strong)    NSString *title;

/**
 *  用于显示titleView
 */
@property(nonatomic,strong) UIView *container;


/*
 *  显示自定义的中间视图
 *  自定义的视图将添加到_container中,并居中显示
 */
@property(nonatomic,strong)    UIView *titleView;//显示自定义的titleView

/*
 *  显示自定义的左边视图
 *  请指定自定义的视图的frame，BaseNavigationBar将改变其位置，但不会改变大小
 */
@property(nonatomic,strong)    UIView *leftView;

/*
 *  显示自定义的右边视图
 *  请指定自定义的视图的frame，BaseNavigationBar将改变其位置，但不会改变大小
 */
@property(nonatomic,strong)    UIView *rightView;

@property (nonatomic,assign) BOOL leftOffSet;
@property (nonatomic,assign) BOOL rightOffSet;


/**
 *  navigationBar 背景图片
 *
 *  @param img 图片
 */
- (void)setNavigationBarBackgroundImage:(UIImage *)img;//只改变这一个navBar的背景
+ (void)setNavigationBarBackgroundImage:(UIImage *)img;

// 改变导航栏标题颜色
- (void)changeTitleColor:(UIColor *)color;

/**
 *  隐藏导航条底部分割线
 */
- (void)hideNavigationBarLine;

/**
 *  显示导航条底部分割线
 */
- (void)showNavigationBarLine;

/**
 *  根据scrollView上下滚动的偏移量,调整navigationBar的颜色和透明度
 *
 *  @param offSet 偏移量
 */
- (void)changeStyleWithOffset:(CGFloat)offSet;

- (void)changeLeftFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
