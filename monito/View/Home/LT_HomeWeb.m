//
//  LT_HomeWeb.m
//  monito
//  首页Web View
//  Created by lvtao on 16/11/21.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "LT_HomeWeb.h"

@implementation LT_HomeWeb

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView.scrollEnabled = NO;
    }
    return self;
}
-(void)loadHomeWev:(NSString *)url{
    NSURL * urlstring = [NSURL URLWithString:url];
    NSURLRequest * request = [NSURLRequest requestWithURL:urlstring];
    [self loadRequest:request];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
