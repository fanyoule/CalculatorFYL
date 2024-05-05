//
//  FYLDecimalPlaceViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/5/5.
//

#import "FYLDecimalPlaceViewController.h"
#import "FYLSettingsListCell.h"


@interface FYLDecimalPlaceViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,copy)NSString * indexSel;

@end

@implementation FYLDecimalPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:18];
    
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
        if (self.indexSel.intValue-1 == indexPath.row) {
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
    self.indexSel = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableV reloadData];
    });
   UserDefaultSetObjectForKey(self.indexSel, FYL_DecimalPlace)

}



-(void)creatUI{
    [self.dataArray addObject:@"1"];
    [self.dataArray addObject:@"2"];
    [self.dataArray addObject:@"3"];
    [self.dataArray addObject:@"4"];
    [self.dataArray addObject:@"5"];
    [self.dataArray addObject:@"6"];
    [self.dataArray addObject:@"7"];
    [self.dataArray addObject:@"8"];
    [self.dataArray addObject:@"9"];
    [self.dataArray addObject:@"10"];
    [self.dataArray addObject:@"11"];
    
    NSString * yy = UserDefaultObjectForKey(FYL_DecimalPlace);
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
