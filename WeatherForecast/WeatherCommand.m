//
//  WeatherCommand.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-24.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "WeatherCommand.h"
#import "SBJson.h"


@implementation WeatherCommand

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
    //中国天气网解析地址；
    //NSString *path=@"http://m.weather.com.cn/atad/101230201.html";
    NSString *path = [[NSString alloc]init];
    //将城市代码替换到天气解析网址cityNumber部分！
    path = [path stringByReplacingOccurrencesOfString:@"cityNumber" withString:weatherID];
    path = [NSString stringWithFormat:@"http://m.weather.com.cn/atad/%@.html", ([weatherID isEqualToString:nil]? @"101250101" : weatherID)];
    NSLog(@"path:%@",path);
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:path]];
    
    request.delegate = self;
    //开始请求链接
    [request startAsynchronous];
    //return nil;
//    NSURL *url = [NSURL URLWithString:path];
//    NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"weatherInfo : %@", jsonString);
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"请求开始了");
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"请求结束了");
    //responseString就是response响应的正文内容.(即网页的源代码)
    NSString *str = request.responseString;
    NSLog(@"str is ---> %@",str);
    
    SBJsonParser *json = [[SBJsonParser alloc] init];
    NSDictionary *dic  = [json objectWithString:str];
    NSLog(@"dic = %@",dic);
    
    NSDictionary *weatherinfo = [dic objectForKey:@"weatherinfo"];
    NSLog(@"weatherinfo  =  %@",weatherinfo);
    
//    //当前城市
//    NSString *city    = [weatherinfo objectForKey:@"city"];
//    cityLabel.text    = city;
//    //日期
//    NSString *date    = [weatherinfo objectForKey:@"date_y"];
//    dateLabel.text    = date;
//    //星期
//    NSString *week    = [weatherinfo objectForKey:@"week"];
//    weekLabel.text    = week;
//    //城市天气编码
//    NSString *cityid  = [weatherinfo objectForKey:@"cityid"];
//    cityidLabel.text  = cityid;
//    //当前温度
//    NSString *temp    = [weatherinfo objectForKey:@"temp1"];
//    tempLabel.text    = temp;
//    //当前天气状况
//    NSString *weather = [weatherinfo objectForKey:@"weather1"];
//    weatherLabel.text = weather;
    
    //更多细节请参考 输出框自己添加！
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败了");
}

@end
