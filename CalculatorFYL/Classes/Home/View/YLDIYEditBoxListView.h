//
//  YLDIYEditBoxListView.h
//  JoyLight
//
//  Created by tianhao on 2023/7/5.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLDIYEditBoxListView : BaseView
- (instancetype)initWithFrame:(CGRect)frame withIndexListCount:(NSInteger )indexCount withArrTitle:(NSArray *)arrTitle;
@property(nonatomic,assign)NSInteger indexCount;
///rootview
@property(nonatomic,strong)UIView * backView;
///顶部背景按钮
@property(nonatomic,strong)UIButton *topButton;
///排序
@property(nonatomic,strong)UIButton *B_sort;
///复制
@property(nonatomic,strong)UIButton *B_copy;
///删除
@property(nonatomic,strong)UIButton *B_delete;
///取消
@property(nonatomic,strong)UIButton *B_cancel;
@property (nonatomic, copy) void (^didSelectedClickedBtnBlock)(NSInteger indexType);

@end

NS_ASSUME_NONNULL_END
