//
//  FYLSoundListViewController.m
//  CalculatorFYL
//
//  Created by tianhao on 2024/4/29.
//

#import "FYLSoundListViewController.h"
#import "FYLSettingsListCell.h"
#import <AVFoundation/AVFoundation.h>

@interface FYLSoundListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property(nonatomic,copy)NSString * indexSel;
@end

@implementation FYLSoundListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = [YLUserToolManager getTextTag:13];
    [self creatUI];
    [self download];
    
    // Do any additional setup after loading the view.
}

-(void)download{
    NSString * selIndex = [[NSUserDefaults standardUserDefaults]objectForKey:FYL_SoundType];
    if (IS_VALID_STRING(selIndex)) {
        self.indexSel = selIndex;
        [self.table_groupV reloadData];
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
    if (section == 0) {
        return 0.01;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    V_root.backgroundColor = UIColor.clearColor;
    if (section == 1) {
        UILabel * L_title = [[UILabel alloc]init];
        L_title.text = [YLUserToolManager getTextTag:36];
        L_title.font = Px22Font;
        L_title.textColor = rgba(55, 55, 55, 1);
        [V_root addSubview:L_title];
        [L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(V_root).mas_offset(10);
            make.top.and.bottom.mas_equalTo(V_root);
            make.right.mas_equalTo(V_root).mas_offset(-80);
        }];
        UIImageView * M_icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [V_root addSubview:M_icon];
        [M_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(V_root);
            make.right.mas_equalTo(V_root).mas_offset(-10);
        }];
    }
    return V_root;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * V_root = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, .01)];
    V_root.backgroundColor = UIColor.blackColor;
    return V_root;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FYLSettingsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FYLSettingsListCell" forIndexPath:indexPath];
    [cell changeUIType:6];
    if (IS_VALID_STRING(self.indexSel)) {
        switch (self.indexSel.intValue) {
            case 0:
                {
                    if (indexPath.section ==0&&indexPath.row == 0) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 1:
                {
                    if (indexPath.section ==0&&indexPath.row == 1) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 2:
                {
                    if (indexPath.section ==0&&indexPath.row == 2) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 3:
                {
                    if (indexPath.section ==0&&indexPath.row == 3) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 4:
                {
                    if (indexPath.section ==0&&indexPath.row == 4) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 5:
                {
                    if (indexPath.section ==0&&indexPath.row == 5) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 6:
                {
                    if (indexPath.section ==0&&indexPath.row == 6) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 7:
                {
                    if (indexPath.section ==1&&indexPath.row == 0) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            case 8:
                {
                    if (indexPath.section ==1&&indexPath.row == 1) {
                        cell.M_sel.hidden = NO;
                    }else{
                        cell.M_sel.hidden = YES;
                    }
                }
                break;
            default:
                break;
        }
    }
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
   
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.indexSel = [NSString stringWithFormat:@"%ld",indexPath.row];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table_groupV reloadData];
        });
        if(indexPath.row == 1){//默认
            [self playSoundEffect:@"click1.wav"];
        }else if (indexPath.row == 2){//水滴
            [self playSoundEffect:@"shuidi.mp3"];
        }else if (indexPath.row == 3){//清脆
            [self playSoundEffect:@"qingcui.wav"];
        }else if (indexPath.row == 4){//鼓声
            [self playSoundEffect:@"click.wav"];
        }else if (indexPath.row == 5){//木质
            [self playSoundEffect:@"dada.mp3"];
        }else if (indexPath.row == 6){//钢琴
            [self playSoundEffect:@"gang_two.mp3"];
        }
    }else{
        self.indexSel = [NSString stringWithFormat:@"%ld",indexPath.row+7];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table_groupV reloadData];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(indexPath.row == 0){//中文
                [self playSoundEffect:@"one.mp3"];
                [self playSoundEffect:@"jia.mp3"];
                [self playSoundEffect:@"two.mp3"];
                [self playSoundEffect:@"dengyu.mp3"];
                [self playSoundEffect:@"three.mp3"];
            }else if (indexPath.row == 1){//英文
                [self playSoundEffect:@"one_en.mp3"];
                [self playSoundEffect:@"jia_en.mp3"];
                [self playSoundEffect:@"two_en.mp3"];
                [self playSoundEffect:@"dengyu_en.mp3"];
                [self playSoundEffect:@"three_en.mp3"];
                
                
            }
        });
        
        
        
    }
   
    [[NSUserDefaults standardUserDefaults]setObject:self.indexSel forKey:FYL_SoundType];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)creatUI{
    
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:29],[YLUserToolManager getTextTag:30],[YLUserToolManager getTextTag:31],[YLUserToolManager getTextTag:32],[YLUserToolManager getTextTag:33],[YLUserToolManager getTextTag:34],[YLUserToolManager getTextTag:35]]];
    [self.dataArray addObject:@[[YLUserToolManager getTextTag:37],[YLUserToolManager getTextTag:38]]];
    
    self.table_groupV.backgroundColor = UIColor.blackColor;
    [self.table_groupV registerNib:[UINib nibWithNibName:@"FYLSettingsListCell" bundle:nil] forCellReuseIdentifier:@"FYLSettingsListCell"];

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
