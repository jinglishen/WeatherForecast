//
//  BTRMainViewController.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-21.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class CityXML;

@interface BTRMainViewController : UIViewController

@property (nonatomic) MPMoviePlayerController *movieController;//背景视频
@property (nonatomic) NSMutableArray          *cities;//全国城市详细信息
@property (nonatomic) NSMutableArray          *tempCities;//搜索出来的城市数组
@property (nonatomic) CityXML                 *cityXML;//解析全国城市信息XML对象

@property (weak, nonatomic) IBOutlet UILabel *cityWeatherIDLB;

@property (weak, nonatomic) IBOutlet UIButton *seachCityWeatherIDBTN;

@end
