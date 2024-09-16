//
//  YLDIYEditBoxListView.m
//  JoyLight
//
//  Created by tianhao on 2023/7/5.
//

#import "YLDIYEditBoxListView.h"
#define Height_cell 60
@implementation YLDIYEditBoxListView
- (instancetype)initWithFrame:(CGRect)frame withIndexListCount:(NSInteger )indexCount withArrTitle:(NSArray *)arrTitle{
    
    if (self = [super initWithFrame:frame]) {
        self.indexCount = indexCount;
        [self.dataArray addObjectsFromArray:arrTitle];
        [self creatUIType:indexCount];
    }
    return self;
    
}
-(void)creatUIType:(NSInteger)indexCount{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.backgroundColor = UIColor.clearColor;
    self.alpha = 0;
    UIView *subBackView = [[UIView alloc]init];
    subBackView.backgroundColor = LineBackgroundColor;
    subBackView.layer.cornerRadius = 15;
    subBackView.layer.masksToBounds = YES;
   
    [self addSubview:self.backView];
    [self.backView addSubview:self.topButton];
    [self.backView addSubview:subBackView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.backView);
    }];
    
    if(self.indexCount == 3){
        [subBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView).offset(0);
            make.right.equalTo(self.backView).offset(-0);
            make.height.equalTo(@(Height_cell*indexCount+(indexCount-1)*0.5));
            make.bottom.mas_equalTo(self.backView).mas_offset(-(YX_TabbarSafetyZone));
        }];
        [subBackView addSubview:self.B_sort];
        [self.B_sort setTitle:NSLocalizedString(@"edit", nil) forState:UIControlStateNormal];
        [self.B_sort mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(subBackView).mas_offset(0);
            make.left.mas_equalTo(subBackView);
            make.right.mas_equalTo(subBackView);
            make.height.mas_equalTo(@(Height_cell));
        }];
        [subBackView addSubview:self.B_delete];
        [self.B_delete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.B_sort.mas_bottom).mas_offset(0.5);
            make.left.mas_equalTo(self.B_sort);
            make.size.mas_equalTo(self.B_sort);
        }];
        [subBackView addSubview:self.B_cancel];
        [self.B_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.B_delete.mas_bottom).mas_offset(0.5);
            make.left.mas_equalTo(self.B_sort);
            make.size.mas_equalTo(self.B_sort);
        }];
    }else{
        
        [subBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView).offset(0);
            make.right.equalTo(self.backView).offset(-0);
            make.height.equalTo(@(Height_cell*self.dataArray.count+(self.dataArray.count-1)*1+5));
            make.bottom.mas_equalTo(self.backView).mas_offset(0);
        }];
        [subBackView addSubview:self.B_sort];
        [self.dataArray enumerateObjectsUsingBlock:^(NSString *   _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton * btn = [UIButton buttonWithType:0];
            [btn setTitle:obj forState:(UIControlStateNormal)];
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:18];
            btn.backgroundColor = UIColor.whiteColor;
            [btn addTarget:self action:@selector(didSelectedClickedSort:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.tag = idx;
            if (self.dataArray.count == idx+1) {
                btn.frame = CGRectMake(0, Height_cell * idx+1*idx+5, kScreenWidth, Height_cell);
            }else{
                btn.frame = CGRectMake(0, Height_cell * idx+1*idx, kScreenWidth, Height_cell);
               
            }
            
            [subBackView addSubview:btn];
            
            
        }];
        
     
        
        
    }
}

#pragma mark -- 取消 or 确定
///排序
-(void)didSelectedClickedSort:(UIButton *)btn{
    if (self.didSelectedClickedBtnBlock) {
        self.didSelectedClickedBtnBlock(btn.tag);
    }
    [self dissMiss];
    
}
///复制
-(void)didSelectedClickedCopy:(UIButton *)btn{
    if(self.didSelectedClickedBtnBlock){
        self.didSelectedClickedBtnBlock(1);
    }
    [self dissMiss];
    
}
///删除
-(void)didSelectedClickedDelete:(UIButton *)btn{
    if(self.didSelectedClickedBtnBlock){
        self.didSelectedClickedBtnBlock(2);
    }
    [self dissMiss];
}
///取消
-(void)didSelectedClickedCancel:(UIButton *)btn{
//    if(self.didSelectedClickedBtnBlock){
//        self.didSelectedClickedBtnBlock(3);
//    }
    [self dissMiss];
}

#pragma mark -- 函数

- (void)show{
    UIWindow *alertWindow = [UIApplication sharedApplication].keyWindow;
    [alertWindow addSubview:self];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)dissMiss{
  
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScreenHeight);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark -- 懒加载
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = UIColor.clearColor;
    }
    return _backView;
}

- (UIButton *)B_sort{
    if (!_B_sort) {
        _B_sort = [[UIButton alloc]init];
        [_B_sort setTitle:NSLocalizedString(@"Sort", nil) forState:(UIControlStateNormal)];
        [_B_sort setTitleColor:rgba(255, 255, 255, 1) forState:UIControlStateNormal];
        _B_sort.titleLabel.font = [UIFont systemFontOfSize:18];
        _B_sort.backgroundColor = [UIColor jk_colorWithHexString:DiyBGRGBValue];
        [_B_sort addTarget:self action:@selector(didSelectedClickedSort:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _B_sort;
}

- (UIButton *)B_copy{
    if (!_B_copy) {
        _B_copy = [[UIButton alloc]init];
        [_B_copy setTitle:NSLocalizedString(@"Copy", nil) forState:(UIControlStateNormal)];
        [_B_copy setTitleColor:rgba(255, 255, 255, 1) forState:UIControlStateNormal];
        _B_copy.titleLabel.font = [UIFont systemFontOfSize:18];
        _B_copy.backgroundColor = [UIColor jk_colorWithHexString:DiyBGRGBValue];
        [_B_copy addTarget:self action:@selector(didSelectedClickedCopy:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _B_copy;
}

- (UIButton *)B_delete{
    if (!_B_delete) {
        _B_delete = [[UIButton alloc]init];
        [_B_delete setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateNormal];
        [_B_delete setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        _B_delete.titleLabel.font = [UIFont systemFontOfSize:18];
        _B_delete.backgroundColor = [UIColor jk_colorWithHexString:DiyBGRGBValue];
        [_B_delete addTarget:self action:@selector(didSelectedClickedDelete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _B_delete;
}

- (UIButton *)B_cancel{
    if (!_B_cancel) {
        _B_cancel = [[UIButton alloc]init];
        [_B_cancel setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_B_cancel setTitleColor:rgba(255, 255, 255, 1) forState:UIControlStateNormal];
        _B_cancel.titleLabel.font = Px28Font;
        _B_cancel.backgroundColor = [UIColor jk_colorWithHexString:DiyBGRGBValue];
        [_B_cancel addTarget:self action:@selector(didSelectedClickedCancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _B_cancel;
}



- (UIButton *)topButton{
    if (!_topButton) {
        _topButton = [[UIButton alloc]init];
        [_topButton addTarget:self action:@selector(dissMiss) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _topButton;
}


@end
