//
//  BaseView.h
//  DayBetter
//
//  Created by zhangzhen on 2022/4/14.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, strong)UICollectionViewFlowLayout *layOut;
@property(nonatomic, strong)NSMutableArray *dataArray;
- (void)addControls;// 添加控件

// 弹窗用
- (void)show;
- (void)dissMiss;
@end

NS_ASSUME_NONNULL_END
