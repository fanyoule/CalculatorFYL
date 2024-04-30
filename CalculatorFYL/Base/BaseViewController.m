//
//  BaseViewController.m
//  JoyLight
//
//  Created by tianhao on 2023/4/1.
//

#import "BaseViewController.h"
#import "NavigationBarHandler.h"
static UIImage *BackgroundImage = nil;
@interface BaseViewController ()
<AVAudioPlayerDelegate>
/** 开启关闭侧滑手势专用 */
@property(nonatomic, assign) BOOL gesture_flag;
@property(nonatomic,strong)AVAudioPlayer * player;
@end

@implementation BaseViewController
- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = 0;
        // 隐藏系统的navigationBar导航栏
        self.navigationController.navigationBar.alpha = 0;
        self.navigationController.navigationBarHidden = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        // 当 automaticallyAdjustsScrollViewInsets 为 NO 时，tableview 是从屏幕的最上边开始，也就是被 导航栏 & 状态栏覆盖
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)closeTextField {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUserInfo];
    [self closeTextField];
}

#pragma mark 在 View Did Appear 中, 开启或关闭边缘返回手势
- (void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear: animated];
    if (!self.pop_gesture) {
        self.gesture_flag = NO;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        }
    }
    // 如果 Self 是 NavigationController 的 根视图控制器, 则关闭返回手势.
    if (self == [self.navigationController.viewControllers firstObject]) {
      self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    } else {
      self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (!self.pop_gesture) {
        // 在其他离开改页面的方法同样加上下面两句代码
        self.gesture_flag = YES;
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    [self closeTextField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //适配模态 不全屏
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    self.pop_gesture = YES;
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    self.view.backgroundColor = UIColor.blackColor;
  
    UIImageView * M_bg = [[UIImageView alloc]init];
    self.M_bg = M_bg;
    BackgroundImage = [UIImage imageNamed:@"BackgroundImage"];
    self.M_bg.image = BackgroundImage;
    [self.view addSubview:M_bg];
    [M_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    self.navigationBar = [[BaseNavigationBar alloc] init];
//    self.navigationBar.backgroundColor = UIColorHEXAlpha(0xF5F5F5,1);
    self.navigationBar.backgroundColor = UIColor.blackColor;
    self.navigationBar.navBgView.backgroundColor = UIColor.clearColor;
    self.navigationBar.frame = CGRectMake(0, 0, kScreenWidth, YX_NavViewHeight);
    [self setNavigationBarTitleColor:rgba(255, 254, 254, 1)];
    [self showNavigationbar];
    [self.view addSubview:self.navigationBar];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (!self.pop_gesture) {
        // YES：允许右滑返回  NO：禁止右滑返回
        return self.gesture_flag;
    }
    else {
        return YES;
    }
}
- (void)setNavigationBarColor:(UIColor *)color
{
    self.navigationBar.backgroundColor = color;
}

- (void)setBackgroundImage:(UIImage *)img {
    if (!img) {
        return;
    }
    self.M_bg.image = img;
}

// 隐藏背景图
- (void)hideBackgroundImage{
    self.M_bg.hidden = YES;
}

+ (void)setBackgroundImage:(UIImage *)img {
    if (img == BackgroundImage) {
        return;
    }
    BackgroundImage = img;
    [self setBackgroundImage:BackgroundImage];
}
- (void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    [self showNavigationbar];
    self.navigationBar.title = navTitle;
    if(self.navigationController.childViewControllers.count>1){
        [self setPopBackItem];
    }
}

- (void)setNavigationBarTitleColor:(UIColor *)color
{
    [self.navigationBar changeTitleColor:color];
}

- (void)addNavigationBarLine
{
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = linViewColor;
    [self.navigationBar addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)showNavigationbar
{
    self.navigationBar.hidden = NO;
}

- (void)hideNavigationbar
{
    self.navigationBar.hidden = YES;
}

- (void)setPopBackItem
{
    self.navigationBar.leftView = [NavigationBarHandler backButtonTarget:self action:@selector(popBack)];
}
-(void)setNavRightItem:(NSString *)title withImage:(UIImage *)image{
    if (IS_VALID_STRING(title)) {
        [self.yl_rightButton setTitle:title forState:UIControlStateNormal];
    }
    if (!IsNullObject(image)) {
        [self.yl_rightButton setImage:image forState:UIControlStateNormal];
    }
    self.navigationBar.rightView = self.yl_rightButton;
    
}
- (void)setPopBackItem:(NSString *)normalImg;
{
    self.navigationBar.leftView = [NavigationBarHandler buttonTarget:self action:@selector(popBack) normalImg:normalImg];
}
- (void)setNavRightItem:(NSString *)normalTitle
{
    self.navigationBar.rightView = [NavigationBarHandler buttonTarget:self action:@selector(rightItemClicked) title:normalTitle titleColor:rgba(255, 254, 254, 1)];
}
- (void)setNavRightItemImage:(NSString *)normalTitle
{
    self.navigationBar.rightView = [NavigationBarHandler buttonTarget:self action:@selector(rightItemClicked) title:normalTitle titleColor:rgba(255, 254, 254, 1)];
}
-(void)rightItemClicked{
    
}
- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissBack
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)delayPopDismiss
{
    double delayInSeconds = 2.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popViewControllerAnimated:YES];
    });
}
-(void)delayPopRootDismiss{
    double delayInSeconds = 2.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}
- (void)delayDismiss
{
    double delayInSeconds = 1.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
}
-(void)deleteViewController:(UIViewController *)vc{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
       for (UIViewController *vcs in marr) {
           if ([vcs isKindOfClass:[vc class]]) {
               [marr removeObject:vcs];
               break;
           }
    }
    self.navigationController.viewControllers = marr;
}
// 更新分区
- (void)updateAPartition:(NSInteger)section{
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
    }];
}
-(void)playSoundEffect:(NSString *)name{
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
//    SystemSoundID soundID=0;//获得系统声音ID
//    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
//    AudioServicesPlaySystemSound(soundID);//播放音效
//    NSString *urlStr=[[NSBundle mainBundle]pathForResource:@"yh_audio_boom_5" ofType:@"mp3"];
//    NSURL *url=[NSURL fileURLWithPath:urlStr];
    
    NSError * error;
    AVAudioPlayer * player = [[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    self.player = player;
    player.volume = 1;
    player.numberOfLoops = 0;
    player.delegate = self;
    [player play];
        
    
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"播放结束时执行的动作");
}

#pragma mark -- 获取音效
-(NSString *)getSoundTypeStr{
    if (self.model.soundType.intValue == 0) {
        return [YLUserToolManager getTextTag:29];
    }else if (self.model.soundType.intValue == 1){
        return [YLUserToolManager getTextTag:30];
    }else if (self.model.soundType.intValue == 2){
        return [YLUserToolManager getTextTag:31];
    }else if (self.model.soundType.intValue == 3){
        return [YLUserToolManager getTextTag:32];
    }else if (self.model.soundType.intValue == 4){
        return [YLUserToolManager getTextTag:33];
    }else if (self.model.soundType.intValue == 5){
        return [YLUserToolManager getTextTag:34];
    }else if (self.model.soundType.intValue == 6){
        return [YLUserToolManager getTextTag:35];
    }else if (self.model.soundType.intValue == 7){
        return [YLUserToolManager getTextTag:37];
    }else if (self.model.soundType.intValue == 8){
        return [YLUserToolManager getTextTag:38];
    }
    
    return [YLUserToolManager getTextTag:30];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//    [keyWindow endEditing:YES];
}

- (void)myPop
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self popBack];
    });
}

- (void)myDismiss
{
    [self dismissBack];
}

- (void)changeStatusBayStyle:(UIStatusBarStyle)style
{
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (BOOL)shouldAutorotate{
    return NO;
}

-(UITableView *)table_groupV{
    
    if (!_table_groupV) {
        _table_groupV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table_groupV.backgroundColor = UIColor.whiteColor;
        if (iOS11) {
          _table_groupV.estimatedRowHeight = 0;
          _table_groupV.estimatedSectionHeaderHeight = 0;
          _table_groupV.estimatedSectionFooterHeight = 0;
            //防止上拉加载 tableview会向上偏移
            _tableV.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }
       
        _table_groupV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table_groupV.showsVerticalScrollIndicator = NO;
    }
    return _table_groupV;
    
}

-(UITableView *)tableV{
    
    if (!_tableV) {
         _tableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
               _tableV.backgroundColor = UIColor.whiteColor;
               if (iOS11) {
                   _tableV.estimatedRowHeight = 0;
                   _tableV.estimatedSectionHeaderHeight = 0;
                   _tableV.estimatedSectionFooterHeight = 0;
                   //防止上拉加载 tableview会向上偏移
                   _tableV.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
               }
               _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableV.showsVerticalScrollIndicator = NO;
    }
    return _tableV;
    
}
- (UICollectionViewFlowLayout *)layOut{
    if (!_layOut) {
        _layOut = [[UICollectionViewFlowLayout alloc]init];
        _layOut.itemSize = CGSizeMake(kScreenWidth,kScreenHeight);
    }
    return _layOut;
    
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:self.layOut];
//        collectionView.dataSource = self;
//        collectionView.delegate = self;
        collectionView.backgroundColor = BACKCOLOR;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView = collectionView;
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UIButton *)yl_rightButton{
    if (!_yl_rightButton) {
        _yl_rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 55, 44)];
        [_yl_rightButton setImage:[UIImage imageNamed:@"DeviceEditor"] forState:(UIControlStateNormal)];
        _yl_rightButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_yl_rightButton addTarget:self action:@selector(rightItemClicked) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _yl_rightButton;
}
-(FYLSettingListMolde *)model{
    if (!_model) {
        _model = [[FYLSettingListMolde alloc]init];
        NSString * soundType = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_SoundType];
        _model.soundType =IS_VALID_STRING(soundType)?soundType:@"1";
        NSString * MainAppColor = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_MainAppColor];
        _model.themeColor =IS_VALID_STRING(MainAppColor)?MainAppColor:@"#3CD991";//
        NSString * touchState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_touchState];
        _model.touchSwitchState =IS_VALID_STRING(touchState)?touchState:@"0";
        NSString * thousandsState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_thousandsState];
        _model.thousandsState =IS_VALID_STRING(thousandsState)?thousandsState:@"0";
        NSString * dataState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_dataState];
        _model.dataState =IS_VALID_STRING(dataState)?dataState:@"0";
        NSString * orderState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_orderState];
        _model.orderState =IS_VALID_STRING(orderState)?orderState:@"1";
    }
    return _model;
}
-(void)updateUserInfo{
    NSString * soundType = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_SoundType];
    self.model.soundType =IS_VALID_STRING(soundType)?soundType:@"1";
    NSString * MainAppColor = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_MainAppColor];
    self.model.themeColor =IS_VALID_STRING(MainAppColor)?MainAppColor:@"#3CD991";//
    NSString * touchState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_touchState];
    self.model.touchSwitchState =IS_VALID_STRING(touchState)?touchState:@"0";
    NSString * thousandsState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_thousandsState];
    self.model.thousandsState =IS_VALID_STRING(thousandsState)?thousandsState:@"0";
    NSString * dataState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_dataState];
    self.model.dataState =IS_VALID_STRING(dataState)?dataState:@"0";
    NSString * orderState = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_orderState];
    self.model.orderState =IS_VALID_STRING(orderState)?orderState:@"1";
    
    
}


-(void)dealloc{
    
    NSLog(@"NSStringFromClass([self class]) ========   %@ ",NSStringFromClass([self class]));
}

@end
