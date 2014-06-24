//
//  BTRMainViewController.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-21.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class CityXML, Weather, WeatherCommand;

@interface BTRMainViewController : UIViewController

@property (nonatomic) NSMutableArray          *cities;//全国城市详细信息
@property (nonatomic) NSMutableArray          *tempCities;//搜索出来的城市数组
@property (nonatomic) CityXML                 *cityXML;//解析全国城市信息XML对象
@property (nonatomic) NSMutableArray          *showCities;//要显示天气的城市weatherID
@property (nonatomic) NSMutableArray          *weatherInfoARR;//天气详情数组
@property (nonatomic) WeatherCommand          *weatherComm;//天气控制对象（获取天气信息）

@property (nonatomic) MPMoviePlayerController *movieController;//背景视频
@property (nonatomic) UILabel                 *lbFutureWeatherFirst;//未来天气第一天
@property (nonatomic) UIImageView             *firstImgView;//未来天气第一天天气图标
@property (nonatomic) UILabel                 *lblFutureWeatherTempFirst;//未来天气第一天温度
@property (nonatomic) UILabel                 *lbFutureWeatherSecond;//未来天气第二天
@property (nonatomic) UIImageView             *secondImgView;//未来天气第二天天气图标
@property (nonatomic) UILabel                 *lblFutureWeatherTempSecond;//未来天气第二天温度
@property (nonatomic) UILabel                 *lbFutureWeatherThird;//未来天气第三天
@property (nonatomic) UIImageView             *thirdImgView;//未来天气第三天天气图标
@property (nonatomic) UILabel                 *lblFutureWeatherTempThird;//未来天气第三天温度
@property (nonatomic) UILabel                 *lbFutureWeatherFourth;//未来天气第四天
@property (nonatomic) UIImageView             *fourthImgView;//未来天气第四天天气图标
@property (nonatomic) UILabel                 *lblFutureWeatherTempFourth;//未来天气第四天温度

@end
