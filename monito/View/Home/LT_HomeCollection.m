//
//  LT_HomeCollection.m
//  monito
//  首页collection View
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//
#define With self.frame.size.width
#import "LT_HomeCollection.h"
#import "PrefixHeader.pch"

@implementation LT_HomeCollection
{
    NSArray * arr;
    NSArray * imageAy;
}
-(instancetype)initWithFrame:(CGRect)frame{
    //创建布局类对象
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    //cell大小
    layOut.itemSize =CGSizeMake((With-5)/4, (With-5)/4);
    //滚动方向，垂直或水平
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    self =[super initWithFrame:frame collectionViewLayout:layOut];
   
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
-(void)datasourcetittle:(NSArray *)tittle andimge:(NSArray *)image{
    arr = tittle;
    imageAy =image;
    [self reloadData];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%@", arr[indexPath.row]];
    cell.Imageiv.image = [UIImage imageNamed:imageAy[indexPath.row]];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((With-5)/4, (With-5)/4);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
//集合视图的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * classAy = @[@"fatherViewController",@"LT__sampleViewController",@"fatherViewController",@"LT_laboratoryViewController",@"LT_affairsViewController",@"fatherViewController",@"fatherViewController",@"LT_queryViewController",@"fatherViewController",@"LT_examiningViewController",@"LT_parsingViewController",@"LT_GISViewController",@"LT_equipmentViewController",@"LT__substanceViewController",@"LT_inventoryViewController",@"LT_settingsViewController"];
    Class class = NSClassFromString(classAy[indexPath.row]);
    UIViewController * con = [[class alloc]init];
//    fatherViewController * con =[[fatherViewController alloc]init];
    [[self viewController].navigationController pushViewController:con animated:YES];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    [self viewController].navigationItem.backBarButtonItem = backItem;
    con.title = arr[indexPath.row];
}
//获取父视图
- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
