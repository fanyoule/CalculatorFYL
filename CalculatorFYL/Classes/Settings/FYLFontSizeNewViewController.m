//
//  FYLFontSizeNewViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLFontSizeNewViewController.h"
#import "FYLFontSizeView.h"

@interface FYLFontSizeNewViewController ()
@property(nonatomic,strong)FYLFontSizeView * V_fontSize;
@end

@implementation FYLFontSizeNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:17];
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}

-(void)creatUI{
    [self.view addSubview:self.V_fontSize];
    [self.V_fontSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.and.bottom.and.right.mas_equalTo(self.view);
    }];
    
}
-(FYLFontSizeView *)V_fontSize{
    if (!_V_fontSize) {
        _V_fontSize = [[[NSBundle mainBundle]loadNibNamed:@"FYLFontSizeView" owner:self options:nil]lastObject];
        [_V_fontSize creatUI];
//        _V_fontSize.delegate = self;
    }
    return _V_fontSize;
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
