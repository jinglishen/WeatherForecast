//
//  BTRCityInfo.m
//  WeatherForecast
//
//  Created by geek-group on 14-6-23.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import "City.h"

@implementation City

#pragma mark 初始化一个城市
- (id)initWithCityName:(NSString *)newCityName cityID:(NSString *)newCityID weatherCode:(NSString *)newWeatherCode
{
    City *city       = [[City alloc]init];
    city.cityName    = newCityName;
    city.cityID      = newCityID;
    city.weatherCode = newWeatherCode;
    city.cityLetter  = [[NSMutableString alloc]init];;
    return city;
}

@end
