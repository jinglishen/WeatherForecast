//
//  WeatherCommand.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-24.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "WeatherCommand.h"
#import "SBJson.h"
#import "WeatherAnalysis.h"

static WeatherCommand *instance;

@implementation WeatherCommand
@synthesize weatherAnalysis, weatherInfoList;

+ (WeatherCommand *)sharedInstaced
{
    if(instance==nil)
    {
        instance=[[WeatherCommand alloc] init];
    }
    return instance;
}

#pragma mark 通过IP地址获取当前所在的城市
- (NSString *)autoGetCityWeatherID
{
    //解析网址通过ip 获取城市天气代码
    NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
    
    //定义一个NSError对象，用于捕获错误信息
    NSError *error;
    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    NSLog(@"------------%@",jsonString);
    
    // 得到城市代码字符串，截取出城市代码
    NSString *Str;
    //截取出的城市代码
    NSString *weatherID;
    for (int i = 0; i<=[jsonString length]; i++)
    {
        for (int j = i+1; j <=[jsonString length]; j++)
        {
            Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
            if ([Str isEqualToString:@"id"]) {
                if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
                    weatherID = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
                    NSLog(@"***%@***",weatherID);
                }
            }
        }
    }
    return weatherID;
}

#pragma mark 通过weatherID获取天气详情
- (void)getWeatherInfo:(NSString *)weatherID
{
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[self getWeatherURL:weatherID]];
    request.delegate = self;
    //开始请求链接
    [request startAsynchronous];
}

/**
 *  通过WeatherID获取城市天气的网络路劲
 *
 *  @param weatherID 天气ID
 *
 *  @return 获取天气的网络地址
 */
- (NSURL *)getWeatherURL:(NSString *)weatherID
{
    NSString *url = [NSString stringWithFormat:@"http://m.weather.com.cn/atad/%@.html", ([weatherID isEqualToString:nil]? @"101250101" : weatherID)];
    NSLog(@"weatherURL = %@", url);
    return [NSURL URLWithString:url];
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"请求开始了");
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    weatherInfoList = [[NSMutableArray alloc]init];
    weatherAnalysis = [WeatherAnalysis sharedInstaced];
    NSLog(@"请求结束了");
    //responseString就是response响应的正文内容.(即网页的源代码)
    NSString *str = request.responseString;
    NSLog(@"str is ---> %@",str);
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSDictionary *dic  = [json objectWithString:str];
    NSLog(@"dic = %@",dic);
    
    NSDictionary *weatherinfo = [dic objectForKey:@"weatherinfo"];
    NSLog(@"weatherinfo  =  %@",weatherinfo);
    weatherInfoList = [weatherAnalysis getWeatherInfo:dic];
    NSLog(@"weatherinfo = %@", weatherInfoList);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败了");
}

@end
