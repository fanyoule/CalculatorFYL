//
//  BaseViewController.h
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationBar.h"
#import "FYLSettingListMolde.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic,strong)FYLSettingListMolde * model;

@property(nonatomic,strong) BaseNavigationBar *navigationBar;
@property(nonatomic,strong) NSString *navTitle;
@property(nonatomic, strong)UIButton *yl_rightButton;

@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)UITableView * table_groupV;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layOut;
@property(nonatomic,strong)UIImageView * M_bg;

/** 开启关闭侧滑手势,  默认 YES开启 */
@property(nonatomic, assign) BOOL pop_gesture;

///设置背景图片  某个界面
- (void)setBackgroundImage:(UIImage *)img;
///设置背景图片 全局
+ (void)setBackgroundImage:(UIImage *)img;
// 隐藏背景图
- (void)hideBackgroundImage;


- (void)setPopBackItem;
- (void)setPopBackItem:(NSString *)normalImg;
- (void)popBack;
- (void)setNavRightItem:(NSString *)normalTitle;
-(void)setNavRightItem:(NSString *)title withImage:(UIImage *)image;
- (void)rightItemClicked;
- (void)myPop;
- (void)myDismiss;
//延迟pop
- (void)delayPopDismiss;
//延迟pop到首页
- (void)delayPopRootDismiss;

//延迟dis
- (void)delayDismiss;
- (void)dismissBack;

- (void)showNavigationbar;
- (void)hideNavigationbar;
//nav的底部线
- (void)addNavigationBarLine;

- (void)setNavigationBarTitleColor:(UIColor *)color;
//nav背景色
- (void)setNavigationBarColor:(UIColor *)color;

- (void)changeStatusBayStyle:(UIStatusBarStyle)style;
///tableview 添加暂无数据显示
-(void)addNoDataImageWithTbleview;
// 更新分区
- (void)updateAPartition:(NSInteger)section;
///从nav中删除本视图
-(void)deleteViewController:(UIViewController *)vc;
///播放声音
-(void)playSoundEffect:(NSString *)name;
///获取音效
-(NSString *)getSoundTypeStr;

@end

NS_ASSUME_NONNULL_END
