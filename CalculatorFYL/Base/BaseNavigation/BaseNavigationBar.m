//
//  BaseNavigationBar.m
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import "BaseNavigationBar.h"
static UIImage *navBackgroundImage = nil;
@interface BaseNavigationBar ()
/**
 *  底部分割线
 */
@property(nonatomic,strong) UIImageView *bottomLine;
@end

@implementation BaseNavigationBar

#pragma mark - init
- (id)init {
    return [self initWithFrame:CGRectMake(0.0f, 0.0f, kScreenWidth, YX_NavViewHeight)];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 添加一张图片,作为navigationBar的背景图
        self.navBgView = [[UIImageView alloc] init];
        self.navBgView.image = navBackgroundImage;
        [self addSubview:self.navBgView];
        
        // 默认标题控件UILabel
        self.titleLab = [[UILabel alloc] init];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.font = PxM36Font;
        self.titleLab.textColor = UIColor.redColor;
        [self addSubview:self.titleLab];
        
        // 放置自定义标题视图的父控件UIView
        self.container = [[UIView alloc] init];
        self.container.backgroundColor = [UIColor clearColor];
        [self addSubview:self.container];
        
        // navigationBar的分割线
        self.bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, YX_NavViewHeight-0.5, kScreenWidth, 0.5)];
        self.bottomLine.backgroundColor = LineBackgroundColor;
        self.bottomLine.hidden = YES;
        [self addSubview:self.bottomLine];
    }
    return self;
}

#pragma mark - API
/**
 *  navigationBar 背景图片
 *
 *  @param img 图片
 */
- (void)setNavigationBarBackgroundImage:(UIImage *)img {
    if (!img) {
        return;
    }
    self.navBgView.image = img;
}

+ (void)setNavigationBarBackgroundImage:(UIImage *)img {
    if (img == navBackgroundImage) {
        return;
    }
    navBackgroundImage = img;
    [self setNavigationBarBackgroundImage:navBackgroundImage];
}

/**
 *  设置标题
 *
 *  @param title 标题文字
 */
- (void)setTitle:(NSString *)title {
    
    if (_title != title){
        _title = title;
    }
    
    if (_titleView == nil){
        _titleLab.hidden = NO;
    }
    _titleLab.text = _title;
    [self setNeedsLayout];
}

/**
 *  改变标题颜色
 *
 *  @param color 颜色
 */
- (void)changeTitleColor:(UIColor *)color {
    self.titleLab.textColor = color;
}

/**
 *  自定义标题视图
 *
 *  @param titleView 标题视图
 */
- (void)setTitleView:(UIView *)titleView {
    
    if (_titleView != titleView){
        [_titleView removeFromSuperview];
        _titleView = titleView;
        [self.container addSubview:_titleView];
    }
    _titleLab.hidden = YES;
    
    [self setNeedsLayout];
}

/**
 *  自定义左侧控件
 *
 *  @param leftView 左侧控件
 */
- (void)setLeftView:(UIView *)leftView {
    
    if (_leftView != leftView){
        [_leftView removeFromSuperview];
        _leftView = leftView;
        [self addSubview:_leftView];
        
        [self setNeedsLayout];
    }
}

/**
 *  自定义右侧控件
 *
 *  @param rightView 右侧控件
 */
- (void)setRightView:(UIView *)rightView {
    
    if (_rightView != rightView){
        [_rightView removeFromSuperview];
        _rightView = rightView;
        [self addSubview:_rightView];
        
        [self setNeedsLayout];
    }
}

- (void)changeLeftFrame:(CGRect)frame {
    self.leftOffSet = YES;
}

/**
 *  隐藏导航条底部分割线
 */
- (void)hideNavigationBarLine {
    self.bottomLine.hidden = YES;
}

/**
 *  显示导航条底部分割线
 */
- (void)showNavigationBarLine {
    self.bottomLine.hidden = NO;
}

/**
 *  根据scrollView上下滚动的偏移量,调整navigationBar的颜色和透明度
 *
 *  @param offSet 偏移量
 */
- (void)changeStyleWithOffset:(CGFloat)offSet {
    if (offSet < 0) {
        self.backgroundColor = [UIColor whiteColor];
        return;
    }
    
    if (offSet == 0) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = UIColorHEXAlpha(MainColorRGBValue, offSet/100);
    }
    
}

#pragma mark - layoutSubviews
/**
 *  navigationBar 布局子控件的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize vsize = self.bounds.size;
    
    self.navBgView.frame = self.bounds;
    
    if (self.leftView) {
        // 调整leftView的位置
        CGRect leftFrame = self.leftView.frame;
        leftFrame.origin.x = -1.0f;
        if (self.leftOffSet) {
            leftFrame.origin.x = 12.0f;
        }
        
        leftFrame.origin.y = (vsize.height - leftFrame.size.height - YX_StatusBarHeight)/2.0f + YX_StatusBarHeight;
        self.leftView.frame = leftFrame;
    }
    
    if (self.rightView) {
        // 调整rightView的位置
        CGRect rightFrame = self.rightView.frame;
        rightFrame.origin.x = vsize.width - rightFrame.size.width - 0.0f-1.0f;
        if (self.rightOffSet) {
            rightFrame.origin.x = vsize.width - rightFrame.size.width - 0.0f-12.0f;
        }
        
        rightFrame.origin.y = (vsize.height - rightFrame.size.height - YX_StatusBarHeight)/2.0f + YX_StatusBarHeight;
        self.rightView.frame = rightFrame;
    }
    
    CGRect containerFrame = CGRectMake(60.0f, 0.0f, kScreenWidth-60*2, vsize.height);
    self.container.frame = containerFrame;
    CGRect ltitleFrame = CGRectMake(60.0f, YX_StatusBarHeight, vsize.width - 120.0f, vsize.height - YX_StatusBarHeight);
    self.titleLab.frame = ltitleFrame;
    
    if (self.titleView) {
        self.titleView.frame = CGRectMake((self.container.frame.size.width-self.titleView.frame.size.width)/2,
                                          (vsize.height-self.titleView.frame.size.height+YX_StatusBarHeight)/2,
                                          self.titleView.frame.size.width, self.titleView.frame.size.height);
    }
}





@end
