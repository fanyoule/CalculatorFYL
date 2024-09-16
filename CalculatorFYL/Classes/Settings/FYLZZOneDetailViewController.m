//
//  FYLZZOneDetailViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/26.
//

#import "FYLZZOneDetailViewController.h"
#import "FYLZZOneDetailViews.h"

@interface FYLZZOneDetailViewController ()
<
FYLZZOneDetailViewdelegate
>
@property(nonatomic,strong)FYLZZOneDetailViews * detailView;
@property(nonatomic,assign)NSInteger selectedIndex;
@end

@implementation FYLZZOneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"VIP";
    
    [self creatUI];
    // Do any additional setup after loading the view.
}
#pragma mark -- 恢复购买
-(void)rightItemClicked{
    NSLog(@"恢复购买");
    
}
#pragma mark -- 选中
-(void)fyl_OneDetailViewDidSelectedButtonClicked:(UIButton *)btn{
    if (btn.tag == 0) {
        self.selectedIndex = 1;
        self.detailView.B_one.selected = YES;
        self.detailView.B_two.selected = NO;
        UserDefaultSetObjectForKey(@"0", FYL_CHARACTERS);
    }else if (btn.tag == 1){
        self.selectedIndex = 2;
        self.detailView.B_one.selected = NO;
        self.detailView.B_two.selected = YES;
        UserDefaultSetObjectForKey(@"1", FYL_CHARACTERS);
    }else if (btn.tag == 2){//Purchase
       
        
        
    }
    
}





-(void)creatUI{
    self.yl_rightButton.titleLabel.font = Px30Font;
    [self.yl_rightButton setTitle:[YLUserToolManager getTextTag:28] forState:UIControlStateNormal];
    [self.view addSubview:self.yl_rightButton];
    [self.yl_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navigationBar.titleLab);
        make.right.mas_equalTo(self.view).mas_offset(-10);
    }];
    
    
    
    FYLZZOneDetailViews * view = [[[NSBundle mainBundle]loadNibNamed:@"FYLZZOneDetailViews" owner:self options:nil]lastObject];
    self.detailView = view;
    view.delegate = self;
    [view.B_three setTitle:[YLUserToolManager getTextTag:27] forState:UIControlStateNormal];
    
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-YX_TabbarSafetyZone);
    }];
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
