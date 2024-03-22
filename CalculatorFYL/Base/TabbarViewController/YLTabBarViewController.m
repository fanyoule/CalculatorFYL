//
//  YLTabBarViewController.m
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import "YLTabBarViewController.h"
#import "YLNavigationViewController.h"

#import "YLHomeViewController.h"
//#import "YLCommunityViewController.h"
//#import "YLMessageViewController.h"
#import "YLMyViewController.h"

@interface YLTabBarViewController ()
<
YLTabbarDelegate,
UINavigationControllerDelegate
>



@end

@implementation YLTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self performSelector:@selector(downLoadDataApp_Version) withObject:nil afterDelay:.2];

    self.tabBar.hidden = YES;
    
    
    self.tabbars = [[YLTabbar_View alloc]initWithFrame:CGRectMake(0, kScreenHeight-STabBarHeight, kScreenWidth, STabBarHeight) Titles:@[@"首页",@"社区",@"消息",@"我的"] itemImages:@[@"home_default",@"item2_N",@"freight_rate_default",@"mine_default"] selectImages:@[@"home",@"item2_S",@"freight_rate",@"mine"] withTitleColor:rgba(0, 0, 0, .87) withTitleSelectColor:UIColor.blueColor];
    self.tabbars.backgroundColor = UIColor.groupTableViewBackgroundColor;
    self.tabbars.delegate = self;
    self.tabbars.hidden = YES;
    [self.view addSubview:self.tabbars];
    

    UIViewController * hall = [self loadControllerWithString:@"YLHomeViewController"];
//    UIViewController *a = [self loadControllerWithString:@"YLCommunityViewController"];
//    UIViewController *b = [self loadControllerWithString:@"YLMessageViewController"];
    UIViewController *c = [self loadControllerWithString:@"YLMyViewController"];
    self.viewControllers = @[hall,c];
}

- (UIViewController *)loadControllerWithString:(NSString *)string {
    Class Vclass = NSClassFromString(string);
    UIViewController *vc = [[Vclass alloc] init];
    YLNavigationViewController * nav = [[YLNavigationViewController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    nav.delegate = self;
    return nav;
}
-(void)changeIndex:(NSInteger)index{
    if (index>self.tabBar.items.count) {
        return;
    }
    self.tabbars.selectIndex = index;
    self.selectedIndex = index;
    
}
-(void)YLTabbar_selectedIndex:(NSInteger)index{
    NSLog(@"index---%ld",index);
    self.selectedIndex = index;
        
    
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.tabBar.hidden = YES;
    UIViewController * root = navigationController.viewControllers.firstObject;
    [root.view addSubview:self.tabbars];

}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (viewController == root) {
        [self.tabbars removeFromSuperview];
        self.tabbars.frame = CGRectMake(0, kScreenHeight-STabBarHeight, kScreenWidth, STabBarHeight);
        [self.view addSubview:self.tabbars];
    }
}

@end
