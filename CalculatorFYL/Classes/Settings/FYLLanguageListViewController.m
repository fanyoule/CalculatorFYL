//
//  FYLLanguageListViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLLanguageListViewController.h"
#import "FYLSettingsListCell.h"

@interface FYLLanguageListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic,copy)NSString * indexSel;


@end

@implementation FYLLanguageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:22];
    [self creatUI];
    // Do any additional setup after loading the view.
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLSettingsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLSettingsListCell" forIndexPath:indexPath];
    [cell changeUIType:6];
    if (IS_VALID_STRING(self.indexSel)) {
        if (self.indexSel.intValue == indexPath.row) {
            cell.M_sel.hidden = NO;
        }else{
            cell.M_sel.hidden = YES;
        }
    }
    if (self.dataArray.count>indexPath.row) {
        NSString * str = self.dataArray[indexPath.row];
        NSString * title = str;
        cell.L_title.text = title;
        if (self.dataArray.count == indexPath.row + 1) {
            cell.V_line.hidden = YES;
        }else{
            cell.V_line.hidden = NO;
        }
      }
   
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.indexSel = [NSString stringWithFormat:@"%ld",indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableV reloadData];
    });
   UserDefaultSetObjectForKey(self.indexSel, FYL_LanguageType)

}



-(void)creatUI{
    [self.dataArray addObject:[YLUserToolManager getTextTag:42]];
    [self.dataArray addObject:@"简体中文"];
    [self.dataArray addObject:@"繁体中文"];
    [self.dataArray addObject:@"English"];
    [self.dataArray addObject:@"日本語"];
    [self.dataArray addObject:@"한국어"];
    [self.dataArray addObject:@"Русский"];
    [self.dataArray addObject:@"Italiano"];
    [self.dataArray addObject:@"Français"];
    [self.dataArray addObject:@"Deutsch"];
    [self.dataArray addObject:@"العربية"];
    [self.dataArray addObject:@"Polski"];
    [self.dataArray addObject:@"Dansk"];
    [self.dataArray addObject:@"Suomi"];
    [self.dataArray addObject:@"Nederlands"];
   
    
    
    NSString * yy = UserDefaultObjectForKey(FYL_LanguageType);
    self.indexSel =[NSString stringWithFormat:@"%d",yy.intValue];
    self.tableV.backgroundColor = UIColor.blackColor;
    [self.tableV registerNib:[UINib nibWithNibName:@"FYLSettingsListCell" bundle:nil] forCellReuseIdentifier:@"FYLSettingsListCell"];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.and.bottom.and.right.mas_equalTo(self.view);
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
