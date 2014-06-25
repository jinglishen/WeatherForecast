//
//  WeatherAnalysis.h
//  WeatherForecast
//
//  Created by geek-group on 14-6-25.
//  Copyright (c) 2014年 Benster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherAnalysis : NSObject

/**
 *  单例模式
 *
 *  @return 天气数据解析对象
 */
+ (WeatherAnalysis *)sharedInstaced;

/**
 *  把获取到的JSON数据解析成对象
 *
 *  @param paramDict JSON字典
 *
 *  @return 解析完的数据
 */
-(NSMutableArray *)getWeatherInfo:(NSDictionary *)paramDict;

@end
