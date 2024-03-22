//
//  FYLCreatePasswordViewController.m
//  JoyLight
//
//  Created by tianhao on 2024/2/26.
//

#import "FYLCreatePasswordViewController.h"
#import "YLMySetViewController.h"
#import "SHMEmojiMethod.h"

@interface FYLCreatePasswordViewController ()
<
UITextFieldDelegate
>
@property(nonatomic,strong)UITextField * T_one_password;
@property(nonatomic,strong)UITextField * T_two_password;


@end

@implementation FYLCreatePasswordViewController

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
        self.T_one_password.secureTextEntry = NO;
    }else{
        self.T_one_password.secureTextEntry = YES;
    }
    
}
-(void)passWordTwoSelectedClicked:(UIButton *)btn{
    btn.selected =! btn.selected;
    if(btn.selected){
        self.T_two_password.secureTextEntry = NO;
    }else{
        self.T_two_password.secureTextEntry = YES;
    }
    
}
#pragma mark -- 完成
-(void)didSelectedBaseButtonClicked:(UIButton *)btn{
    [self buttonClickedpasswordlogin];
}
-(void)buttonClickedpasswordlogin{
    [self.view endEditing:YES];
    if (!IS_VALID_STRING(self.T_one_password.text)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please enter a new password", nil) delay:2];
        return;
    }
    if (!IS_VALID_STRING(self.T_two_password.text)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please enter the confirmation password", nil) delay:2];
        return;
    }
    if(![self.T_one_password.text isEqualToString:self.T_two_password.text]){
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please enter the correct confirmation password", nil) delay:2];
        return;
    }
    
    if (!IS_VALID_STRING(self.uuid)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please get the verification code again", nil) delay:2];
        return;
    }
    if (!IS_VALID_STRING(self.email)) {
        [SVProgressHUD showDetailMessage:NSLocalizedString(@"Please re-enter your email", nil) delay:2];
        return;
    }
    [MBProgressHUD showMessage:@"" toView:YX_Keywindow];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    NSString * url = API_UserRegister;
    if ([self fyl_getLocalAddressType] == 1) {
        if (self.type == 1) {//注册
            url = API_PhoneRegister;
        }else if (self.type == 2){//忘记密码
            if (ZJ_UserLoginInfomation.getLogin) {
                url = API_PhoneUpdPasswordLogin;
            }else{
                url = API_PhoneUpdPassword;
            }
        }
        [parameters setObject:self.email forKey:@"account"];
        [parameters setObject:self.T_one_password.text forKey:@"password"];
        [parameters setObject:self.T_two_password.text forKey:@"passwordConfirm"];
        [parameters setObject:self.uuid forKey:@"uuid"];
    }else{
        if (self.type == 2) {
            if (ZJ_UserLoginInfomation.getLogin) {
                url = WIFI_EmailPassword;
                [parameters setObject:self.email forKey:@"email"];
                [parameters setObject:self.T_one_password.text forKey:@"newPwd"];
                [parameters setObject:self.T_two_password.text forKey:@"confirmPwd"];
                [parameters setObject:self.uuid forKey:@"uuid"];
            }else{
                url = API_UserUpdPassword;
                [parameters setObject:self.email forKey:@"account"];
                [parameters setObject:self.T_one_password.text forKey:@"password"];
                [parameters setObject:self.T_two_password.text forKey:@"passwordConfirm"];
                [parameters setObject:self.uuid forKey:@"uuid"];
            }
        }else{
            [parameters setObject:self.email forKey:@"account"];
            [parameters setObject:self.T_one_password.text forKey:@"password"];
            [parameters setObject:self.T_two_password.text forKey:@"passwordConfirm"];
            [parameters setObject:self.uuid forKey:@"uuid"];
        }
    }
    
    
//    [[YXHTTPRequst shareInstance]networking:url parameters:parameters method:YXRequstMethodTypePOST showErrorView:YES success:^(NSURLSessionDataTask *task, id responseObject) {
//        [MBProgressHUD hideHUDForView:YX_Keywindow animated:YES];
//        
//        BaseModel * baseModel = [BaseModel loadModelWithDictionary:responseObject];
//        if(baseModel.code.intValue==1){
//            if (ZJ_UserLoginInfomation.getLogin) {
//
//                if (self.navigationController.childViewControllers.count>1) {
//                    YLMySetViewController * vc = (YLMySetViewController *)self.navigationController.childViewControllers[1];
//                    [self.navigationController popToViewController:vc animated:YES];
//                }
//
//            }else{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//
//
//            }
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
    
    [self changeTitle:NSLocalizedString(@"Create password", nil)];
    
   
    
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
    [B_codeShow setImage:[UIImage imageNamed:@"passwordChangeHidden_icon"] forState:UIControlStateNormal];
    [B_codeShow setImage:[UIImage imageNamed:@"passwordChangeSel_icon"] forState:UIControlStateSelected];
    [B_codeShow addTarget:self action:@selector(codeShowSelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
    [V_bg_text addSubview:B_codeShow];
    [B_codeShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(V_bg_text);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    UITextField * T_one_password = [[UITextField alloc]init];
    self.T_one_password = T_one_password;
    self.T_one_password.secureTextEntry = YES;
    T_one_password.delegate = self;
    [T_one_password limitTextLength:18];
    NSString *holderText = NSLocalizedString(@"Create password", nil);
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                            value:rgba(180, 180, 180, 1)
                            range:NSMakeRange(0, holderText.length)];
    T_one_password.attributedPlaceholder = placeholder;
    T_one_password.textColor = UIColor.blackColor;
    T_one_password.font = Px28Font;
    T_one_password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [V_bg_text addSubview:T_one_password];
    [T_one_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_bg_text).mas_offset(15);
        make.centerY.mas_equalTo(V_bg_text);
        make.right.mas_equalTo(B_codeShow.mas_left).mas_offset(-10);
        make.height.mas_equalTo(25);
    }];
   
    UIView * V_bg_textTwo = [[UIView alloc]init];
    [self.view addSubview:V_bg_textTwo];
    [V_bg_textTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_bg_text.mas_bottom).mas_offset(AdaptedHeightValue(15));
        make.left.mas_equalTo(V_bg_text);
        make.right.mas_equalTo(V_bg_text);
        make.height.mas_equalTo(V_bg_text);
    }];
    UIImageView * M_bg_textTwo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"inputText_bg"]];
    [V_bg_textTwo addSubview:M_bg_textTwo];
    [M_bg_textTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(V_bg_textTwo);
    }];
    
    
    UIButton * B_passWordTwo = [UIButton buttonWithType:UIButtonTypeCustom];
//    B_passWordTwo.backgroundColor = UIColor.redColor;
    B_passWordTwo.frame = CGRectMake(0, 0, 50, 50);
    [B_passWordTwo setImage:[UIImage imageNamed:@"passwordChangeHidden_icon"] forState:UIControlStateNormal];
    [B_passWordTwo setImage:[UIImage imageNamed:@"passwordChangeSel_icon"] forState:UIControlStateSelected];
    [B_passWordTwo addTarget:self action:@selector(passWordTwoSelectedClicked:) forControlEvents:UIControlEventTouchUpInside];
    [V_bg_textTwo addSubview:B_passWordTwo];
    [B_passWordTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(V_bg_textTwo);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UITextField * T_two_password = [[UITextField alloc]init];
    self.T_two_password = T_two_password;
    T_two_password.delegate = self;
    self.T_two_password.secureTextEntry = YES;
    [T_two_password limitTextLength:18];
    NSString *holderTexts = NSLocalizedString(@"confirm password", nil);
    NSMutableAttributedString *placeholders = [[NSMutableAttributedString alloc] initWithString:holderTexts];
    [placeholders addAttribute:NSForegroundColorAttributeName
                            value:rgba(180, 180, 180, 1)
                            range:NSMakeRange(0, holderTexts.length)];
    T_two_password.attributedPlaceholder = placeholders;
    T_two_password.textColor = UIColor.blackColor;
    T_two_password.font = Px28Font;
    T_two_password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [V_bg_textTwo addSubview:T_two_password];
    [T_two_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(V_bg_textTwo).mas_offset(15);
        make.centerY.mas_equalTo(V_bg_textTwo);
        make.right.mas_equalTo(B_passWordTwo.mas_left).mas_offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    ZZLabel * L_tip_contect = [[ZZLabel alloc]initWithTextColor:rgba(61, 61, 61, 1) Font:Px22Font TextString:@"The password length must be between 6 and 18 digits, including English numbers"];
    L_tip_contect.numberOfLines = 0;
    [self.V_bg_contect addSubview:L_tip_contect];
    [L_tip_contect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_bg_textTwo.mas_bottom).mas_offset(AdaptedHeightValue(17));
        make.left.and.right.mas_equalTo(V_bg_textTwo);
    }];
    
   
    UIButton * B_passwordlogin = [self creatButtonTitle:NSLocalizedString(@"Done", nil) withFont:Px32Font withTitleColor:rgba(255, 255, 255, 1) withImageName:@"SelectedDeviceSureBtn_bg" withBackGroundColor:UIColor.clearColor withTag:2];
    [self.V_bg_contect addSubview:B_passwordlogin];
    [B_passwordlogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(V_bg_textTwo.mas_bottom).mas_offset(AdaptedHeightValue(140));
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
