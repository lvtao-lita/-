//
//  LT_HomeCollection.h
//  monito
//
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LT_HomeCollection : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate>
-(void)datasourcetittle:(NSArray *)tittle andimge:(NSArray *)image;
@end
