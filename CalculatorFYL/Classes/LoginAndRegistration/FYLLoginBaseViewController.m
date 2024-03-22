//
//  FYLLoginBaseViewController.m
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "FYLLoginBaseViewController.h"

@interface FYLLoginBaseViewController ()
//顶部 标题
@property (nonatomic,strong)ZZLabel * L_login;


@end

@implementation FYLLoginBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view.
}
-(void)openSocketUrl{
   
}

#pragma mark -- 关闭
-(void)rightItemClicked{
    if (self.navigationController.childViewControllers.count>1) {
        [[ZZAlertViewTools alloc]showAlert:@"" message:@"Do you want to cancel this registration/login" cancelTitle:@"Cancel" titleArray:@[NSLocalizedString(@"Make sure", nil)] confirm:^(NSInteger buttonTag) {
            if(buttonTag==0){
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                }];
            }
        }];
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}
/**
 * 获取 当前是国内 or 国外
 * 1国内  0国外
 */
-(NSInteger)fyl_getLocalAddressType{
    NSString * address = [[NSUserDefaults standardUserDefaults]objectForKey:CountriesAddress];
    if(IS_VALID_STRING(address)&&[address isEqualToString:@"CN"]){//国内
        return 1;
    }
    return 0;
}
///创建的按钮被点击了
-(void)didSelectedBaseButtonClicked:(UIButton *)btn{
    NSLog(@"btn.tag--:%ld",btn.tag);
    
}


-(void)changeTitle:(NSString *)title{
    self.L_login.text = title;
}


-(void)creatUI{
    
//    [self.yl_rightButton setImage:[UIImage imageNamed:@"logo_closeIcon"] forState:UIControlStateNormal];
    [self setNavRightItem:@"" withImage:[UIImage imageNamed:@"logo_closeIcon"]];
    UIImageView * M_top_logoicon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_top_icon"]];
    [self.view addSubview:M_top_logoicon];
    [M_top_logoicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.mas_equalTo(self.view).mas_offset(AdaptedWidthValue(30));
        make.size.mas_equalTo(CGSizeMake(AdaptedWidthValue(60), AdaptedWidthValue(60)));
    }];
    
    UIImageView * M_top_logotitle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_title"]];
    [self.view addSubview:M_top_logotitle];
    [M_top_logotitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(M_top_logoicon.mas_right).mas_offset(14);
        make.centerY.mas_equalTo(M_top_logoicon).mas_offset(0);
        
    }];

    ZZLabel * L_login = [[ZZLabel alloc]initWithTextColor:rgba(255, 255, 255, 1) Font:PxM28Font TextString:@"Password login"];
    L_login.numberOfLines = 2;
    self.L_login = L_login;
    [self.view addSubview:L_login];
    [L_login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(M_top_logoicon.mas_bottom).mas_offset(AdaptedHeightValue(20));
        make.left.mas_equalTo(M_top_logoicon);
        make.right.mas_equalTo(self.view).mas_offset(-AdaptedWidthValue(30));
    }];
    UIView * V_bg_contect = [[UIView alloc]init];
    self.V_bg_contect = V_bg_contect;
    V_bg_contect.backgroundColor = BACKCOLOR;
    [self.view addSubview:V_bg_contect];
    [V_bg_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(L_login.mas_bottom).mas_offset(AdaptedHeightValue(10));
        make.left.and.bottom.and.right.mas_equalTo(self.view);
    }];
    V_bg_contect.layer.cornerRadius = 16.0f;
    V_bg_contect.layer.masksToBounds = YES;
    if (ZJ_UserLoginInfomation.getLogin) {
        self.navigationBar.rightView.hidden = YES;
    }
}
-(UIButton *)creatButtonTitle:(NSString *_Nullable)title withFont:(UIFont *_Nullable)font withTitleColor:(UIColor *_Nullable)color withImageName:(NSString *_Nullable)imageName withBackGroundColor:(UIColor * _Nullable)bgColor withTag:(NSInteger)tag{
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.tag = tag;
    if (IS_VALID_STRING(title)) {
        [Btn setTitle:title forState:UIControlStateNormal];
    }
    if (!IsNullObject(color)) {
        [Btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (IS_VALID_STRING(imageName)) {
        [Btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    [Btn addTarget:self action:@selector(didSelectedBaseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (!IsNullObject(font)) {
        Btn.titleLabel.font = font;
    }
    if (!IsNullObject(bgColor)) {
        Btn.backgroundColor = bgColor;
    }
    return Btn;
}

-(NSArray *)creatTextFieldHolderText:(NSString *_Nullable)holderText withTextFont:(UIFont *_Nullable)font withTextColor:(UIColor *_Nullable)textColor withTag:(NSInteger)tag{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    UIImageView * M_bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"inputText_bg"]];
    [V_root addSubview:M_bg];
    [M_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_root);
    }];
    
    UITextField * T_phone = [[UITextField alloc]init];
    T_phone.tag = tag;
    if (IS_VALID_STRING(holderText)) {
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:rgba(180, 180, 180, 1)
                            range:NSMakeRange(0, holderText.length)];
        T_phone.attributedPlaceholder = placeholder;
        
    }
    if (!IsNullObject(textColor)) {
        T_phone.textColor = textColor;
    }
    if (!IsNullObject(font)) {
        T_phone.font = font;
    }
    T_phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    [V_root addSubview:T_phone];
    [T_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_root).mas_offset(AdaptedWidthValue(10));
        make.centerY.mas_equalTo(V_root);
        make.right.mas_equalTo(V_root).mas_offset(-AdaptedWidthValue(10));
        make.height.mas_equalTo(V_root);
    }];
    return @[V_root,T_phone];
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
