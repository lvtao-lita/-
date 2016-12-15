//
//  NetworkRequests.m
//  monito
//
//  Created by lvtao on 16/11/28.
//  Copyright © 2016年 lvtao. All rights reserved.
//

#import "NetworkRequests.h"
#import "AFNetworking.h"
#import "NSString+subAppend.h"
@implementation NetworkRequests
+(void)requestWithparameters:(NSDictionary *)dic andWithURL:(NSString *)url Success:(void (^)(NSDictionary * dic))success failure:(void (^)(NSDictionary * dic))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask * task = [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString * json = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSString * jsonstr = [json substring:json];
        NSError* err = nil;
        NSData * jsonData = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if ([rootDic[@"success"]isEqualToString:@"true"]) {
            success(rootDic);
        }else{
            failure(rootDic);
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary * dic = @{@"msg":@"网络连接异常"};
        failure(dic);
        
        
    }];
    [task resume];

}

+(void)requesPasswordtWithparameters:(NSDictionary *)dic andWithURL:(NSString *)url Success:(void (^)(NSString *password))success failure:(void (^)(NSString *str))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask * task = [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"请求进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(string);
        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *str = @"网络出现小情绪了";
        failure(str);
        //            [SVProgressHUD dismiss];
        
    }];
    [task resume];
    
}

+(void)requestWithParameters:(NSDictionary *)parameters image:(NSData *)image url:(NSString *)url Success:(void (^)())success failure:(void (^)())failure
 {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:image name:@"file" fileName:fileName mimeType:@"/image.jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"没进success");
        failure();
    }];
    
}

@end
