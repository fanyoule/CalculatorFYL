//
//  FYLThemeViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/30.
//

#import "FYLThemeViewController.h"
#import "FYLRegularKeyboardView.h"
#import "FYLThemeCollectionViewCell.h"
#import "FYLThemeCollectionColorZDYViewCell.h"
#import "FYLRootCollectionView.h"
#import "YLHomeViewController.h"

@interface FYLThemeViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
FYLThemeCollectionColorZDYViewCelldelegate
>
@property(nonatomic,strong)FYLRegularKeyboardView * regularKey;
@property(nonatomic,assign)NSInteger sel_index;
@property(nonatomic,copy)NSString * sel_color;
@end

@implementation FYLThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:14];
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

-(void)fyl_ColorZDYViewCellRefresh:(UIColor *)color{
    self.sel_index = 19;
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",self.sel_index]  forKey:FYL_MainAppColorIndex];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self refreshColorStr:[color jk_HEXString]];
    
}


#pragma mark --CollectionViewdelegate 和 CollectionViewDataSouce

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        FYLThemeCollectionColorZDYViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FYLThemeCollectionColorZDYViewCell" forIndexPath:indexPath];
        cell.delegate = self;
        if (self.sel_index == 19) {
            if (IS_VALID_STRING(self.sel_color)) {
//                cell.colorPicker.selectionColor = [UIColor jk_colorWithHexString:self.sel_color];
            }
        }
        return cell;
    }
    FYLThemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FYLThemeCollectionViewCell" forIndexPath:indexPath];
    if (self.sel_index == indexPath.row) {
        cell.M_sel.hidden = NO;
    }else{
        cell.M_sel.hidden = YES;
    }
    if (self.dataArray.count>indexPath.row) {
        cell.V_bg.backgroundColor = [UIColor jk_colorWithHexString:self.dataArray[indexPath.row]];
        cell.M_zdy.hidden = YES;
    }else{
        cell.M_zdy.hidden = NO;
        cell.V_bg.backgroundColor = UIColor.whiteColor;
    }
    return cell;
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 2;
}
//每组的cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return self.dataArray.count+1;
}
//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth, 240);
    }
    return CGSizeMake((kScreenWidth-60)/5,(kScreenWidth-60)/5);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

//UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    return UIEdgeInsetsMake(10, 10, 10,10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 10;//上下间隙
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;//左右间隙
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.sel_index = indexPath.row;
    [self.collectionView reloadData];
    if (self.dataArray.count>indexPath.row) {
        
        NSString * colorStr = self.dataArray[indexPath.row];
        [self refreshColorStr:colorStr];
        
    }else{
        self.sel_index = 19;
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",self.sel_index]  forKey:FYL_MainAppColorIndex];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)refreshColorStr:(NSString *)colorStr{
    self.sel_color = colorStr;
    self.regularKey.B_c.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    self.regularKey.B_chu.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    self.regularKey.B_cheng.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    self.regularKey.B_shan.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    self.regularKey.B_jian.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    self.regularKey.B_jia.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    self.regularKey.B_dengyu.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    [[NSUserDefaults standardUserDefaults]setObject:colorStr forKey:FYL_MainAppColor];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([self.navigationController.childViewControllers.firstObject isKindOfClass:[YLHomeViewController class]]) {
        YLHomeViewController * vc = (YLHomeViewController *)self.navigationController.childViewControllers.firstObject;
        [vc changeAppMainColor];
    }
}
-(void)creatUI{
    [self.dataArray addObject:@"#70b67f"];
    [self.dataArray addObject:@"#Bfde44"];
    [self.dataArray addObject:@"#Edbb37"];
    [self.dataArray addObject:@"#Ec9143"];
    [self.dataArray addObject:@"#E87a8d"];
    [self.dataArray addObject:@"#E865d6"];
    [self.dataArray addObject:@"#9358e1"];
    [self.dataArray addObject:@"#4b5dcc"];
    [self.dataArray addObject:@"#4099fe"];
    [self.dataArray addObject:@"#Cbcbcb"];
    [self.dataArray addObject:@"#6d6d6d"];
    [self.dataArray addObject:@"#26cafc"];
    [self.dataArray addObject:@"#1de1e9"];
    [self.dataArray addObject:@"#2a5078"];
    [self.dataArray addObject:@"#387a60"];
    [self.dataArray addObject:@"#386da5"];
    [self.dataArray addObject:@"#577a56"];
    [self.dataArray addObject:@"#1febae"];
    [self.dataArray addObject:@"#F7cd1c"];
    
    UIView * V_bg_top = [[UIView alloc]init];
    V_bg_top.backgroundColor = rgba(55, 55, 55, 1);
    [self.view addSubview:V_bg_top];
    [V_bg_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.view).mas_offset(100);
        make.right.mas_equalTo(self.view).mas_offset(-100);
        make.bottom.mas_equalTo(self.view).mas_offset(-320);
    }];
    CGFloat width_cell = (kScreenWidth-200)/4;
    CGFloat height_cell = width_cell;
    UIView * V_bg_bottom = [[UIView alloc]init];
    V_bg_bottom.backgroundColor = UIColor.blueColor;
    [V_bg_top addSubview:V_bg_bottom];
    [V_bg_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(V_bg_top);
        make.bottom.mas_equalTo(V_bg_top);
        make.height.mas_equalTo(height_cell*5);
    }];
    [self.regularKey initializeData];
    [V_bg_bottom addSubview:self.regularKey];
    [self.regularKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_bg_bottom);
    }];
    NSString * selColorIndex = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_MainAppColorIndex];
    if (IS_VALID_STRING(selColorIndex)) {
        self.sel_index = selColorIndex.intValue;
    }
    
    FYLRootCollectionView * collv = [[FYLRootCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:self.layOut];
    collv.backgroundColor = BACKCOLOR;
    collv.showsVerticalScrollIndicator = NO;
    collv.showsVerticalScrollIndicator = NO;
    collv.showsHorizontalScrollIndicator = NO;
    self.collectionView = collv;
    [self.collectionView registerNib:[UINib nibWithNibName:@"FYLThemeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FYLThemeCollectionViewCell"];
    [self.collectionView registerClass:[FYLThemeCollectionColorZDYViewCell class] forCellWithReuseIdentifier:@"FYLThemeCollectionColorZDYViewCell"];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@300);
    }];
    NSString * colorStr = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_MainAppColor];
    if (IS_VALID_STRING(colorStr) ) {
        self.regularKey.B_c.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
        self.regularKey.B_chu.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
        self.regularKey.B_cheng.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
        self.regularKey.B_shan.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
        self.regularKey.B_jian.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
        self.regularKey.B_jia.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
        self.regularKey.B_dengyu.backgroundColor = [UIColor jk_colorWithHexString:colorStr];
    }
   
    
    
    
}


-(FYLRegularKeyboardView *)regularKey{
    if (!_regularKey) {
        _regularKey = [[[NSBundle mainBundle]loadNibNamed:@"FYLRegularKeyboardView" owner:self options:nil]lastObject];
    }
    return _regularKey;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
