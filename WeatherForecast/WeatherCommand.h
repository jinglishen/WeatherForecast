//
//  WeatherCommand.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-24.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@class Weather;

@interface WeatherCommand : NSObject<ASIHTTPRequestDelegate>

@property (nonatomic)NSMutableArray *weatherInfoList;//天气信息数组

/**
 *  通过IP获取当前所在的的城市WeatherID
 *
 *  @return 返回获取到的weatherID
 */
- (NSString *)autoGetCityWeatherID;

/**
 *  通过WeatherID获取天气信息
 *
 *  @param weatherID 用于获取天气信息
 */
- (void)getWeatherInfo:(NSString *)weatherID;

@end
