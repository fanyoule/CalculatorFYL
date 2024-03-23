//
//  YLHomeViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/3/21.
//

#import "YLHomeViewController.h"
#import "FYLHistoricalRecordCell.h"
#import "FYLRegularKeyboardView.h"
#import "FYLVIPKeyboardView.h"

@interface YLHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
FYLRegularKeyboardViewdelegate
>
@property(nonatomic,strong)ZZLabel * L_contect;
@property(nonatomic,strong)UIView * V_contect;
@property(nonatomic,strong)UIView * V_storehistory;
@property(nonatomic,strong)UIScrollView * V_scroll;
@property(nonatomic,strong)UIView * V_bg_bottom;
@property(nonatomic,strong)FYLRegularKeyboardView * regularKey;
@property(nonatomic,strong)FYLVIPKeyboardView * vipKey;

///方向 0向下 1向上
@property(nonatomic,assign)NSInteger directionType;
@end

@implementation YLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    NSLog(@"%@---%@",NSStringFromCGRect(self.view.frame) ,NSStringFromCGRect(self.view.frame));
}

-(void)fyl_RegularKeyboardDidSelectedButton:(UIButton *)btn{
    NSString * title = btn.titleLabel.text;
    self.L_contect.text = [NSString stringWithFormat:@"%@%@",self.L_contect.text,title];
    
}


#pragma mark -- 向下or向上
-(void)didSelectedxiagxiaClicked:(UIButton *)btn{
    if (self.directionType == 1) {//向上
        self.directionType = 0;
        self.V_storehistory.hidden = YES;
        [UIView animateWithDuration:2 animations:^{
            CGFloat width_cell = kScreenWidth/4;
            CGFloat height_cell = width_cell;
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_cell*2);
            }];
        } completion:^(BOOL finished) {
            [btn setTitle:@"下" forState:UIControlStateNormal];
            CGFloat width_cell = kScreenWidth/4;
            CGFloat height_cell = width_cell;
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_cell*5);
            }];
        }];
        
    }else{
        self.directionType = 1;
        [UIView animateWithDuration:2 animations:^{
            CGFloat width_cell = kScreenWidth/4;
            CGFloat height_cell = width_cell;
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height_cell*2);
            }];
        } completion:^(BOOL finished) {
            self.V_storehistory.hidden = NO;
            [btn setTitle:@"上" forState:UIControlStateNormal];
            [self.V_bg_bottom mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@0);
            }];
        }];
    
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    V_root.backgroundColor = UIColor.yellowColor;
    ZZLabel * L_title = [[ZZLabel alloc]initWithTextColor:UIColor.redColor Font:Px30Font TextString:@"2024.03.11"];
    [V_root addSubview:L_title];
    L_title.frame = V_root.frame;
    [V_root addSubview:L_title];
    return V_root;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLHistoricalRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLHistoricalRecordCell" forIndexPath:indexPath];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}




-(void)creatUI{
    self.view.backgroundColor = UIColor.blackColor;
    CGFloat width_cell = kScreenWidth/4;
    CGFloat height_cell = width_cell;
    UIView * V_bg_bottom = [[UIView alloc]init];
    self.V_bg_bottom = V_bg_bottom;
    V_bg_bottom.backgroundColor = UIColor.blueColor;
    [self.view addSubview:V_bg_bottom];
//    V_bg_bottom.frame = CGRectMake(0, kScreenHeight-SBottomSafeHeight-height_cell*5, kScreenWidth, height_cell*5);
    [V_bg_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(height_cell*5);
    }];
    
//    [V_bg_bottom addSubview:self.vipKey];
//    [self.vipKey mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(V_bg_bottom);
//    }];
    
    [self.regularKey initializeData];
    [V_bg_bottom addSubview:self.regularKey];
    [self.regularKey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_bg_bottom);
    }];
    
    UIView * V_contect = [[UIView alloc]init];
    V_contect.backgroundColor = UIColor.blackColor;
    [self.view addSubview:V_contect];
    [V_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(V_bg_bottom.mas_top);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(20+50);
    }];
    UIButton * B_top = [UIButton buttonWithType:0];
    [B_top setTitle:NSLocalizedString(@"下", nil) forState:UIControlStateNormal];
    [B_top addTarget:self action:@selector(didSelectedxiagxiaClicked:) forControlEvents:UIControlEventTouchUpInside];
    [V_contect addSubview:B_top];
    [B_top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_contect);
        make.left.mas_equalTo(V_contect).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    UIScrollView * V_scroll = [[UIScrollView alloc]init];
    self.V_scroll = V_scroll;
    V_scroll.contentSize = CGSizeMake(kScreenWidth*2, 30);
    [V_contect addSubview:V_scroll];
    [V_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_top.mas_bottom);
        make.left.bottom.right.mas_equalTo(V_contect);
    }];
    UIView * v_line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    [V_scroll addSubview:v_line];
    
    ZZLabel * L_contect = [[ZZLabel alloc]initWithTextColor:UIColor.whiteColor Font:[YLUserToolManager getAppTitleFont] TextString:@""];
    L_contect.textAlignment = NSTextAlignmentRight;
    self.L_contect = L_contect;
    [V_scroll addSubview:L_contect];
    [L_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v_line.mas_bottom);
        make.left.bottom.mas_equalTo(V_contect);
        make.width.mas_equalTo(kScreenWidth);
    }];
    UIView * V_bg_storehistory = [[UIView alloc]init];
    V_bg_storehistory.hidden = YES;
    self.V_storehistory = V_bg_storehistory;
    V_bg_storehistory.backgroundColor = UIColor.redColor;
    [V_contect addSubview:V_bg_storehistory];
    [V_bg_storehistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_top.mas_bottom);
        make.left.bottom.right.mas_equalTo(V_contect);
    }];
    
    
    self.table_groupV.backgroundColor = UIColor.clearColor;
    [self.view addSubview:self.table_groupV];
    self.table_groupV.delegate = self;
    self.table_groupV.dataSource = self;
    [self.table_groupV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar).mas_offset(20);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(V_contect.mas_top);
    }];
    
    [self.table_groupV registerNib:[UINib nibWithNibName:@"FYLHistoricalRecordCell" bundle:nil] forCellReuseIdentifier:@"FYLHistoricalRecordCell"];
    [self.view layoutIfNeeded];
    
}

-(FYLRegularKeyboardView *)regularKey{
    if (!_regularKey) {
        _regularKey = [[[NSBundle mainBundle]loadNibNamed:@"FYLRegularKeyboardView" owner:self options:nil]lastObject];
        _regularKey.delegate = self;
    }
    return _regularKey;
}
-(FYLVIPKeyboardView *)vipKey{
    if (!_vipKey) {
        _vipKey = [[[NSBundle mainBundle]loadNibNamed:@"FYLVIPKeyboardView" owner:self options:nil]lastObject];
    }
    return _vipKey;
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
