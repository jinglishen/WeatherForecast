//
//  Weather.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-24.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

typedef enum{
    WeatherClearType               = 0,//晴天
    WeatherPartlySunnyType         = 1,//多云
    WeatherOverCastType            = 2,//阴
    WeatherFogType                 = 3,//雾
    WeatherRainAndSnowType         = 4,//雨夹雪
    WeatherWindType                = 5,//风
    WeatherScatterShowerType       = 6,//零星阵雨
    WeatherShowerType              = 7,//阵雨
    WeatherThunderStormType        = 8,//雷阵雨
    WeatherScatterThunderStormType = 9,//零星雷阵雨
    WeatherLightRainType           = 10,//小雨
    WeatherRainType                = 11,//中雨或者大雨
    WeatherStormType               = 12,//暴雨或者特大暴雨
    WeatherScatterSnowType         = 13,//阵雪
    WeatherFlurryType              = 14,//小雪
    WeatherIceSnowType             = 15,//中雪
    WeatherSnowType                = 16,//大雪
    WeatherIceType                 = 17,//暴雪
    WeatherHailType                = 18,//冰雹类的天气
} WeatherType;

@property (nonatomic) WeatherType weatherType;//当前天气
@property (nonatomic) UIImage     *weatherImage;//天气图片
@property (nonatomic) NSString    *wind;//风向
@property (nonatomic) NSString    *weather;//天气信息
@property (nonatomic) NSString    *date_y;//日期
@property (nonatomic) NSString    *week;//星期几
@property (nonatomic) NSString    *temp;//温度
@property (nonatomic) NSString    *tempF;

@end
