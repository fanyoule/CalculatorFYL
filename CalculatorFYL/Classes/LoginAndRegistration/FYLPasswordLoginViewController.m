//
//  FYLPasswordLoginViewController.m
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "FYLPasswordLoginViewController.h"
#import "SHMEmojiMethod.h"
#import "FYLForgotPasswordViewController.h"

@interface FYLPasswordLoginViewController ()
<UITextFieldDelegate>
@property(nonatomic,strong)UITextField * T_password;

@end

@implementation FYLPasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPopBackItem];
    [self yl_creatUI];
    
    // Do any additional setup after loading the view.
}
#pragma mark -- 密码明文or密文
-(void)codeShowSelectedClicked:(UIButton *)btn{
    btn.selected =! btn.selected;
    if(btn.selected){
        self.T_password.secureTextEntry = NO;
    }else{
        self.T_password.secureTextEntry = YES;
    }
    
}
#pragma mark -- 忘记密码
-(void)buttonClickedForgetPassword:(UIButton *)btn{
    [self.view endEditing:YES];
   
    FYLForgotPasswordViewController * vc = [[FYLForgotPasswordViewController alloc]init];
    vc.type = ForgotPasswordTypeFromForgot;
    vc.email = self.eamal;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 密码登录
-(void)didSelectedBaseButtonClicked:(UIButton *)btn{
    [self buttonClickedpasswordlogin];
}
-(void)buttonClickedpasswordlogin{
   
    [self.view endEditing:YES];
    if (!IS_VALID_STRING(self.T_password.text)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"please enter password", nil) delay:2];
        return;
    }
    if (!IS_VALID_STRING(self.eamal)) {
        return;
    }
   
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary * parm = [NSMutableDictionary dictionary];
    NSString * url = WIFI_UserLogin;
    [parm setObject:self.eamal forKey:@"account"];
    [parm setObject:self.T_password.text forKey:@"password"];
//    [[YXHTTPRequst shareInstance]networking:url parameters:parm method:YXRequstMethodTypePOST showErrorView:YES  success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//
//        BaseModel * BModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(BModel.code.intValue==1){
//            [[NSUserDefaults standardUserDefaults] setObject:self.eamal forKey:@"userPhone"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            //登录成功，保存信息
//            NSDictionary *infoDic =(NSDictionary *) responseObject[@"data"];
//            [ZJ_UserLoginInfomation userInfoWithDict:infoDic];
//            //返回到根视图
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [[NSNotificationCenter defaultCenter]postNotificationName:FYL_LoginSeccessRefreshData object:self];
//                [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                }];
//            });
//            
//
//        }
//    } failsure:^(NSURLSessionDataTask *task, id cacheData, NSError * error) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//
//    }];
    
    
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([SHMEmojiMethod iosCurrentKeyType]) {
        //   限制苹果系统输入法  禁止输入表情
        if ([SHMEmojiMethod iosStringContainsEmoji]) {
            return NO;
        }
        //判断是否输入了emoji 表情
        if ([SHMEmojiMethod yl_stringContainsEmoji:string]) {
            return NO;
        }
    }else{
        //判断是否输入了emoji 表情
        if ([SHMEmojiMethod yl_stringContainsEmoji:string]) {
            return NO;
        }
    }
    //禁止输入空格
    NSString *blank = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if(![string isEqualToString:blank]) {
        return NO;
    }
    return YES;
}




-(void)yl_creatUI{
    [self changeTitle:NSLocalizedString(@"Password login", nil)];
   
    
    UIView * V_bg_text = [[UIView alloc]init];
    [self.V_bg_contect addSubview:V_bg_text];
    [V_bg_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedHeightValue(40));
        make.left.mas_equalTo(self.V_bg_contect).mas_offset(AdaptedWidthValue(30));
        make.right.mas_equalTo(self.V_bg_contect).mas_offset(-AdaptedWidthValue(30));
        make.height.mas_equalTo(AdaptedHeightValue(50));
    }];
    UIImageView * M_bg_text = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"inputText_bg"]];
    [V_bg_text addSubview:M_bg_text];
    [M_bg_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_bg_text);
    }];
    UIButton * B_codeShow = [UIButton buttonWithType:UIButtonTypeCustom];
//    B_codeShow.backgroundColor = UIColor.redColor;
    [B_codeShow setImage:[UIImage imageNamed:@"passwordChangeHidden_icon"] forState:UIControlStateNormal];
    [B_codeShow setImage:[UIImage imageNamed:@"passwordChangeSel_icon"] forState:UIControlStateSelected];
    [B_codeShow addTarget:self action:@selector(codeShowSelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
    [V_bg_text addSubview:B_codeShow];
    [B_codeShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(V_bg_text);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    UITextField * T_password = [[UITextField alloc]init];
    self.T_password = T_password;
    T_password.secureTextEntry = YES;
    T_password.delegate = self;
    NSString *holderText = NSLocalizedString(@"please enter password", nil);
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                            value:rgba(180, 180, 180, 1)
                            range:NSMakeRange(0, holderText.length)];
    T_password.attributedPlaceholder = placeholder;
    T_password.textColor = UIColor.blackColor;
    T_password.font = Px28Font;
    T_password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [V_bg_text addSubview:T_password];
    [T_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_bg_text).mas_offset(15);
        make.centerY.mas_equalTo(V_bg_text);
        make.right.mas_equalTo(B_codeShow.mas_left).mas_offset(-10);
        make.height.mas_equalTo(25);
    }];
    //忘记密码
    UIButton * B_Forgot = [UIButton buttonWithType:UIButtonTypeCustom];
    [B_Forgot setTitle:NSLocalizedString(@"Forget password", nil) forState:UIControlStateNormal];
    B_Forgot.titleLabel.font = Px20Font;
    [B_Forgot setTitleColor:rgba(16, 186, 238, 1) forState:UIControlStateNormal];
    [B_Forgot addTarget:self action:@selector(buttonClickedForgetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.V_bg_contect addSubview:B_Forgot];
    [B_Forgot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_bg_text.mas_bottom).mas_offset(AdaptedHeightValue(15));
        make.right.mas_equalTo(V_bg_text).mas_offset(-AdaptedWidthValue(14));
    }];
   
    
    
    
    
    //密码登录
    UIButton * B_passwordlogin = [self creatButtonTitle:NSLocalizedString(@"Password login", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:UIColor.clearColor withTag:2];
    [self.V_bg_contect addSubview:B_passwordlogin];
    [B_passwordlogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(B_Forgot.mas_bottom).mas_offset(AdaptedHeightValue(140));
        make.left.mas_equalTo(V_bg_text);
        make.right.mas_equalTo(V_bg_text);
        make.height.mas_equalTo(AdaptedHeightValue(40));
    }];
    B_passwordlogin.layer.cornerRadius = AdaptedHeightValue(40)/2;
    B_passwordlogin.layer.masksToBounds = YES;
    B_passwordlogin.backgroundColor = rgba(16, 186, 238, 1);
    
    
    
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
