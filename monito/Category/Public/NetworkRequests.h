//
//  NetworkRequests.h
//  monito
//
//  Created by lvtao on 16/11/28.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkRequests : NSObject
#pragma mark - 接口请求
+(void)requestWithparameters:(NSDictionary *)dic andWithURL:(NSString *)url Success:(void (^)(NSDictionary * dic))success failure:(void (^)(NSDictionary * dic))failure;
#pragma mark - 图片上传
+(void)requestWithParameters:(NSDictionary *)parameters image:(NSData *)image url:(NSString *)url Success:(void (^)())success failure:(void (^)())failure;
#pragma mark - 密码加密请求
+(void)requesPasswordtWithparameters:(NSDictionary *)dic andWithURL:(NSString *)url Success:(void (^)(NSString *password))success failure:(void (^)(NSString *str))failure;
@end
