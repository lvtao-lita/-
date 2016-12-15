//
//  fatherViewController.h
//  monito
//
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "inquireView.h"
#import "mytableView.h"
@interface fatherViewController : UIViewController
@property(strong,nonatomic)  mytableView * tableView;
@property(strong,nonatomic) inquireView * inqView;
@end
