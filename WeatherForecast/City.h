//
//  BTRCityInfo.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-23.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic) NSString              *cityName;//城市名
@property (nonatomic) NSString              *cityID;//城市ID
@property (nonatomic) NSString              *weatherCode;//城市天气ID
@property (nonatomic) NSMutableString       *cityLetter;//城市拼音缩写


/**
 *  实例化一个城市
 *
 *  @param newCityName      城市名
 *  @param newCityID        城市ID
 *  @param newCityWeatherID 城市天气ID
 *  @param newCityLetter    城市拼音缩写
 */
- (id)initWithCityName:(NSString *)newCityName cityID:(NSString *)newCityID weatherCode:(NSString *)newWeatherCode;

@end
