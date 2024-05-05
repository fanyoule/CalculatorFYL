//
//  FYLkeyboardViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLkeyboardViewController.h"
#import "YLHomeViewController.h"

#import "FYLkeyboardSelectView.h"

@interface FYLkeyboardViewController ()
<
FYLkeyboardSelectViewDelegate
>
@property(nonatomic,strong)FYLkeyboardSelectView * V_keyboard;
@property(nonatomic,copy)NSString * CHARACTERS;

@end

@implementation FYLkeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:16];
    
    [self creatUI];
    // Do any additional setup after loading the view.
}

#pragma mark -- 选择
-(void)fyl_keyboardSelectViewDidSelectedButton:(UIButton *)btn withType:(NSString *)type{
    UserDefaultSetObjectForKey(type, FYL_CHARACTERS)
    if ([self.navigationController.childViewControllers.firstObject isKindOfClass:[YLHomeViewController class]]) {
        YLHomeViewController * vc = (YLHomeViewController *)self.navigationController.childViewControllers.firstObject;
        [vc changeAppKeyBoard];
    }
}




-(void)creatUI{
    NSString * CHARACTERS = UserDefaultObjectForKey(FYL_CHARACTERS);
    if (CHARACTERS.intValue == 0 ) {
        self.V_keyboard.B_putong.selected = YES;
    }else{
        self.V_keyboard.B_guibin.selected = YES;
    }
    [self.view addSubview:self.V_keyboard];
    [self.V_keyboard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.and.bottom.and.right.mas_equalTo(self.view);
    }];
    
    
    
}
-(FYLkeyboardSelectView *)V_keyboard{
    if (!_V_keyboard) {
        _V_keyboard = [[[NSBundle mainBundle]loadNibNamed:@"FYLkeyboardSelectView" owner:self options:nil]lastObject];
        _V_keyboard.delegate = self;
    }
    return _V_keyboard;
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
