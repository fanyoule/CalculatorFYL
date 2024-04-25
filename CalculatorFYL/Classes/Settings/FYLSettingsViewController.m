//
//  FYLSettingsViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/22.
//

#import "FYLSettingsViewController.h"
//#import "FYLlocalArchiveTableViewCell.h"
#import "FYLSettingsListCell.h"
#import <StoreKit/StoreKit.h>

@interface FYLSettingsViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIDocumentInteractionControllerDelegate
>
@property(nonatomic,strong)UIDocumentInteractionController *documentInteractionController;

@end

@implementation FYLSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle  = [YLUserToolManager getTextTag:9];
    
    [self creatUI];
    
    // Do any additional setup after loading the view.
}
#pragma mark -- APP评价
-(void)getAPPEvaluation{
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [SKStoreReviewController requestReview];
     
    }else{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/id6444903068?mt=8&action=write-review"] options:@{} completionHandler:^(BOOL success) {
                
        }];
    }
    
                            
    
    
}
#pragma mark -- 分享APP
- (void)shareInApp {
    UIImage* image = [UIImage imageNamed:@"logo.png"];
    NSString *text = @"I found an Awesome application software! InstaDown";
    //https://itunes.apple.com/us/app/id1260302654?l=zh&ls=1&mt=8

    NSURL *urlToShare = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?l=zh&ls=1&mt=8",@"6444903068"]];
    NSArray *activityItems = @[text,image,urlToShare];
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:avc animated:TRUE completion:nil];
    // 选中分享类型
    [avc setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        // 显示选中的分享类型
        NSLog(@"act type %@",activityType);
        if (completed) {
        NSLog(@"ok");
        }else {
        NSLog(@"no ok");
        }
    }];
    UIPopoverPresentationController *popover = avc.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.view;
        popover.sourceRect = self.view.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count>section) {
        NSArray * arr = self.dataArray[section];
        return arr.count;
    }
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    V_root.backgroundColor = UIColor.clearColor;
    return V_root;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    V_root.backgroundColor = UIColor.blackColor;
    return V_root;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLSettingsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLSettingsListCell" forIndexPath:indexPath];
    if (self.dataArray.count>indexPath.section) {
        NSArray * arr = self.dataArray[indexPath.section];
        if (arr.count>indexPath.row) {
            NSString * title = arr[indexPath.row];
            cell.L_title.text = title;
        }
        if (arr.count == indexPath.row + 1) {
            cell.V_line.hidden = YES;
        }else{
            cell.V_line.hidden = NO;
        }
      }
    if (indexPath.section == 0) {
        [cell changeUIType:1];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [cell changeUIType:2];
        }else if (indexPath.row == 1){
            [cell changeUIType:3];
        }else if (indexPath.row == 2){
            [cell changeUIType:4];
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0||indexPath.row == 1||indexPath.row == 2) {
            [cell changeUIType:0];
        }else if (indexPath.row == 3||indexPath.row == 4||indexPath.row == 5){
            [cell changeUIType:4];
        }
    }else if (indexPath.section == 3||indexPath.section == 4){
        [cell changeUIType:0];
    }else if (indexPath.section == 5||indexPath.section == 6){
        [cell changeUIType:5];
        if (indexPath.section == 5) {
            cell.L_contect.text = [YLUserToolManager getTextTag:25];
        }else if (indexPath.section == 6){
            cell.L_contect.text = [YLUserToolManager getTextTag:26];
        }
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        
    }else if (indexPath.section == 3){
        
    }else if (indexPath.section == 4){
        
    }else if (indexPath.section == 5){
        if (indexPath.row == 0) {
            [self shareInApp];
        }
    }else if (indexPath.section == 6){
        if (indexPath.row == 0) {
            [self getAPPEvaluation];
        }
    }
    
}


-(void)creatUI{
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:12]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:13],[YLUserToolManager getTextTag:14],[YLUserToolManager getTextTag:15]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:16],[YLUserToolManager getTextTag:17],[YLUserToolManager getTextTag:18],[YLUserToolManager getTextTag:19],[YLUserToolManager getTextTag:20],[YLUserToolManager getTextTag:21]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:22],[YLUserToolManager getTextTag:23]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:24]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:25]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:26]]];
    
    self.table_groupV.backgroundColor = UIColor.blackColor;
    [self.table_groupV registerNib:[UINib nibWithNibName:@"FYLSettingsListCell" bundle:nil] forCellReuseIdentifier:@"FYLSettingsListCell"];
//    [self.table_groupV registerClass:[FYLlocalArchiveTableViewCell class] forCellReuseIdentifier:@"FYLlocalArchiveTableViewCell"];
//    self.tableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
//    self.tableV.rowHeight = UITableViewAutomaticDimension;
//    self.tableV.estimatedRowHeight = 30;
    self.table_groupV.dataSource = self;
    self.table_groupV.delegate = self;
    [self.view addSubview:self.table_groupV];
    [self.table_groupV mas_makeConstraints:^(MASConstraintMaker *make) {
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
