//
//  YLNavigationViewController.m
//  JoyLight
//
//  Created by tianhao on 2023/4/3.
//

#import "YLNavigationViewController.h"


@interface YLNavigationViewController ()

@end

@implementation YLNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modalPresentationStyle = 0;
    
    [self setUpBase];
    
    // Do any additional setup after loading the view.
}
- (void)setUpBase
{
    
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor redColor];
    [bar setTintColor:[UIColor darkGrayColor]];
    bar.translucent = YES;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    // 设置导航栏字体颜色
    UIColor * naiColor = UIColor.blackColor;
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];;
    bar.titleTextAttributes = attributes;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
        //返回按钮自定义 自定义TabbarViewController
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -15;
//
//        UIButton *button = [[UIButton alloc] init];
//        [button setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateHighlighted];
//        button.frame = CGRectMake(0, 0, 33, 33);
//
//        if (@available(ios 11.0,*)) {
//            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
//        }
//
//        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//
//        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 点击
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
}







@end
