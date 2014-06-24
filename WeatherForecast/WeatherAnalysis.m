//
//  WeatherAnalysis.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-25.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "WeatherAnalysis.h"
#import "Weather.h"

static WeatherAnalysis *instance;

@implementation WeatherAnalysis

+(WeatherAnalysis *)sharedInstaced
{
    if(instance==nil)
    {
        instance=[[WeatherAnalysis alloc] init];
    }
    return instance;
}

#pragma mark 获取当前是星期几
- (NSString *)getWeekByWeek:(NSString *)week andIndex:(int)index
{
    NSArray *weeklist=[NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    NSUInteger weekIndex=[weeklist indexOfObject:week];
    return [weeklist objectAtIndex:(weekIndex+index)%7];
}

#pragma mark 判断是否是黑夜时间
-(BOOL)isNight
{
    NSDate *startDate=[NSDate date];
    
    NSCalendar *chineseCalendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags=NSHourCalendarUnit;
    NSDateComponents *dateComponents=[chineseCalendar components:unitFlags fromDate:startDate];
    if(([dateComponents hour]>=0&&[dateComponents hour]<=5)||([dateComponents hour]>=20&&[dateComponents hour]<=24))
    {
        return YES;
    }
    return NO;
}

#pragma mark 根据获取天气的关键字返回相应的图片名称
-(NSString *)getImageNameFromString:(NSString *)weather
{
    if(weather==nil)
    {
        NSLog(@"传入的天气名称为nil");
        return nil;
    }
    NSString *weatherString=[NSString stringWithString:weather];
    NSUInteger location=[weatherString rangeOfString:@"转"].location;
    if(location<100)
    {
        weatherString=[weatherString substringFromIndex:location+1];
    }
    if([weatherString isEqualToString:@"晴"])
    {
        return @"clear";
    }
    
    if([weatherString isEqualToString:@"多云"])
    {
        return @"cloudy";
    }
    
    if([weatherString isEqualToString:@"阴"])
    {
        return @"overcast";
    }
    
    if([weatherString isEqualToString:@"雾"])
    {
        return @"fog";
    }
    
    //------------雨
    if([weatherString isEqualToString:@"阵雨"])
    {
        return @"showers";
    }
    
    if([weatherString isEqualToString:@"雷阵雨"])
    {
        return @"thunderstorm";
    }
    
    if([weatherString isEqualToString:@"雨夹雪"])
    {
        return @"rainandsnow";
    }
    
    if([weatherString isEqualToString:@"小雨"])
    {
        return @"lightrain";
    }
    
    if(([weatherString isEqualToString:@"中雨"])||([weatherString isEqualToString:@"大雨"]))
    {
        return @"rain";
    }
    
    if(([weatherString isEqualToString:@"暴雨"])||([weatherString isEqualToString:@"大暴雨"])||([weatherString isEqualToString:@"特大暴雨"]))
    {
        return @"storm";
    }
    
    //-------------雪
    if([weatherString isEqualToString:@"阵雪"])
    {
        return @"scatteredsnow";
    }
    
    if([weatherString isEqualToString:@"小雪"])
    {
        return @"flurries";
    }
    
    if([weatherString isEqualToString:@"中雪"])
    {
        return @"icesnow";
    }
    
    if([weatherString isEqualToString:@"大雪"])
    {
        return @"snow";
    }
    
    if([weatherString isEqualToString:@"暴雪"])
    {
        return @"icy";
    }
    return nil;
}

#pragma mark 依次可以获取5天的天气信息
-(NSMutableArray *)getWeatherInfo:(NSDictionary *)paramDict
{
    if(paramDict==nil)
    {
        NSLog(@"传入的天气信息Data为nil");
        return nil;
    }
    NSMutableArray *weatherlist=[[NSMutableArray alloc] init];
    id weatherInfo=[paramDict objectForKey:@"weatherinfo"];
    if([weatherInfo isKindOfClass:[NSDictionary class]])
    {
        for(int i=0;i<5;i++)
        {
            Weather *city=[[Weather alloc] init];
            
            id cityID=[weatherInfo objectForKey:@"cityid"];
            if([cityID isKindOfClass:[NSString class]])
            {
                city.weatherID=[cityID description];
            }
            
            id cityName=[weatherInfo objectForKey:@"city"];
            if([cityName isKindOfClass:[NSString class]])
            {
                city.cityName=[cityName description];
            }
            
            id date_y=[weatherInfo objectForKey:@"date_y"];
            if([date_y isKindOfClass:[NSString class]])
            {
                city.date_y=date_y;
            }
            
            id week=[weatherInfo objectForKey:@"week"];
            if([week isKindOfClass:[NSString class]])
            {
                city.week=[self getWeekByWeek:week andIndex:i];
            }
            
            id temp=[weatherInfo objectForKey:[NSString stringWithFormat:@"temp%d",i+1]];
            if([temp isKindOfClass:[NSString class]])
            {
                city.temp=[temp description];
            }
            
            id weather=[weatherInfo objectForKey:[NSString stringWithFormat:@"weather%d",i+1]];
            if([weather isKindOfClass:[NSString class]])
            {
                city.weather=[weather description];
            }
            if(city.weather!=nil)
            {
                NSString *weatherImgName=[self getImageNameFromString:city.weather];
                NSString *nWeatherImgName=nil;
                NSFileManager *fileManager=[NSFileManager defaultManager];
                if([self isNight])
                {
                    nWeatherImgName=[NSString stringWithFormat:@"n_%@",weatherImgName];
                    NSString *imgPath=[[NSBundle mainBundle] pathForResource:nWeatherImgName ofType:@"png"];
                    
                    if([fileManager fileExistsAtPath:imgPath])
                    {
                        city.weatherImage=[UIImage imageNamed:nWeatherImgName];
                    }
                    else
                    {
                        city.weatherImage=[UIImage imageNamed:@"clear.png"];
                    }
                    NSString *vedioPath=[[NSBundle mainBundle] pathForResource:nWeatherImgName ofType:@"mp4"];
                    if([fileManager fileExistsAtPath:vedioPath])
                    {
                        city.videoName=[NSString stringWithFormat:@"%@.mp4",nWeatherImgName];
                    }
                    else
                    {
                        city.videoName=@"clear.mp4";
                    }
                    city.effectImg=nWeatherImgName;
                }
                else
                {
                    NSString *imgPath=[[NSBundle mainBundle] pathForResource:weatherImgName ofType:@"png"];
                    if([fileManager fileExistsAtPath:imgPath])
                    {
                        city.weatherImage=[UIImage imageNamed:weatherImgName];
                    }
                    else
                    {
                        city.weatherImage=[UIImage imageNamed:@"clear.png"];
                    }
                    NSString *vedioPath=[[NSBundle mainBundle] pathForResource:weatherImgName ofType:@"mp4"];
                    if([fileManager fileExistsAtPath:vedioPath])
                    {
                        city.videoName=[NSString stringWithFormat:@"%@.mp4",weatherImgName];
                    }
                    else
                    {
                        city.videoName=@"clear.mp4";
                    }
                    city.effectImg=weatherImgName;
                }
                
                
                id wind=[weatherInfo objectForKey:[NSString stringWithFormat:@"wind%d",i+1]];
                if([wind isKindOfClass:[NSString class]])
                {
                    city.wind=[wind description];
                }
                
                id fl=[weatherInfo objectForKey:[NSString stringWithFormat:@"fl%d",i+1]];
                if([fl isKindOfClass:[NSString class]])
                {
                    city.windSpeed=[fl description];
                }
                [weatherlist addObject:city];
            }
        }
    }
    return weatherlist;
}

@end
